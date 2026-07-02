#!/usr/bin/env python
# File: h.py
# Author: Yiklek
# Description: helper for installing neovim config
# Copyright (c) 2021 Yiklek

import argparse
import logging
import os
import platform
import shutil
import sys
from os.path import join, isfile, isdir, abspath
from pathlib import Path

basedir = abspath(os.path.dirname(__file__))
homedir = abspath(os.path.expanduser("~"))
sys.dont_write_bytecode = True

logging.basicConfig(
    level=logging.DEBUG,
    format="%(message)s",
    handlers=[logging.StreamHandler()],
)
logger = logging.getLogger(__name__)

xdg_config_dir = os.getenv("XDG_CONFIG_HOME")
xdg_cache_dir = os.getenv("XDG_CACHE_HOME")
local_dir = join(homedir, ".local")
cache_dir = xdg_cache_dir or join(homedir, ".cache")
ovim_cache_dir = join(cache_dir, "ovim")

if os.name == "nt":
    config_dir = xdg_config_dir or join(homedir, "AppData", "Local")
else:
    config_dir = xdg_config_dir or join(homedir, ".config")

nvim_root_name = "nvim"
ovim_config_path = join(config_dir, nvim_root_name)
ovim_config_init = join(ovim_config_path, "init.lua")


def install(_, args):
    """Create symlink ~/.config/nvim/init.lua -> ovim/init.lua"""
    os.makedirs(ovim_config_path, exist_ok=True)
    logger.info("create path %s successfully.", ovim_config_path)
    if not isfile(ovim_config_init):
        os.symlink(join(basedir, "ovim", "init.lua"), ovim_config_init)
        logger.info("symlink created: %s -> ovim/init.lua", ovim_config_init)
    else:
        logger.info("config already exists at %s", ovim_config_init)


def uninstall(_, args):
    """Remove config dir and optionally cache"""
    try:
        shutil.rmtree(ovim_config_path)
        logger.info("delete config dir %s successfully.", ovim_config_path)
    except Exception:
        logger.warning("delete config dir %s failed. please remove %s manually.", ovim_config_path, ovim_config_path)
    if args.remove_cache:
        try:
            shutil.rmtree(ovim_cache_dir)
            logger.info("delete cache dir %s successfully.", ovim_cache_dir)
        except Exception:
            logger.warning("delete cache dir %s failed. please remove %s manually.", ovim_cache_dir, ovim_cache_dir)


def detect_arch():
    """Auto-detect platform and architecture for Neovim download."""
    system = platform.system()
    machine = platform.machine()

    if system == "Darwin":
        if machine == "arm64":
            return "macos-arm64"
        else:
            return "macos-x86_64"
    elif system == "Linux":
        if machine in ("aarch64", "arm64"):
            return "linux-arm64"
        else:
            return "linux-x86_64"
    else:
        logger.error("unsupported platform: %s %s", system, machine)
        logger.error("please specify --arch manually")
        sys.exit(1)


VALID_ARCHS = ("macos-x86_64", "macos-arm64", "linux-x86_64", "linux-arm64")


def download(_, args):
    """Download and install latest Neovim release."""
    from urllib.request import urlopen

    arch = args.arch or detect_arch()
    if arch not in VALID_ARCHS:
        logger.error("invalid arch: %s. valid: %s", arch, ", ".join(VALID_ARCHS))
        sys.exit(1)

    if args.nightly:
        version = "nightly"
    else:
        import json

        logger.info("fetching latest neovim release...")
        r = urlopen("https://api.github.com/repos/neovim/neovim/releases/latest")
        data = json.loads(r.read().decode())
        version = data["tag_name"]

    print("Version:", version)
    download_url = "https://github.com/neovim/neovim/releases/download/{}/nvim-{}.tar.gz".format(version, arch)
    print("Download:", download_url)

    import tarfile
    import tempfile

    logger.info("downloading...")
    r = urlopen(download_url)
    fp = tempfile.TemporaryFile()
    fp.write(r.read())
    fp.flush()
    fp.seek(0)

    tempdir = tempfile.TemporaryDirectory()
    tar = tarfile.open(fileobj=fp, mode="r:gz")
    out = join(local_dir, "nvim")
    tar.extractall(tempdir.name)
    tar.close()

    if os.path.exists(out):
        shutil.rmtree(out)
    shutil.copytree(join(tempdir.name, "nvim-{}".format(arch)), out)
    tempdir.cleanup()

    # create symlink
    nvim_bin = join(out, "bin", "nvim")
    nvim_link = join(local_dir, "bin", "nvim")
    os.makedirs(os.path.dirname(nvim_link), exist_ok=True)
    if os.path.exists(nvim_link):
        os.remove(nvim_link)
    os.symlink(nvim_bin, nvim_link)

    # remove bundled tree-sitter parsers (use nvim-treesitter instead)
    shutil.rmtree(Path(out) / "lib" / "nvim" / "parser")

    print("Neovim %s installed to %s" % (version, out))


def create_arg_parser():
    parser = argparse.ArgumentParser(description="ovim config helper")
    subparsers = parser.add_subparsers(metavar="COMMAND", dest="command")

    # install
    parser_install = subparsers.add_parser("install", aliases=["i"], help="install ovim config")
    parser_install.set_defaults(func=install)

    # uninstall
    parser_uninstall = subparsers.add_parser("uninstall", aliases=["u"], help="uninstall ovim config")
    parser_uninstall.set_defaults(func=uninstall)
    parser_uninstall.add_argument(
        "-r-c",
        "--remove-cache",
        dest="remove_cache",
        help="also remove cache dir",
        default=False,
        action="store_true",
    )

    # download
    parser_download = subparsers.add_parser("download", aliases=["dl"], help="download latest neovim")
    parser_download.set_defaults(func=download)
    parser_download.add_argument(
        "-a",
        "--arch",
        choices=VALID_ARCHS,
        type=str,
        default=None,
        help="target platform arch (auto-detect if omitted)",
    )
    parser_download.add_argument("--nightly", default=False, action="store_true")

    return parser


def main(args):
    parser = create_arg_parser()
    arg = parser.parse_args(args)
    if arg.command is None:
        parser.print_help()
    else:
        arg.func(parser, arg)


if __name__ == "__main__":
    try:
        main(sys.argv[1:])
    except BaseException as e:
        logger.error(e)
