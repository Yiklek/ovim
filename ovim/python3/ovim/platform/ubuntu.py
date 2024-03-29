from ovim.log import logger
from urllib import request
import json
import tarfile
import tempfile
import os
from .runner import BaseRunner

class UbuntuRunner(BaseRunner):

    def check_env(self):
        if os.system("curl --version"):
            raise RuntimeError('curl is not exist.')

    def install_fzf(self):
        with os.popen("uname -sm") as f:
            arch = f.read()
        arch = arch.strip()
        logger.info(arch)
        if arch.endswith("64"):
            arch = "linux_amd64"
        elif "armv5" in arch:
            arch = "linux_armv5"
        elif "armv6" in arch:
            arch = "linux_armv6"
        elif "armv7" in arch:
            arch = "linux_amdv7"
        elif "armv8" in arch:
            arch = "linux_amd64"
        elif "aarch64" in arch:
            arch = "linux_amd64"

        fzf_release_url = "https://api.github.com/repos/junegunn/fzf/releases/latest"
        resp = request.urlopen(fzf_release_url)
        j = resp.read().decode()
        j = json.loads(j)
        latest_tag_name = j['tag_name']
        file_url = "https://github.com/junegunn/fzf/releases/download/{}/fzf-{}-{}.tar.gz".format(
            latest_tag_name, latest_tag_name, arch)
        logger.info("download fzf...")
        resp = request.urlopen(file_url)
        temp_file = tempfile.TemporaryFile()
        temp_file.write(resp.read())
        resp.close()
        temp_file.seek(0)
        tfile = tarfile.open(fileobj=temp_file, mode='r')
        os.makedirs(self.local_bin, exist_ok=True)
        tfile.extract('fzf', self.local_bin)
        logger.info("fzf extract to {}".format(self.local_bin))
        tfile.close()
        temp_file.close()

    def install_ctags(self):
        with os.popen("apt list --installed universal-ctags") as f:
            r = f.read()
        logger.info(r)
        if "universal-ctags" not in r:
            os.system("apt-get install universal-ctags -y")

    def install_libsqlite3(self):
        with os.popen("apt list --installed libsqlite3-dev") as f:
            r = f.read()
        logger.info(r)
        if "libsqlite3-dev" not in r:
            os.system("apt-get install libsqlite3-dev -y")

    def run(self):
        try:
            logger.info("ubuntu runner start.")
            self.install_ctags()
            self.install_fzf()
            self.install_libsqlite3()
        except Exception as e:
            logger.error("UbuntuRunner occured error {}".format(e))
