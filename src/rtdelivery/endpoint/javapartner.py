import hashlib
import json
import logging
from pathlib import Path

from rtdelivery.threading import threaded_download
from rtdelivery.artifactoryapi import ArtifactoryApi
from rtdelivery.endpoint.delivery.deliver import DeliveryReleasePlatform
from rtdelivery.config import load_config
from rtdelivery.vrmf import VersionInfo
from rtdelivery.utils import get_checksum


class JavaPartnerSite:
    def __init__(self, config="delivery_config.yaml", **kwargs) -> None:
        self.name = "jps"
        self.testing = kwargs["testing"] if "testing" in kwargs else False
        self.config = load_config(config)["jps"]
        # replace any environment parameters with keywords parameters
        api_params = {**self.config["credentials"], **kwargs}
        self.af_api = ArtifactoryApi(**api_params)

    def __str__(self):
        return f"{self.af_api}"

    def list_repo_files(self, repo: dict, src_dir: Path) -> list:
        """List all the file and directory info for the source directory"""
        files_info = []
        repo_name = repo["name"]
        repo_dir = repo["path"]
        release_dir = f"{repo_dir}{src_dir}"
        logging.debug(f"Full release path: {release_dir}")
        self.af_api.repository_name = repo_name
        r = self.af_api.file_list(release_dir, listFolders=True)
        if r.status_code == 404:
            logging.debug(f"Location {release_dir} does not exist")
        else:
            r.raise_for_status()
            files_info = json.loads(r.text).get("files", [])
            logging.debug(json.dumps(files_info, sort_keys=True, indent=4))
            # Add the full path into the file info
            for f in files_info:
                f["full_path"] = Path(f'{release_dir}{f["uri"]}')
        return files_info

    def map_repos_to_paths(self, src_dir: Path) -> dict[str, list]:
        """This checks a number of repos for paths that match the source directory.
        It returns a mapping of the repo name and file paths in that repo where matches are found."""
        repo_file_paths = {}
        for repo in self.config["repository_paths"]:
            repo_name = repo["name"]
            files_info = self.list_repo_files(repo, src_dir)
            repo_file_paths[repo_name] = files_info

        return repo_file_paths

    def latest_build_number(self, v: VersionInfo) -> str:
        """What is the highest numbered e.g b35 build in this directory"""
        src_dir = self.version_path(v)
        latest = ""
        for repo_name, files_info in self.map_repos_to_paths(src_dir).items():
            build_ids = [f["uri"] for f in files_info if f["folder"]]
            if build_ids:
                latest = max([latest, max(build_ids)])
            logging.debug(f"Max build for {repo_name} : {latest}")
        return self.build_number(latest)

    def version_path(self, v: VersionInfo):
        """Build the path to the Java Partner site version directory"""
        jp_stream_dir = self.stream_path(v.ver)
        jp_version_dir = self.version_dir(v.ver, v.rel, v.mod)
        return jp_stream_dir / jp_version_dir

    def build_path(self, v: VersionInfo, build_id: str) -> Path:
        """Build the relative path on the Java Partner site to the release"""

        # Fix up build_ids that aren't padded
        if "b" not in build_id and build_id.isdigit():
            build_id = f"b{build_id:0>2}"

        return self.version_path(v) / build_id

    def stream_path(self, ver: int) -> Path:
        """What is the directory the partner site uses for the major version"""
        if ver > 8:
            # modular 17.0.1 -> 17
            stream_dir = str(ver)
        else:
            # legacy 8u311 - > 1.8
            stream_dir = f"1.{ver}"
        return Path(stream_dir)

    def version_dir(self, ver: int, rel: int, mod: int) -> str:
        """What is the directory the partner site uses for the full version"""
        if ver > 8:
            # modular 17.0.1
            if mod:
                version_dir = f"{ver}.{rel}.{mod}"
            elif rel:
                version_dir = f"{ver}.{rel}"
            else:
                version_dir = f"{ver}"
        else:
            # legacy 8u311 from 8.0.311
            if mod:
                version_dir = str(ver) + "u" + str(mod)
            else:
                version_dir = str(ver)
        return version_dir

    def download(self, src_path: Path, tgt_path: Path):
        """Download a file from the partner site
        n.b the repo name should already be set before calling this function"""
        try:
            r = self.af_api.retrieve(src_path, tgt_path)
            r.raise_for_status()
            logging.info(f"\tDownloaded {src_path.name}")
        except Exception as e:
            logging.error(f"\tPartner site download error: {e}")

    def build_number(self, build_id: str) -> int:
        """Convert a build id e.g b34 or /b34 to a build number"""
        build_num = build_id
        if build_num.startswith("/"):
            build_num = build_num[1:]
        if build_num.startswith("b"):
            build_num = build_num[1:]
        if build_num.isdigit():
            return int(build_num)
        raise ValueError(f"{build_id} is not a valid build number")


