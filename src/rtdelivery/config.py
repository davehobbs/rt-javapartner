import logging
import os
import pathlib
import sys
from jinja2 import Environment, BaseLoader

import yaml
from dotenv import load_dotenv
from envyaml import EnvYAML

# Load the ids and pwds from the local environment
load_dotenv()

# Where is this script running from
app_path = pathlib.Path(os.path.abspath(os.path.dirname(__file__)))

# Dry run commit nothing
dry_run = os.environ.get("DRY_RUN", "False").lower() in ("true", "1", "t")

# Set of valid environment names
environments = ["dev", "test", "prod"]
environment = os.environ.get("ENVIRONMENT", "invalid")
if environment not in environments:
    logging.critical(
        f"The ENVIRONMENT environment variable needs to be one of {environments}"
    )
    raise EnvironmentError(f"]ENVIRONMENT unexpected value {environment}")

# Use the workspace folder if set. Otherwise download to the data directory
workspace_dir = os.environ.get("WORKSPACE_FOLDER", app_path.parent.parent / "data")

""" Config related functions """


def load_config(config_path, config_dir="config"):
    """Attempt to load a configuration file from the config directory"""
    config_path = app_path / config_dir / config_path
    if not config_path.exists():
        raise ValueError(f"Config path not found: {config_path}")

    # Assume the config file contains jinja substitutions
    env = Environment(loader=BaseLoader)

    # Resolve environment variables
    config_settings = EnvYAML(str(config_path))

    # Use the resolved settings as a template
    template = env.from_string(yaml.dump(config_settings.export()))

    # with config_path.open(encoding="utf-8") as f:
    #    config_settings = yaml.safe_load(f)
    # Render config file using the variables it declares
    config_settings = template.render(config_settings)

    # Reload the new config settings
    config_settings = yaml.safe_load(config_settings)

    return config_settings


def get_env_variable(name: str) -> str:
    """Look for an environment variable and if it isn't set exit the program"""
    v = os.environ.get(name)
    if not v:
        logging.error(f"{name} environment variable not set. Exiting")
        sys.exit(1)
    return v
