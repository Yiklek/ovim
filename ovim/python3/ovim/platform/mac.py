from ovim.log import logger
from urllib import request
import json
import os
import zipfile
import tempfile
from .runner import BaseRunner


class MacRunner(BaseRunner):

    def check_env(self):
        if os.system("brew --version"):
            raise RuntimeError('homebrew is not exist.')
        if os.system("curl --version"):
            raise RuntimeError('curl is not exist.')

    def install_fzf(self):
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
        os.makedirs(self.local_bin, exist_ok=True)
        zfile.extract('fzf', self.local_bin)
        logger.info("fzf extract to {}".format(self.local_bin))
        zfile.close()
        temp_file.close()

    def install_ctags(self):
        with os.popen("brew tap") as f:
            r = f.read()
        if "universal-ctags/universal-ctags" not in r:
            os.system("brew tap universal-ctags/universal-ctags")
        os.system(
            "brew install --HEAD universal-ctags/universal-ctags/universal-ctags")

    def run(self):
        try:
            logger.info("mac runner start.")
            self.install_ctags()
            self.install_fzf()
        except Exception as e:
            logger.error("MacRunner occured error {}".format(e))
