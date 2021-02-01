#!/usr/bin/env python
import argparse
import os
import sys
import venv
from os.path import join, isfile, isdir, abspath

basedir = abspath(os.path.dirname(__file__))
homedir = abspath(os.getenv('HOME'))
xdg_config_dir = os.getenv('XDG_CONFIG_HOME')
ovim_dir = join(homedir, '.cache', 'ovim')
vim_py3_env_dir = join(ovim_dir, 'python3-venv')

if os.name == 'nt':
    lib = 'Lib'
    vim_dep_source = join(vim_py3_env_dir, lib, 'site-packages')
    config_dir = join(homedir, 'AppData', 'Local')
    vim_py = join(vim_py3_env_dir, 'Scripts', 'python.exe')
else:
    lib = 'lib'
    vim_dep_source = join(vim_py3_env_dir, lib, 'python3.{}'.format(
        sys.version_info.minor), 'site-packages')
    config_dir = join(homedir, '.config')
    vim_py = join(vim_py3_env_dir, 'bin', 'python')

vim_link = join(vim_py3_env_dir, lib, 'python3')
vim_requirements = join(basedir, 'ovim', 'requirements.txt')


def depend(_, args):
    if not args.ignore_python:
        os.makedirs(ovim_dir, exist_ok=True)
        venv.main([vim_py3_env_dir])
        os.system('{} -m pip install -r {} -U'.format(vim_py, vim_requirements))
        if os.path.exists(vim_link):
            os.remove(vim_link)
        os.symlink(vim_dep_source, vim_link,
                   target_is_directory=isdir(vim_dep_source))
    if args.node:
        os.system('npm install -g neovim bash-language-server')


def install(parser, args):
    target = args.target
    global config_dir
    vim_config_path = ''
    vim_config_init = ''
    if target == 'vim':
        vim_config_path = join(homedir, '.vim')
        vim_config_init = join(vim_config_path, 'vimrc')
    elif target == 'nvim':
        config_dir = config_dir if xdg_config_dir is None else xdg_config_dir
        vim_config_path = join(config_dir, 'nvim')
        vim_config_init = join(vim_config_path, 'init.vim')

    os.makedirs(vim_config_path, exist_ok=True)

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


def create_arg_parser():
    parser = argparse.ArgumentParser(description='vim config helper.')
    subparsers = parser.add_subparsers(metavar="COMMAND", dest='command')
    parser_install = subparsers.add_parser(
        'install', aliases=['i'], help='install vim config')
    parser_install.set_defaults(func=install)
    parser_install.add_argument('target', metavar='TARGET', choices=[
        'vim', 'nvim'], default='vim', help='option choices: vim, nvim. default: vim', nargs='?')
    parser_install.add_argument('-d', '--depend', dest='install_depend', type=str,
                                action='append', nargs='?', help='install dependency.example: -d="-i-p" -d="-n"')
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
