from ovim.log import logger
from urllib import request
import json
import tarfile
import tempfile
import os

class UbuntuRunner:
    homedir = os.path.abspath(os.getenv('HOME'))
    local_bin = os.path.join(homedir, '.local', 'bin')

    @classmethod
    def check_env(cls):
        if os.system("curl --version"):
            raise RuntimeError('curl is not exist.')

    @classmethod
    def install_fzf(cls):
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
        os.makedirs(cls.local_bin, exist_ok=True)
        tfile.extract('fzf', cls.local_bin)
        logger.info("fzf extract to {}".format(cls.local_bin))
        tfile.close()
        temp_file.close()

    @classmethod
    def install_ctags(cls):
        with os.popen("apt list --installed universal-ctags") as f:
            r = f.read()
        logger.info(r)
        if "universal-ctags" not in r:
            os.system("apt-get install universal-ctags -y")

    @classmethod
    def run(cls):
        try:
            logger.info("ubuntu runner start.")
            cls.install_ctags()
            cls.install_fzf()
        except Exception as e:
            logger.error("UbuntuRunner occured error {}".format(e))
