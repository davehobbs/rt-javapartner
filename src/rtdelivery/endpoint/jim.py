import logging
import os
from pathlib import Path
from rtdelivery.config import load_config, dry_run, environment
from rtdelivery.threading import threaded_upload
from rtdelivery.transfer import FtpUtils

from rtdelivery.endpoint.delivery.deliver import DeliveryReleasePlatform


class JIM:
    """Upload files to JIM
    - https://w3.hursley.ibm.com/java/jim/
    """

    def __init__(
        self,
        config_file: str = "delivery_config.yaml",
    ) -> None:
        self.name = "jim"
        self.config = load_config(config_file)["jim"]
        self.jim_user_name = self.config["user_name"]
        self.jim_password = self.config["password"]
        self.jim_server = self.config["server"]

        self.transfer_utils = FtpUtils(
            self.jim_server, self.jim_user_name, self.jim_password
        )

    def remove_staging(self, workspace_path: Path, pattern):
        for p in workspace_path.glob(pattern):
            p.unlink()

    def create_staging_file(self, workspace_path: Path, action: str):
        stage_marker = workspace_path / f"stage.{environment}.{action}"
        stage_marker.touch()
        return stage_marker

    def upload_release(self, drp: DeliveryReleasePlatform, action: str):
        """Attempt to upload the release to jim"""
        try:
            tgt_root = self.config["vendors"][drp.vendor]["binary_root_dir"]
            tgt_dir = Path(f"{tgt_root}/{drp.vr}/{drp.vrmf}/{drp.platform}")

            # remove any old staging files
            self.remove_staging(drp.workspace_path, "stage.*")
            self.transfer_utils.ftp_delete(tgt_dir / "stage.*")

            # upload the release
            logging.info(f"\tUploading to jim")
            logging.info(f"\tTarget path: {tgt_dir}")
            threaded_upload(self, drp.files(), tgt_dir)

            # indicate the upload has completed
            stage_marker = self.create_staging_file(drp.workspace_path, action)
            threaded_upload(self, [stage_marker], tgt_dir)
        except KeyError as e:
            logging.warning(f"Release {drp} setting not found in jim_config.yaml")

    def upload(self, src_file: Path, tgt_file: Path, overwrite: bool = False) -> None:
        """See threading.py threaded_upload"""
        if dry_run:
            prefix = "Would upload"
        else:
            prefix = self.transfer_utils.ftp_upload(src_file, tgt_file, overwrite)
        logging.info(f"\t{prefix} {tgt_file.name}")
