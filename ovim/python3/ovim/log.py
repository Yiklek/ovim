import logging


class ColorFormatter(logging.Formatter):
    """Logging Formatter to add colors and count warning / errors"""

    grey = "\x1b[38;21m"
    yellow = "\x1b[33;21m"
    green = "\x1b[32;21m"
    blue = "\x1b[34;21m"
    red = "\x1b[31;21m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"
    # format = "%(asctime)s - %(name)s (%(filename)s:%(lineno)d) - %(levelname)s - %(message)s"
    format = "%(message)s"

    FORMATS = {
        logging.DEBUG: green + format + reset,
        logging.INFO: grey + format + reset,
        logging.WARNING: yellow + format + reset,
        logging.ERROR: red + format + reset,
        logging.CRITICAL: bold_red + format + reset
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


level = logging.DEBUG
logger = logging.getLogger()
logger.setLevel(level)

# create console handler with a higher log level
ch = logging.StreamHandler()
ch.setLevel(level)

ch.setFormatter(ColorFormatter())

logger.addHandler(ch)
