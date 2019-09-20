from functools import wraps
import subprocess


def run(*args):
    """Run a command."""
    return subprocess.run(args, capture_output=True, check=True, text=True)


def listify(f):
    """Decorator to wrap the return value in a list."""

    @wraps(f)
    def wrapper(*args, **kwargs):
        return list(f(*args, **kwargs))

    return wrapper


def setify(f):
    """Decorator to wrap the return value in a set."""

    @wraps(f)
    def wrapper(*args, **kwargs):
        return set(f(*args, **kwargs))

    return wrapper


def dictify(f):
    """Decorator to wrap the return value in a dict."""

    @wraps(f)
    def wrapper(*args, **kwargs):
        return dict(f(*args, **kwargs))

    return wrapper


def lines(f):
    """Decorator to join the return value by a newline."""

    @wraps(f)
    def wrapper(*args, **kwargs):
        return "\n".join(f(*args, **kwargs))

    return wrapper


def memoize(n=None):
    """Decorator to cache return values keyed by arguments.

    If n is specified, results are keyed by the first n arguments.
    """

    def decorator(f):
        cache = {}

        @wraps(f)
        def wrapper(*args, **kwargs):
            key = args if n is None else args[:n]

            try:
                result = cache[key]
            except KeyError:
                result = cache[key] = f(*args, **kwargs)

            return result

        return wrapper

    return decorator
