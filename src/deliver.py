import logging
from rtdelivery.config import load_config
from rtdelivery.utils import initialise_dated_log
import argparse
from dataclasses import dataclass
import sys
from typing import Any, Optional, Type
from rtdelivery import config
from rtdelivery.endpoint.delivery.deliver import deliveries_for_destination, db
from rtdelivery.endpoint.delivery.delivery_database import DatabaseDestination
from rtdelivery.endpoint.javapartner import (
    JavaPartnerSite,
    JavaPartnerSiteRelease,
)
from rtdelivery.endpoint.jim import JIM
from rtdelivery.endpoint.mrs import MRS


@dataclass
class Endpoint:
    """An endpoint is either a source or target location for java files"""

    description: str
    klass: Type[Any]
    release_klass: Optional[Type[Any]] = None


endpoints = {
    "jps": Endpoint("Java Partner Site", JavaPartnerSite, JavaPartnerSiteRelease),
    "jim": Endpoint("Java Information Manager", JIM, None),
    "mrs": Endpoint("Marketing Registration Service", MRS, None),
}


def deliver(delivery_config, action: str):
    # Load the release info from the yaml config
    deliveries = deliveries_for_destination(delivery_config, "config")
    for destination, drps in deliveries.items():
        logging.info(f"Downloading from Java Partner Site")
        endpoint = endpoints.get(destination, None)
        if not endpoint:
            logging.error(f"Unknown destination {destination}")
        else:
            logging.info(f"Publishing to {endpoint.description}")
            try:
                for drp in drps:
                    logging.info(f"{drp}")

                    # Find all the javapartner paths to the release
                    jpr = JavaPartnerSiteRelease(drp)

                    available_files = jpr.list_files()
                    logging.debug("Available files: ")
                    for f in available_files:
                        logging.debug(f"\t{f.name}")

                    # Filter those files for the target endpoint
                    dd = DatabaseDestination(
                        db, drp.vendor, drp.platform, drp.vr, destination
                    )
                    filtered_files = dd.filter(available_files)
                    if not filtered_files:
                        logging.info(
                            "No files match this destination release combination"
                        )
                    else:
                        jpr.download(filtered_files, False)
                        target = endpoint.klass()
                        target.upload_release(drp, action)
                    logging.info("")
            except Exception as e:
                logging.critical(e, exc_info=True)


def main():
    """Deliver a java partner release to the sftp site"""

    parser = argparse.ArgumentParser(
        description="Deliver a java partner release to the sftp site"
    )

    parser.add_argument(
        "--action",
        default="put",
        help="What action to take. Either 'put' or 'delete'",
    )
    parser.add_argument(
        "--delivery_config",
        default="oracle_releases.yml",
        help="Path to the delivery config file",
    )
    parser.add_argument(
        "--testing",
        default=False,
        action="store_true",
        help="Dry run without changing anything.",
    )
    parser.add_argument(
        "workspace_dir",
        nargs="?",
        default=config.workspace_dir,
        help="The target directory for the downloaded files",
    )
    args = parser.parse_args()
    initialise_dated_log("logs/delivery.log")
    logging.info(f"Started delivery")

    config.dry_run = args.testing
    config.workspace_dir = args.workspace_dir
    logging.info(f"Using configuration file {args.delivery_config}")
    logging.info(f"Action has been set to {args.action}")
    logging.info(f"Dry run has been set to {config.dry_run}")
    logging.info(f"Environment has been set to {config.environment}")
    logging.info(f"Workspace directory {args.workspace_dir}")

    deliver(args.delivery_config, args.action)
    logging.info("Finished delivery")
    return 0


if __name__ == "__main__":
    sys.exit(main())
