import os

from . import git

basedir = git.root()
readme_template = os.path.join(basedir, "README.md.in")
readme = os.path.join(basedir, "README.md")
images = os.path.join(basedir, "images.json")
makefile = os.path.join(basedir, "Makefile")
