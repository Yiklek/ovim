#!/usr/bin/env python
# File: h.py
# Author: Yiklek
# Description: helper for installing vim config
# Last Modified: 二月 09, 2021
# Copyright (c) 2021 Yiklek

import argparse
import os
import sys
from os.path import join, isfile, isdir, abspath
import shutil
import platform
import importlib

basedir = abspath(os.path.dirname(__file__))
homedir = abspath(os.getenv('HOME') or os.getenv('USERPROFILE'))
sys.dont_write_bytecode = True
sys.path.append(join(basedir, 'ovim', 'python3'))

logger = importlib.import_module("ovim.log").logger

xdg_config_dir = os.getenv('XDG_CONFIG_HOME')
xdg_cache_dir = os.getenv('XDG_CACHE_HOME')
local_dir = join(homedir, ".local")
ovim_cache_dir = xdg_cache_dir or join(homedir, '.cache')
ovim_cache_dir = join(ovim_cache_dir, 'ovim')
vim_py3_home = join(ovim_cache_dir, 'python3-venv')
ovim_py_vpath = os.path.join(vim_py3_home, 'vbin')

if os.name == 'nt':
    lib = 'Lib'
    path = "Scripts"
    vim_dep_source = join(vim_py3_home, lib, 'site-packages')
    config_dir = xdg_config_dir or join(homedir, 'AppData', 'Local')
    ovim_py_path = os.path.join(vim_py3_home, path)
    vim_py = join(ovim_py_path, 'python.exe')
    vim_root_name = 'vimfiles'
else:
    lib = 'lib'
    path = "bin"
    vim_dep_source = join(vim_py3_home, lib, 'python3.{}'.format(
        sys.version_info.minor), 'site-packages')
    config_dir = xdg_config_dir or join(homedir, '.config')
    ovim_py_path = os.path.join(vim_py3_home, path)
    vim_py = join(ovim_py_path, 'python')
    vim_root_name = '.vim'

vim_init_file = 'vimrc'
nvim_init_file = 'init.vim'
nvim_root_name = 'nvim'
vim_rtp_link = join(vim_py3_home, lib, 'python3')
vim_requirements = join(basedir, 'ovim', 'requirements.txt')
vim_packages = join(basedir, 'ovim', 'packages.txt')
vim_cargo = join(basedir, 'ovim', 'cargo.txt')
platform_module = 'ovim.platform'
platform_module_mac = 'ovim.platform.MacRunner'
platform_module_win = 'ovim.platform.WinRunner'


def import_module(module):
    import importlib
    try:
        modules = module.split('.')
        if len(modules) == 1:
            return getattr(globals(), modules[-1], None) \
                or importlib.import_module(modules[-1])
        elif len(modules) > 1:
            module_path = ".".join(modules[:-1])
            m = importlib.import_module(module_path)
            return getattr(m, modules[-1])
        else:
            raise RuntimeError
    except (ImportError, RuntimeError, AttributeError) as e:
        exit = 1
        logger.error(
            "{} not found.reason: {}\nexit {}".format(module, e, exit))
        sys.exit(exit)


def depend_check_env(args):
    if not args.ignore_python:
        args.venv = import_module("venv")

    if args.node:
        logger.info("finding npm")
        if os.system("npm --version"):
            logger.error("npm not found. exit 0")
            sys.exit(0)

    if args.cargo:
        logger.info("finding cargo")
        if os.system("cargo --version"):
            logger.error("cargo not found. exit 0")
            sys.exit(0)
    if args.auto_platform:
        s = platform.system()
        if s == 'Darwin':
            args.platform = platform_module_mac
        elif s == 'Linux':
            out = os.popen("cat /etc/*release")
            out = out.readlines()
            for o in out:
                o = o.split('=')
                if o[0] == 'ID':
                    o[1] = o[1].strip()
                    runner_name = o[1].lower()
                    runner_name = runner_name[0].upper(
                    ) + runner_name[1:] + "Runner"
                    args.platform = os.path.join(
                        "{}.{}".format(platform_module, runner_name))
                    break

    if args.platform:
        args.platform = import_module(args.platform)
        args.platform.check_env()


