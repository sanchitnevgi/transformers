#!/bin/bash

# Install example requirements
pip install -r ../requirements.txt

# Download glue data
python3 ../../utils/download_glue_data.py