import os
class BaseRunner:
    def __init__(self):
        self.homedir = os.path.abspath(os.path.expanduser("~"))
        self.local_bin = os.path.join(self.homedir, '.local', 'bin')

    def check_env(self):
        raise RuntimeError("unimplemented")

    def run(self):
        raise RuntimeError("unimplemented")