def depend(_, args):
    if args.all:
        args.ignore_python = False
        args.node = True
        args.cargo = True
        args.auto_platform = True
    depend_check_env(args)

    if not args.ignore_python:
        os.makedirs(ovim_cache_dir, exist_ok=True)
        args.venv.main([vim_py3_home])
        os.system('{} -m pip install -r {} -U'.format(vim_py, vim_requirements))
        # this symlink is for vim python dependency.
        # vim will search python/python3 module in all of runtimepath.
        # python site-packages path is different between on unix/linux and on windows
        # so create a symlink(python3) at Lib/lib, and set Lib/lib as vim runtimepath.
        # noevim does't need this symlink, but it does't matter.
        if os.path.exists(vim_rtp_link):
            os.remove(vim_rtp_link)
        os.symlink(vim_dep_source, vim_rtp_link,
                   target_is_directory=isdir(vim_dep_source))

        # these symlinks will be added into vim/nvim $PATH
        # in order to run exe in vim/nvim
        os.makedirs(ovim_py_vpath, exist_ok=True)
        bins = os.listdir(ovim_py_path)
        for b in bins:
            source = os.path.join(ovim_py_path, b)
            target = os.path.join(ovim_py_vpath, b)
            if not b.startswith("python") and not os.path.exists(target):
                os.symlink(source, target, target_is_directory=isdir(source))

    if args.node:
        with open(vim_packages, "r") as f:
            packages = f.read()
        packages = " ".join(packages.split('\n'))
        logger.info("install node packages: {}".format(packages))
        os.system('npm install -g {}'.format(packages))

    if args.cargo:
        with open(vim_cargo, "r") as f:
            crates = f.read()
        crates = " ".join(crates.split('\n'))
        logger.info("install cargo crates: {}".format(crates))
        os.system('cargo install {}'.format(crates))

    if args.platform:
        args.platform.run()


def install(parser, args):
    target = args.target
    global config_dir
    vim_config_path = ''
    vim_config_init = ''
    if target == 'vim':
        vim_config_path = join(homedir, vim_root_name)
        vim_config_init = join(vim_config_path, vim_init_file)
    elif target == 'nvim':
        vim_config_path = join(config_dir, nvim_root_name)
        vim_config_init = join(vim_config_path, nvim_init_file)

    os.makedirs(vim_config_path, exist_ok=True)
    logger.info('create path {} successfully.'.format(vim_config_path))
    if not isfile(vim_config_init):
        os.symlink(join(basedir, 'vimrc'), vim_config_init)
    vim_plug_path = join(ovim_cache_dir, 'pack', 'ovim',
                         'opt', 'vim-plug', 'autoload', 'plug.vim')
    if not isfile(vim_plug_path):
        cmd = 'curl -fLo {} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'.format(
            vim_plug_path)
        os.system(cmd)
    else:
        logger.info('plug.vim exist.')

    dein_path = join(ovim_cache_dir, 'pack', 'ovim', 'opt', 'dein.vim')
    if not isdir(dein_path):
        cmd = 'git clone https://github.com/Shougo/dein.vim {}'.format(dein_path)
        os.system(cmd)
    else:
        print('dein.vim exist.')
    packer_path = join(ovim_cache_dir, 'pack', 'packer', 'opt', 'packer.nvim')
    if not isdir(packer_path):
        cmd = 'git clone https://github.com/wbthomason/packer.nvim {}'.format(packer_path)
        os.system(cmd)
    else:
        print('packer.vim exist.')

    if args.install_depend:
        new_args = ['depend']
        new_args.extend(filter(lambda i: i is not None, args.install_depend))
        a = parser.parse_args(new_args)
        a.func(parser, a)


