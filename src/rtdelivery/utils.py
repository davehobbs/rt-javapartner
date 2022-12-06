from functools import wraps
from imp import reload
import logging
import hashlib
import sys
from datetime import datetime
from pathlib import Path
import time


def initialise_dated_log(log_file: str):
    """Initialise logging to an output file with a date suffix and stdout"""

    log_path = Path(log_file)
    log_path.parent.mkdir(parents=True, exist_ok=True)
    date_part = "{:%Y-%m-%d-%H-%M}".format(datetime.now())
    dated_log_path = str(log_path).replace(".", "_" + date_part + ".", 1)
    logging.basicConfig(
        level=logging.INFO,
        format="%(levelname)s - %(message)s",
        force=True,
        handlers=[
            logging.FileHandler(dated_log_path, "w+"),
            logging.StreamHandler(sys.stdout),
        ],
    )


def get_checksum(file_path: Path, hashing_fn: "hashlib._Hash") -> str:
    """Calculate  the checksum of the file using a hashing algorithm"""
    msg = hashing_fn()
    block_size = 128 * msg.block_size
    with file_path.open("rb") as f:
        while True:
            chunk = f.read(block_size)
            if not chunk:
                break
            msg.update(chunk)
    return msg.hexdigest()


def timing(f):
    """Annotation to time a method"""

    @wraps(f)
    def wrap(*args, **kw):
        start = time.perf_counter()
        result = f(*args, **kw)
        elapsed = time.perf_counter() - start
        print(f"func:{f.__name__} took: {elapsed:.2f} sec")
        return result

    return wrap
