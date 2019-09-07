import subprocess


def run(*args):
    """Run a command."""
    return subprocess.run(args, capture_output=True, check=True, text=True)


def listify(f):
    """Decorator to wrap the return value in a list."""

    def wrapper(*args, **kwargs):
        return list(f(*args, **kwargs))

    return wrapper


def setify(f):
    """Decorator to wrap the return value in a set."""

    def wrapper(*args, **kwargs):
        return set(f(*args, **kwargs))

    return wrapper


def lines(f):
    """Decorator to join the return value by a newline."""

    def wrapper(*args, **kwargs):
        return "\n".join(f(*args, **kwargs))

    return wrapper
