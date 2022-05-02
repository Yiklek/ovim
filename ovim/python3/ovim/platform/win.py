from ovim.log import logger
import os
from urllib import request
import tempfile
import zipfile
from .runner import BaseRunner


class WinRunner(BaseRunner):

    def check_env(self):
        if os.system("curl.exe --version"):
            raise RuntimeError('curl is not exist.')
        else:
            self.has_curl = True
        if os.system("scoop --version"):
            self.has_scoop = False
        else:
            self.has_scoop = True
        if os.system("unzip --version"):
            self.has_unzip = False
        else:
            self.has_unzip = True

    def install_libsqlite3(self):
        sqlite_dir = os.path.join(self.homedir, ".cache", "ovim", "plugins", "sqlite")
        sqlite_zip = os.path.join(sqlite_dir, "sqlite-dll-win64.zip")
        sqlite_dll = os.path.join(sqlite_dir, "sqlite3.dll")
        file_url = "https://www.sqlite.org/2022/sqlite-dll-win64-x64-3380300.zip"
        try:
            if os.path.isfile(sqlite_dll):
                return
            logger.info("download libsqlite3...")
            resp = request.urlopen(file_url)
            temp_file = tempfile.TemporaryFile()
            temp_file.write(resp.read())
            resp.close()
            temp_file.seek(0)
            zfile = zipfile.ZipFile(file=temp_file, mode='r')
            os.makedirs(sqlite_dir, exist_ok=True)
            zfile.extractall(sqlite_dir)
            logger.info("sqlite3.dll extract to {}".format(sqlite_dir))
            zfile.close()
            temp_file.close()
        except:
            if not self.has_unzip and self.has_scoop:
                os.system("scoop install unzip")
            elif not self.has_scoop:
                logger.error("unzip and scoop are not installed.")
                return

            os.makedirs(sqlite_dir, exist_ok=True)
            logger.info("download libsqlite3...")
            if not os.path.isfile(sqlite_zip):
                r = os.system("curl.exe {} -o {}".format(file_url, sqlite_zip))
                if r:
                    logger.error("install libsqlite3 failed.")
                    return
            if not os.path.isfile(sqlite_dll):
                logger.info("sqlite3.dll extract to {}".format(sqlite_dir))
                r = os.system("unzip -d {} {}".format(sqlite_dir, sqlite_zip))
                if r:
                    logger.error("install libsqlite3 failed.")
                    return

    def run(self):
        try:
            logger.info("windows runner start.")
            self.install_libsqlite3()
            logger.info("windows runner finish.")
        except Exception as e:
            logger.error("WinRunner occured error {}".format(e))
            import traceback
            traceback.print_exception(e)