class JavaPartnerSiteRelease:
    def __init__(self, drp: DeliveryReleasePlatform) -> None:
        self.jps = JavaPartnerSite()
        self.delivery_release = drp
        # Construct the corresponding path on the partner site
        self.release_path = self.jps.build_path(drp.version_info, drp.build_id)
        # List all the repo names and file information which match the release path
        self.repo_to_fileinfo = self.jps.map_repos_to_paths(self.release_path)

    def __str__(self):
        return f"{self.release_path}"

    def exists(self):
        """Does the release have any matching paths on the server"""
        return bool(self.repo_to_fileinfo)

    def latest_build(self):
        """Find the latest build for this vrmf"""
        return self.jps.latest_build_number(self.delivery_release.version_info)

    def list_files(self) -> list[Path]:
        """List the available files for a release"""
        logging.debug(f"Listing java partner site files")
        files = []
        for files_info in self.repo_to_fileinfo.values():
            files.extend([file_info["full_path"] for file_info in files_info])
        for f in files:
            logging.debug(f"\t{str(f.name)}")
        return files

    def download(
        self,
        src_paths: list,
        overwrite: bool = False,
    ):
        """Download files from the Java Partner Site. See utils.Downloader"""
        tgt_path = self.delivery_release.workspace_path
        logging.info(f"\tDownloading from {self.jps.name}")
        logging.info(f"\tSource path: {self.release_path}")
        logging.info(f"\tTarget path: {tgt_path}")
        logging.info(f"\tFiles: ")

        count_downloaded = 0  # How many files were downloaded
        count_filtered = 0  # How many files have already been downloaded

        for repo_name, files_info in self.repo_to_fileinfo.items():
            # Download the files which have been requested
            src_files = []
            for fi in files_info:
                if fi["full_path"] in src_paths:
                    src_files.append(fi)
                else:
                    logging.debug(f"\tSkipped {fi['uri']}")

            # Only download files which are missing
            if not overwrite:
                filtered = []
                for fi in src_files:
                    if not self.file_exists(fi, tgt_path):
                        filtered.append(fi)
                    else:
                        logging.info(f"\tExists {fi['uri']}")
                count_filtered += len(src_files) - len(filtered)
                src_files = filtered

            # If there are files remaining
            if src_files:
                # Run the downloads in parallel(ish)
                self.jps.af_api.repository_name = repo_name
                src_paths = [fi["full_path"] for fi in src_files]
                threaded_download(self.jps, src_paths, tgt_path)
                count_downloaded += len(src_files)

        if count_downloaded == 0 and count_filtered > 0:
            logging.info(f"\tAll files already downloaded")
        elif count_downloaded == 0:
            logging.info(f"\tNo files downloaded")

    def file_exists(self, fi: dict, tgt_dir: str):
        """Has the file already been downloaded"""
        src_path = fi["full_path"]
        src_sha1 = fi["sha1"]

        tgt_path = tgt_dir / src_path.name
        done = tgt_path.exists() and (src_sha1 == get_checksum(tgt_path, hashlib.sha1))
        if done:
            logging.debug(f"\tAlready downloaded {src_path.name}")
        return done
