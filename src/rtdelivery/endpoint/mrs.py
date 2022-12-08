import logging
import os
from rtdelivery.transfer import FtpUtils
from rtdelivery.config import load_config
from rtdelivery.endpoint.delivery.deliver import DeliveryReleasePlatform


class MRS:
    """Staging server used to upload files to Marketing Registration Services (MRS)
    - https://w3.ibm.com/w3publisher/mrs
    - https://w3.ibm.com/w3publisher/mrs/mrs-download-pages
    - https://w3.ibm.com/w3publisher/ibm-edelivery/standard-service-offerings/marketing-registration-services/mrs-migration-to-cpc
    """

    def __init__(
        self,
        config_file: str = "delivery_config.yaml",
    ) -> None:
        self.name = "rdm"
        self.config = load_config(config_file)["rdm"]
        self.rdm_user_name = self.config["user_name"]
        self.rdm_password = self.config["password"]
        self.rdm_server = self.config["server"]

        self.transfer_utils = FtpUtils(
            self.rdm_server, self.rdm_user_name, self.rdm_password
        )

    def upload_release(self, drp: DeliveryReleasePlatform, action: str):
        """Attempt to upload the release to rdm"""
        src_dir = drp.workspace_path
        logging.info("Uploading rdm release")

        try:
            tgt_root = self.config["java_root"]
            tgt_dir = f"{tgt_root}/{drp.vendor}/{drp.bldlang}/{drp.technology}/{drp.vr}/{drp.vrmf}/{drp.platform}"
            file_types = self.cfg[drp.vendor][drp.bldlang][drp.technology][drp.vr][
                drp.platform
            ]
            for local_bin_file in src_dir.rglob(f"*{file_types}"):
                tgt_file = f"{tgt_dir}/{local_bin_file}"
                logging.info(f"Uploading {tgt_file}")
                # self.transfer_utils.ftp_upload(local_bin_file, tgt_file)

        except KeyError as e:
            logging.warning(f"Release {drp} not found rdm_config.yaml")
