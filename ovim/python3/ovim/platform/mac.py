from ovim.log import logger
from urllib import request
import json
import os
import zipfile
import tempfile


class MacRunner:
    homedir = os.path.abspath(os.getenv('HOME'))
    local_bin = os.path.join(homedir, '.local', 'bin')

    @classmethod
    def check_env(cls):
        if os.system("brew --version"):
            raise RuntimeError('homebrew is not exist.')
        if os.system("curl --version"):
            raise RuntimeError('curl is not exist.')

    @classmethod
    def install_fzf(cls):
        fzf_release_url = "https://api.github.com/repos/junegunn/fzf/releases/latest"
        resp = request.urlopen(fzf_release_url)
        j = resp.read().decode()
        j = json.loads(j)
        latest_tag_name = j['tag_name']
        file_url = "https://github.com/junegunn/fzf/releases/download/{}/fzf-{}-darwin_amd64.zip".format(
            latest_tag_name, latest_tag_name)
        logger.info("download fzf...")
        resp = request.urlopen(file_url)
        temp_file = tempfile.TemporaryFile()
        temp_file.write(resp.read())
        resp.close()
        temp_file.seek(0)
        zfile = zipfile.ZipFile(temp_file, "r")
        os.makedirs(cls.local_bin, exist_ok=True)
        zfile.extract('fzf', cls.local_bin)
        logger.info("fzf extract to {}".format(cls.local_bin))
        zfile.close()
        temp_file.close()

    @classmethod
    def install_ctags(cls):
        r = os.popen("brew tap")
        r = r.read()
        if "universal-ctags/universal-ctags" not in r:
            os.system("brew tap universal-ctags/universal-ctags")
        os.system(
            "brew install --HEAD universal-ctags/universal-ctags/universal-ctags")

    @classmethod
    def run(cls):
        try:
            logger.info("mac runner start.")
            cls.install_ctags()
            cls.install_fzf()
        except Exception as e:
            logger.error("MacRunner occured error {}".format(e))
