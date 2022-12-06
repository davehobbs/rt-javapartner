#!/usr/local/bin/python
"""
A basic artifactory api utility class

Created on 24 Jan 2017

@author: hobbsd
"""

import hashlib
import json
from pathlib import Path
import shutil
import requests

from requests.packages.urllib3 import disable_warnings
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from rtdelivery.utils import get_checksum, timing

disable_warnings(InsecureRequestWarning)


class ArtifactoryApi:
    def __init__(
        self,
        artifactory_url,
        repository_name,
        username,
        password,
        verify=False,
    ):
        self.artifactory_url = artifactory_url
        self.repository_name = repository_name
        self.username = username
        self.password = password
        self.auth = (self.username, self.password)
        self.verify = verify

    def __str__(self):
        return f"{self.artifactory_url}"

    def url(self, target_file: Path):
        """Create a url based on the url to the repo"""
        path = f"{self.artifactory_url}/{self.repository_name}{target_file}"
        return path

    # @timing
    def retrieve(self, src_file: Path, target_file: Path):
        """Download a file"""
        path = self.url(src_file)
        r = requests.get(path, stream=True, auth=self.auth, verify=self.verify)
        if r:
            with target_file.open("wb") as f:
                shutil.copyfileobj(r.raw, f)
        return r

    def get_sha1_checksum(self, target_file: Path):
        """Find the sha1 checksum of a file"""
        tgt_sha1 = None
        r = self.get_file_info(target_file)
        if r.status_code == 200 and r.text:
            txt = json.loads(r.text)
            if "checksums" in txt:
                tgt_sha1 = txt["checksums"]["sha1"]
        return tgt_sha1

    def upload_new(self, src_file: Path, attributes: dict, target_file: Path):
        """Upload the file if it has changed."""

        # With no target assume the source and target layout is the same
        if not target_file:
            target_file = src_file

        # Use checksums to see if the file has changed
        upload = True
        src_sha1 = get_checksum(src_file, hashlib.sha1)
        tgt_sha1 = self.get_sha1_checksum(target_file)
        if src_sha1 == tgt_sha1:
            upload = False

        if upload:
            src_md5 = get_checksum(src_file, hashlib.md5)
            tgt_url = str(target_file) + ";" + self.url_properties(attributes)
            r = self.upload(src_file, src_md5, src_sha1, tgt_url)
            r.raise_for_status()

        return upload

    @timing
    def upload(
        self, src_file: Path, md5hash: str, sha1hash: str, target_url: str = None
    ):
        if not target_url:
            target_url = str(src_file.resolve())

        headers = {"X-Checksum-Md5": md5hash, "X-Checksum-Sha1": sha1hash}
        url = self.url(target_url)
        r = requests.put(
            url,
            auth=self.auth,
            headers=headers,
            verify=self.verify,
            data=src_file.open("rb"),
        )
        return r

    def delete(self, target: Path) -> requests.Response:
        url = self.url(target)
        r = requests.delete(url, auth=self.auth, verify=self.verify)
        return r

    def get_builds(self) -> requests.Response:
        path = "{0}/{1}/".format(self.artifactory_url, "api/build")
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def get_storage_summary_info(self) -> requests.Response:
        path = "{0}/{1}/".format(self.artifactory_url, "api/storageinfo")
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def item_last_modified(self, fin) -> requests.Response:
        path = "{0}/{1}/{2}/{3}{4}".format(
            self.artifactory_url,
            "api/storage",
            self.repository_name,
            fin,
            "?lastModified",
        )
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def item_properties(self, fin) -> requests.Response:
        path = "{0}/{1}/{2}/{3}?properties".format(
            self.artifactory_url, "api/storage", self.repository_name, fin
        )
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def url_properties(self, attributes: dict):
        """Format of key values to an property url
        Note that if used as part of an upload the properties need to start with a ;"""
        props = ";".join(["%s=%s" % (k, v) for k, v in attributes.items()])
        return props

    def set_item_properties(self, fin, props, recursive="1") -> requests.Response:
        path = "{0}/{1}/{2}/{3}?properties={4}&recursive={5}".format(
            self.artifactory_url,
            "api/storage",
            self.repository_name,
            fin,
            self.url_properties(props),
            recursive,
        )
        r = requests.put(path, auth=self.auth, verify=self.verify)
        return r

    def delete_item_properties(
        self, fin, prop_names, recursive="1"
    ) -> requests.Response:
        properties = ",".join(prop_names)
        path = "{0}/{1}/{2}/{3}?properties={4}&recursive={5}".format(
            self.artifactory_url,
            "api/storage",
            self.repository_name,
            fin,
            properties,
            recursive,
        )
        r = requests.delete(path, auth=self.auth, verify=self.verify)
        return r

    def file_statistics(self, fin) -> requests.Response:
        path = "{0}/{1}/{2}/{3}?stats".format(
            self.artifactory_url, "api/storage", self.repository_name, fin
        )
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def get_file_info(self, relative_path: Path) -> requests.Response:
        path = (
            f"{self.artifactory_url}/api/storage/{self.repository_name}/{relative_path}"
        )
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def file_list(
        self,
        folder_path,
        listFolders=False,
        mdTimestamps=False,
        includeRootPath=False,
        deep="0",
    ) -> requests.Response:
        path = "{0}/{1}/{2}/{3}?list".format(
            self.artifactory_url, "api/storage", self.repository_name, folder_path
        )
        path = path + "&listFolders=" + ("1" if listFolders else "0")
        path = path + "&mdTimestamps=" + ("1" if mdTimestamps else "0")
        path = (
            path + "&includeRootPath=" + ("1" if includeRootPath else "0")
        )  # i.e the root of the folder ./
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def folder_info(self, folder_path) -> requests.Response:
        path = "{0}/{1}/{2}/{3}".format(
            self.artifactory_url, "api/storage", self.repository_name, folder_path
        )
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def search_latest_by_properties(
        self, search_path="_any", listFiles="0"
    ) -> requests.Response:
        path = "{0}/{1}/{2}/{3}?listFiles={4}".format(
            self.artifactory_url,
            "api/versions",
            self.repository_name,
            search_path,
            listFiles,
        )
        r = requests.get(path, auth=self.auth, verify=self.verify)
        return r

    def property_search(self, props, detail="") -> requests.Response:
        properties = "&".join(
            "%s=%s" % (key, ",".join(val)) for (key, val) in props.iteritems()
        )
        path = "{0}/{1}?{2}&repos={3}".format(
            self.artifactory_url, "api/search/prop", properties, self.repository_name
        )

        headers = {}
        if detail:
            assert detail in ("info", "properties"), "Invalid detail '{}'".format(
                detail
            )
            headers = {"X-Result-Detail": detail}

        r = requests.get(path, auth=self.auth, verify=self.verify, headers=headers)
        return r

    def artifact_search(self, name, detail="") -> requests.Response:
        path = "{0}/api/search/artifact?name={1}&repos={2}".format(
            self.artifactory_url, name, self.repository_name
        )
        print(path)

        headers = {}
        if detail:
            assert detail in ("info", "properties"), "Invalid detail '{}'".format(
                detail
            )
            headers = {"X-Result-Detail": detail}

        r = requests.get(path, auth=self.auth, verify=self.verify, headers=headers)
        return r

    def aql(self, query) -> requests.Response:
        path = "{0}/api/search/aql".format(self.artifactory_url, self.repository_name)
        r = requests.post(path, auth=self.auth, verify=self.verify, data=query)
        return r

    def aql_list_artifactory_files(self) -> list[str]:
        query = 'items.find({"repo": "' + self.repository_name + '"})'
        r = self.aql(query)
        txt = json.loads(r.text)
        if "results" in txt:
            url_list = [
                "/".join([result["path"], result["name"]]) for result in txt["results"]
            ]
            return url_list
        else:
            return []

    def aql_list_artifactory_files_with_path(self, path) -> list[str]:
        query = (
            'items.find({"repo": "'
            + self.repository_name
            + '"},{"type": "file", "path":{"$match":"*'
            + path
            + '*"}})'
        )
        r = self.aql(query)
        if r and r.text:
            txt = json.loads(r.text)
            if "results" in txt:
                url_list = [
                    "/".join([result["path"], result["name"]])
                    for result in txt["results"]
                ]
                return url_list
            else:
                return []
        else:
            return []

    def aql_list_artifactory_directories(self) -> list[str]:
        query = (
            'items.find({"repo": "' + self.repository_name + '"},{"type": "folder"})'
        )
        r = self.aql(query)
        txt = json.loads(r.text)
        if "results" in txt:
            url_list = [
                "/".join([result["path"], result["name"]]) for result in txt["results"]
            ]
            return url_list
        else:
            return []

    def count_children(self, artifactory_directory) -> int:
        txt = json.loads(self.folder_info(artifactory_directory).text)
        if txt and "children" in txt:
            return len(txt["children"])
        else:
            return 0

    def errors(self, r):
        print(str(r))
        print(r.status_code)
        print(r.reason)
        if r and hasattr(r, "errors"):
            errs = json.loads(r.errors)
            for result in errs["results"]:
                print(result.status)
                print(result.message)

    def map_sha1_checksums(self, directory) -> dict:
        """Map the name of the files in the directory to their checksum"""
        uri_checksums = {}
        r = self.file_list(directory)
        txt = json.loads(r.text)
        if txt and "files" in txt:
            for f in txt["files"]:
                p = Path(f["uri"])
                uri_checksums[p.name] = f["sha1"]
        return uri_checksums

    def update_properties(self, target_url, props, recursive="1"):
        """Update the properties at a target url"""
        r = self.item_properties(target_url)
        if r and r.text:
            txt = json.loads(r.text)
            old_props = txt["properties"]
            to_delete = set(old_props) - set(props)
            if to_delete:
                self.delete_item_properties(target_url, to_delete, recursive)

        self.set_item_properties(target_url, props, recursive)

    def folder_list(self, directory: str) -> list[str]:
        """List the names of folders in a directory"""
        text = self.file_list(
            directory,
            listFolders=True,
            includeRootPath=False,
        ).text
        """Return a list of folders from a file_list request"""
        flj = json.loads(text)
        return (
            [f["uri"][1:] for f in flj["files"]] if "files" in flj else []
        )  # Strip the leading /


