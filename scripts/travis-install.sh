#!/bin/bash

set -eo pipefail

# Install GNU m4.
sudo apt-get update
sudo apt-get install -y --no-install-recommends m4

# Install Poetry.
curl -LO https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py
python get-poetry.py --preview --yes
. ~/.poetry/env

# Install the scripts.
cd scripts/docker-buildbot-worker
poetry export -f requirements.txt | pip install -r /dev/stdin
poetry build && pip install dist/*.whl
