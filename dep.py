#!/usr/bin/env python
import sys,os
import venv
import pip
basedir = os.path.abspath(os.path.dirname(__file__))
homedir = os.path.abspath(os.getenv('HOME'))
venvdir = os.path.join(homedir,'.cache','venv')
vim_env_dir = os.path.join(venvdir,'vim')
if os.name == 'nt':
    lib = 'Lib'
    vim_dep_source = os.path.join(vim_env_dir,lib,'site-packages')
else:
    lib = 'lib'
    vim_dep_source = os.path.join(vim_env_dir,lib,'python3.{}'.format(sys.version_info.minor),'site-packages')

vim_link = os.path.join(vim_env_dir,lib,'python3')
vim_py = os.path.join(vim_env_dir,'bin','python')
vim_requirements = os.path.join(basedir,'ovim','requirements.txt')
def main():
    os.makedirs(venvdir,exist_ok=True)
    venv.main([vim_env_dir])
    os.system('{} -m pip install -r {} -U'.format(vim_py,vim_requirements))
    if os.path.exists(vim_link):
        os.remove(vim_link)
    os.symlink(vim_dep_source,vim_link)
    # pip.main(['install','-r',os.path.join(basedir,'ovim','requirements.txt'),'-U'])
if __name__ == "__main__":
    main()
