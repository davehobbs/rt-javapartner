import threading
from typing import Protocol
from pathlib import Path

""" Functions used to enable threaded downloads and uploads"""


class Downloader(Protocol):
    """A callback to a class that will handle the download"""

    def download(self, src_file: Path, tgt_file: Path) -> None:
        ...


class Uploader(Protocol):
    """A callback to a class that will handle the upload"""

    def upload(self, src_file: Path, tgt_file: Path) -> None:
        ...


def threaded_download(downloader: Downloader, file_paths, tgt_dir: Path):
    """Download a number of files in different threads"""
    threads = [
        threading.Thread(
            name=f"downloader thread {idx}",
            target=downloader.download,
            args=(src_file, tgt_dir / src_file.name),
        )
        for idx, src_file in enumerate(file_paths)
    ]
    for thread in threads:
        thread.start()
    for thread in threads:
        thread.join()


def threaded_upload(uploader: Uploader, file_paths, tgt_dir: Path):
    """Upload a number of files in different threads"""
    threads = [
        threading.Thread(
            name=f"uploader thread {idx}",
            target=uploader.upload,
            args=(src_file, tgt_dir / src_file.name),
        )
        for idx, src_file in enumerate(file_paths)
    ]
    for thread in threads:
        thread.start()
    for thread in threads:
        thread.join()
