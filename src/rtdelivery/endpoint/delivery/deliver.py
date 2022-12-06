from dataclasses import dataclass, field
import logging
from pathlib import Path

from rtdelivery.config import app_path, load_config, workspace_dir
from rtdelivery.endpoint.delivery.delivery_database import DeliveryDatabase
from rtdelivery.vrmf import (
    VersionInfo,
    extract_full_version_info,
)


@dataclass
class DeliveryRelease:
    """A delivery release  includes all the settings to uniquely define
    the location and settings applicable to a set of delivery releases in the delivery
    environment. Names used by other endpoints are translated to conform
    this schema and back depending on which endpoint they are being
    downloaded from or uploaded to"""

    vendor: str
    vrmf: str
    build_id: str
    version_info: VersionInfo = field(init=False, repr=False)
    vr: str = field(init=False)

    def __post_init__(self):
        """Extract the v.r aka release number from the v.r.m.f"""
        self.version_info = extract_full_version_info(self.vrmf)
        self.vr = self.version_info.release_string()


@dataclass
class DeliveryReleasePlatform:
    """A delivery release platform includes all the settings to uniquely define
    the location and settings applicable to a set of files in the delivery
    environment. Names used by other endpoints are translated to conform
    this schema and back depending on which endpoint they are being
    downloaded from or uploaded to"""

    vendor: str
    vrmf: str
    platform: str
    build_id: str
    technology: str = "jdk"
    bldlang: str = "java"
    ifix: bool = False
    version_info: VersionInfo = field(init=False, repr=False)
    vr: str = field(init=False, repr=False)
    path: Path = field(init=False, repr=False)
    workspace_path: Path = field(init=False, repr=False)
    meta_path: Path = field(init=False, repr=False)

    def __post_init__(self):
        """Extract the v.r aka release number from the v.r.m.f"""
        self.version_info = extract_full_version_info(self.vrmf)
        self.vr = self.version_info.release_string()
        self.path = Path(
            self.vendor,
            self.technology,
            self.vr,
            self.vrmf,
            self.platform,
            # self.build_id,
        )
        self.workspace_path = workspace.working_dir(self.path)
        self.meta_path = self.workspace_path / "meta"

    def files(self) -> list[Path]:
        """List all the file paths in the workspace path"""
        return [f for f in self.workspace_path.iterdir() if f.is_file()]


class DeliveryWorkspace:
    """A place to store local files"""

    def __init__(self, dest_path: Path) -> None:
        self.dest_path = dest_path

    def working_dir(self, release_path: Path) -> Path:
        working_path = self.dest_path / release_path
        working_path.mkdir(parents=True, exist_ok=True)
        return working_path


# These settings are used globally throughout the delivery application
workspace = DeliveryWorkspace(workspace_dir)
db = DeliveryDatabase()


def deliveries_for_destination(
    config_name: str, config_dir: str
) -> dict[str:DeliveryReleasePlatform]:
    """Try to create a list of delivery releases from a config file"""
    deliveries_for_destinations = {}
    delivery_config = load_config(config_name, config_dir=config_dir)
    if "defaults" in delivery_config:
        defaults = load_config(delivery_config["defaults"], config_dir=config_dir)

    destinations = delivery_config.get("destinations", defaults["destinations"])
    deliveries = delivery_config["deliveries"]
    for delivery in deliveries:

        # If a platform is specified use it, otherwise assume the delivery is for every
        # default platform for the release
        vr = extract_full_version_info(delivery["vrmf"]).release_string()
        platforms = delivery.get("platforms", [])
        if not platforms:
            platforms = defaults.get("releases", {}).get(vr, {}).get("platforms", [])
            if not platforms:
                logging.error(
                    f"Unable to find any platforms for release {vr}. Skipping."
                )

        for destination in destinations:
            deliveries = deliveries_for_destinations.get(destination, [])
            for platform in platforms:
                deliveryRelease = DeliveryReleasePlatform(
                    vendor=delivery.get("vendor", defaults["vendor"]),
                    bldlang=delivery.get("bldlang", defaults["bldlang"]),
                    vrmf=delivery["vrmf"],
                    platform=platform,
                    technology=delivery.get("technology", defaults["technology"]),
                    build_id=delivery["build_id"],
                    ifix=bool("ifix" in delivery),
                )
                deliveries.append(deliveryRelease)
            deliveries_for_destinations[destination] = deliveries

    return deliveries_for_destinations
