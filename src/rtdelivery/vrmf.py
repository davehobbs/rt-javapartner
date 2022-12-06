from dataclasses import dataclass
from packaging.version import parse, InvalidVersion


@dataclass
class VersionInfo:
    """Python semver classes and everyone else, only natively handle v.r.m
    This class extends those to add a 'fix' attribute"""

    ver: str
    rel: str
    mod: str
    fix: str

    def release_string(self):
        """Try to extract v.r from v.r.m.f"""
        return f"{self.ver}.{self.rel}"


def extract_full_version_info(version: str) -> VersionInfo:
    """Try to extract the components of a v.r.m.f string"""
    try:
        v = parse(version)
        f = v.release[3] if len(v.release) > 3 else 0

        return VersionInfo(v.major, v.minor, v.micro, f)
    except InvalidVersion as e:
        raise ValueError(f"Unable to parse version {version} : {e}")
