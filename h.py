#!/usr/bin/env python
# File: h.py
# Author: Yiklek
# Description: helper for installing vim config
# Last Modified: 二月 09, 2021
# Copyright (c) 2021 Yiklek

import argparse
import os
import sys
import venv
from os.path import join, isfile, isdir, abspath
import shutil

basedir = abspath(os.path.dirname(__file__))
homedir = abspath(os.getenv('HOME'))
xdg_config_dir = os.getenv('XDG_CONFIG_HOME')
xdg_cache_dir = os.getenv('XDG_CACHE_HOME')
ovim_dir = join(homedir, '.cache', 'ovim')
vim_py3_env_dir = join(ovim_dir, 'python3-venv')
cache_dir = xdg_cache_dir or join(homedir, '.cache')
ovim_cache_dir = join(cache_dir, 'ovim')

if os.name == 'nt':
    lib = 'Lib'
    vim_dep_source = join(vim_py3_env_dir, lib, 'site-packages')
    config_dir = xdg_config_dir or join(homedir, 'AppData', 'Local')
    vim_py = join(vim_py3_env_dir, 'Scripts', 'python.exe')
    vim_root_name = 'vimfiles'
else:
    lib = 'lib'
    vim_dep_source = join(vim_py3_env_dir, lib, 'python3.{}'.format(
        sys.version_info.minor), 'site-packages')
    config_dir = xdg_config_dir or join(homedir, '.config')
    vim_py = join(vim_py3_env_dir, 'bin', 'python')
    vim_root_name = '.vim'

vim_init_file = 'vimrc'
nvim_init_file = 'init.vim'
nvim_root_name = 'nvim'
vim_link = join(vim_py3_env_dir, lib, 'python3')
vim_requirements = join(basedir, 'ovim', 'requirements.txt')
vim_packages = join(basedir, 'ovim', 'packages.txt')


def depend(_, args):
    if not args.ignore_python:
        os.makedirs(ovim_dir, exist_ok=True)
        venv.main([vim_py3_env_dir])
        os.system('{} -m pip install -r {} -U'.format(vim_py, vim_requirements))
        # this symlink is for vim python dependency.
        # vim will search python/python3 module in all of runtimepath.
        # python site-packages path is different between on unix/linux and on windows
        # so create a symlink(python3) at Lib/lib, and set Lib/lib as vim runtimepath.
        # noevim does't need this symlink, but it does't matter.
        if os.path.exists(vim_link):
            os.remove(vim_link)
        os.symlink(vim_dep_source, vim_link,
                   target_is_directory=isdir(vim_dep_source))
    if args.node:
        with open(vim_packages, "r") as f:
            packages = f.read()
        packages = " ".join(packages.split('\n'))
        print("install node packages: {}".format(packages))
        os.system('npm install -g {}'.format(packages))


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
    print('create path %s successfully.')
    if not isfile(vim_config_init):
        os.symlink(join(basedir, 'vimrc'), vim_config_init)
    if not isfile(join(vim_config_path, 'autoload', 'plug.vim')):
        cmd = 'curl -fLo {} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'.format(
            join(vim_config_path, 'autoload', 'plug.vim'))
        os.system(cmd)
    else:
        print('plug.vim exist.')
    if not isdir(join(vim_config_path, 'dein.vim')):
        cmd = 'git clone https://github.com/Shougo/dein.vim {}'.format(
            join(vim_config_path, 'dein.vim'))
        os.system(cmd)
    else:
        print('dein.vim exist.')

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
        print("delete config dir %s successfully." % vim_config_path)
    except:
        print("delete config dir %s failed. please remove %s manually." %
              (vim_config_path, vim_config_path))
    if args.remove_cache:
        try:
            shutil.rmtree(ovim_cache_dir)
            print("delete config dir %s successfully." % ovim_cache_dir)
        except:
            print("delete config dir %s failed. please remove %s manually." %
                  (ovim_cache_dir, ovim_cache_dir))


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
    parser_dep.set_defaults(func=depend)
    return parser


def main(args):
    parser = create_arg_parser()
    arg = parser.parse_args(args)
    if arg.command is None:
        parser.print_help()
    else:
        arg.func(parser, arg)


if __name__ == "__main__":
    main(sys.argv[1:])