def uninstall(parser, args):
    target = args.target
    global config_dir
    global ovim_cache_dir
    vim_config_path = ''
    if target == 'vim':
        vim_config_path = join(homedir, vim_root_name)
    elif target == 'nvim':
        vim_config_path = join(config_dir, nvim_root_name)
    try:
        shutil.rmtree(vim_config_path)
        logger.info("delete config dir %s successfully." % vim_config_path)
    except Exception:
        logger.warn("delete config dir %s failed. please remove %s manually." %
                    (vim_config_path, vim_config_path))
    if args.remove_cache:
        try:
            shutil.rmtree(ovim_cache_dir)
            logger.info("delete config dir %s successfully." % ovim_cache_dir)
        except Exception:
            logger.warn("delete config dir %s failed. please remove %s manually." %
                        (ovim_cache_dir, ovim_cache_dir))


def download(parser, args):

    global local_dir
    from urllib.request import urlopen
    import json

    r = urlopen("https://api.github.com/repos/neovim/neovim/releases/latest")
    s = r.read().decode()
    r = json.loads(s)
    lastest = r["tag_name"]
    print("latest version is:", lastest)
    download_url = "https://github.com/neovim/neovim/releases/download/{}/nvim-{}.tar.gz".format(lastest, args.arch)
    import tarfile
    import tempfile
    print("download from:", download_url)
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
    import shutil
    if os.path.exists(out):
        shutil.rmtree(out)
    shutil.copytree(join(tempdir.name, "nvim-{}".format(args.arch)),
                    join(local_dir, "nvim"))
    tempdir.cleanup()
    nvim_source_path = join(out, "bin", "nvim")
    nvim_target_path = join(local_dir, "bin", "nvim")
    if os.path.exists(nvim_target_path):
        os.remove(nvim_target_path)
    os.symlink(nvim_source_path, nvim_target_path)
    print("download successfully")


def create_arg_parser():
    parser = argparse.ArgumentParser(description='vim config helper.')
    subparsers = parser.add_subparsers(metavar="COMMAND", dest='command')
    # install
    parser_install = subparsers.add_parser(
        'install', aliases=['i'], help='install vim config')
    parser_install.set_defaults(func=install)
    parser_install.add_argument('target', metavar='TARGET', choices=[
        'vim', 'nvim'], default='vim', help='option choices: vim, nvim. default: vim', nargs='?')
    parser_install.add_argument('-d', '--depend', dest='install_depend', type=str,
                                action='append', nargs='?', help='install dependency.example: -d="-i-p" -d="-n"')
    # uninstall
    parser_uninstall = subparsers.add_parser(
        'uninstall', aliases=['u'], help='uninstall vim config')
    parser_uninstall.set_defaults(func=uninstall)
    parser_uninstall.add_argument('target', metavar='TARGET', choices=[
        'vim', 'nvim'], default='vim', help='option choices: vim, nvim. default: vim', nargs='?')
    parser_uninstall.add_argument('-r-c', '--remove-cache', dest='remove_cache',
                                  help='remove cache. default: False', default=False, action='store_true')
    # depend
    # create the parser for the "b" command
    parser_dep = subparsers.add_parser(
        'depend', aliases=['d'], help='install vim dependency')
    parser_dep.add_argument('-i-p', '--ignore-python', dest='ignore_python',
                            help='python dependency. default: False', default=False, action='store_true')
    parser_dep.add_argument(
        '-n', '--node', help='node dependency', default=False, action='store_true')
    parser_dep.add_argument(
        '-c', '--cargo', help='cargo dependency', default=False, action='store_true')
    parser_dep.add_argument(
        '--after-shell', help='run shell script after all finished', default=None, type=str)
    parser_dep.add_argument(
        '--platform', help='platform dependency', default=None, type=str)
    parser_dep.add_argument(
        '--auto-platform', help='auto detect platform shell dependency', default=False, action='store_true')
    parser_dep.add_argument(
        '--all', help='ignore-python=False,node=True,cargo=True,auto-platform=True', default=False, action='store_true')
    parser_dep.set_defaults(func=depend)

    parser_download = subparsers.add_parser(
        'download', help='download and install lastest neovim')
    parser_download.set_defaults(func=download)
    parser_download.add_argument('-a', '--arch', choices=["linux64", "macos"],
                                 type=str, default="linux64")
    parser_dep.set_defaults(func=download)
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
