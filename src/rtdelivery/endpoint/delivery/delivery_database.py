import logging
from pathlib import Path
import re
from typing import List

from rtdelivery.database.sqllitedb import SqliteDatabase
from rtdelivery.config import app_path


class DeliveryDatabase:
    """Access to the delivery database"""

    db_path = f"{app_path}/database/delivery.db"

    def __init__(self) -> None:
        self.db = SqliteDatabase(self.db_path)
        print(self.db_path)

    def get_stream(self, stream_name: str):
        """Get the details of the named stream"""
        self.db.execute(
            """select vendor, ,bldlang, technology from delivery_stream where name = ?""",
            (stream_name,),
        )
        row = self.db.fetchone()
        if not row:
            raise ValueError(f"No stream named {stream_name} in delivery_stream table")
        return row

    def _fetch_first_column(self):
        """List the first column of data in a fetch"""
        rows = self.db.fetchall()
        return [row[0] for row in rows] if rows else []

    def platforms(self) -> list:
        """List all the available platforms"""
        self.db.execute("select platform from platforms")
        return self._fetch_first_column()

    def has_platform(self, platform: str) -> bool:
        """Does this platform exist in the database"""
        self.db.execute(
            """SELECT platform FROM platforms WHERE platform=?""", (platform,)
        )
        return bool(self.db.fetchone())

    def is_hybrid(self, platform: str) -> bool:
        self.db.execute(
            """SELECT hybrid FROM platforms WHERE platform=?""", (platform,)
        )
        return self.db.fetchone()[0]

    def has_destination(self, destination: str) -> bool:
        """Does this destination exist in the database"""
        self.db.execute(
            """SELECT destination FROM destinations WHERE destination=?""",
            (destination,),
        )
        return bool(self.db.fetchone())

    def has_release(self, release: str) -> bool:
        """Does the release exist in the database"""
        self.db.execute("""SELECT release FROM releases WHERE release=?""", (release,))
        return bool(self.db.fetchone())

    def destinations(self):
        """List all the destinations"""
        sql = """select unique(destination) from files"""
        self.db.execute(sql)
        return self._fetch_first_column()


class DatabaseDestination:
    """Find information in the database based on the destination"""

    def __init__(
        self,
        db: DeliveryDatabase,
        vendor: str,
        platform: str,
        vr: str,
        destination: str,
    ) -> None:
        self.db = db
        self.destination = destination
        self.vendor = vendor
        self.platform = platform
        self.vr = vr

    def platforms_for_destination(self):
        """List all the platforms"""
        sql = """select distinct platform from files 
            where vendor = ?
            and destination like ?
            and version_group like ?"""
        self.db.db.execute(sql, [self.vendor, f"%{self.destination}%", f"%{self.vr}%"])
        return self.db._fetch_first_column()

    def files_for_destination(self, bldlang: str = "java"):
        """List all the file patterns for the destination/platform/version_release"""
        sql = """select file from release_platform 
            where bldlang like ?
            and destination = ?
            and platform = ?
            and version_group like ?"""
        self.db.db.execute(
            sql, [bldlang, self.destination, self.platform, f"%{self.vr}%"]
        )
        return self.db._fetch_first_column()

    def list_all_files_for_destination(self):
        """List all the file patterns for a destination"""
        sql = """select file from files 
            where destination like ?
            and version_group like ?
            and platform like ?"""

        self.db.db.execute(
            sql,
            [
                f"%{self.destination}%",
                f"%{self.vr}%",
                f"%{self.platform}%",
            ],
        )
        return self.db._fetch_first_column()

    def list_files_for_destination(self, bldlang: str = "java") -> list:
        """List all the file patterns for a destination/release combination"""
        sql = """select file from files 
            where UPPER(vendor) like ? 
            and bldlang like ? 
            and version_group like ? 
            and platform like ?
            and destination like ?"""

        self.db.db.execute(
            sql,
            [
                f"%{self.vendor.upper()}%",
                f"%{bldlang}%",
                f"%{self.vr}%",
                f"%{self.platform}%",
                f"%{self.destination}%",
            ],
        )
        return self.db._fetch_first_column()

    def platform_for_release(
        self, file_name: str, vendor: str, bldlang: str = "java"
    ) -> str:
        """Find the name of the platform for this file"""
        """List all the file patterns and platforms for a destination release combination"""
        list_files_sql = """select file, platform from files 
            where UPPER(vendor) like ? 
            and bldlang like ? 
            and version_group like ? 
            and destination like ?"""

        self.db.execute(
            list_files_sql,
            [
                f"%{vendor.upper()}%",
                f"%{bldlang}%",
                f"%{self.vr}%",
                f"%{self.destination}%",
            ],
        )
        rows = self.db.db.fetchall()
        if rows:
            for (file_pattern, platform) in rows:
                if re.match(file_pattern, file_name):
                    return platform
        return None

    def filter(self, files: list[str]) -> list[Path]:
        """Which of these files should be delivered to the target destination"""
        if self.is_valid_destination():
            valid_files = [f for f in files if self.is_targeted_for(f.name)]
            for f in valid_files:
                logging.debug(f"Valid file {f.name}")
            return valid_files
        else:
            return []

    def is_targeted_for(self, file_name: str) -> bool:
        """Should this file be delivered to the target destination"""
        file_patterns = self.list_files_for_destination()
        return any(re.match(file_pattern, file_name) for file_pattern in file_patterns)

    def is_valid_destination(self) -> bool:
        """Check if the release should be uploaded to the destination"""
        sql = f"""select access from destination_restrictions 
        where destination = '{self.destination}'
        and (min_release <= {self.vr} or min_release is null) 
        and (max_release >= {self.vr} or max_release is null) 
        and ('{self.platform}' like  '%' || platforms || '%' or platforms is null)"""
        self.db.db.execute(sql)
        access = "allow" in self.db._fetch_first_column()
        if access:
            logging.debug(f"Valid destination {self.destination}")
        else:
            logging.debug(f"Invalid destination {self.destination}")

        return access
