import logging
import shutil
from pathlib import Path
import requests
import paramiko
from paramiko import SFTPClient

""" Functions used to enable downloaders and uploaders"""


class FtpUtils:
    """Helper class for ftp file transfer"""

    def __init__(self, server, user_name, password) -> None:
        self.server = server
        self.user_name = user_name
        self.password = password
        logging.getLogger("paramiko").setLevel(logging.WARNING)

    def _ftp_mkdir(self, sftp: SFTPClient, target_path: Path):
        """Recursively create the target path"""
        spath = str(target_path)
        try:
            sftp.chdir(spath)
        except IOError:
            mkpath(sftp, target_path.parent)
            sftp.mkdir(spath)
            sftp.chmod(spath, 0o2770)
            sftp.chdir(spath)

    def ftp_upload(self, src_file: Path, tgt_file: Path):
        """Upload a file to the server"""
        try:
            with paramiko.SSHClient() as ssh:
                ssh.load_system_host_keys()
                ssh.connect(
                    self.server, username=self.user_name, password=self.password
                )
                with ssh.open_sftp() as sftp:
                    self._ftp_mkdir(sftp, tgt_file.parent)
                    sftp.put(str(src_file), str(tgt_file))
                    sftp.chmod(str(tgt_file), 0o664)
        except IOError as e:
            logging.exception(f"Failed to upload to {tgt_file}", e)

    def ssh_download(self, src_url: str, tgt_file: Path):
        try:
            r = requests.get(
                src_url, auth=(self.user_name, self.password), verify=False, stream=True
            )
            r.raise_for_status()
            r.raw.decode_content = True
            with tgt_file.open("wb") as f:
                shutil.copyfileobj(r.raw, f)
        except Exception as e:
            logging.error(f"Error downloading file: {e}")


def mkpath(sftp: SFTPClient, path: Path):
    """Recursively create the target path"""
    try:
        sftp.chdir(str(path))
    except IOError:
        mkpath(sftp, path.parent)
        sftp.mkdir(str(path))
        sftp.chdir(str(path))