# fin = 'C:\\x\\Java\\javapartner\BINARY\\JDK\\JDK-7_0\\7u121_b05\\jdk-7u121-ea-bin-b05-linux-i586-19_jul_2016.tar.gz'
#
# aapi = ArtifactoryApi(artf_url, artf_repository_name, artf_uid, artf_pwd)
#
# aapi.upload(fin, "/Java/Oracle/jdk/7/7u121/jdk-7u121-ea-bin-b05-linux-i586-19_jul_2016.tar.gz")
# print get_builds().text
# print get_file_info('jdk-8-fcs-bin-b132-windows-i586-03_mar_2014.zip').text
# print get_storage_summary_info().text
# print item_last_modified('jdk-8-fcs-bin-b132-windows-i586-03_mar_2014.zip').text
# print aapi.item_properties('java-ibm-jdk/70/windows-x64/copyright').text
# attributes = {}
# attributes['lang'] = 'java'    # e.g java, node
# attributes['vendor'] = 'ibm'    # e.g ibm, oracle
# attributes['release'] = '7.0'
# attributes['version'] = '7.0.6.4'
# attributes['platform'] = 'win'
# attributes['hardware'] = 'x64'
# attributes['jre'] = 'false'
# attributes['jdk'] = 'false'

# aapi.update_properties('java-ibm-jdk/70/windows-x64/copyright', attributes, recursive='0')

# print set_item_properties('jdk-8-fcs-bin-b132-windows-i586-03_mar_2014.zip', props,  recursive='0')

# print aapi.file_list('/', listFolders=True, includeRootPath=True).text
# print aapi.folder_info('/java/ibm/jdk/8').text
# print search_latest_by_properties(listFiles='1').text

# props = {'os': ['win',],}
# props = {'platform': ['windows', 'linux'], 'hardware' : ['x64',]}
# print aapi.property_search(props).text

# props = {'platform': ['windows'], 'hardware' : ['x64',]}
# print aapi.property_search(props).text

# print artifact_search('8u5', detail='info').text
# print aapi.artifact_search('jdk', detail='properties').text

# query = 'items.find({"type":"file","name":{"$match":"*.tar.gz"}})'
# r = aapi.aql(query)
# print r.text

# query = 'items.find({"type":"file","name":{"$match":"*.tar.gz"},"stat.downloads":{"$ne":null}}).include("path", "name", "repo", "stat.downloads")'
# r = aapi.aql(query)
# print r.status_code
# print r.text
