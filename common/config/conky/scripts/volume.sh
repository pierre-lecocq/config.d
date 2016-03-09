#!/bin/sh

# File: volume.sh
# Time-stamp: <2016-03-09 10:02:13>
# Copyright (C) 2016 Pierre Lecocq
# Description:

amixer sget Master,0 | egrep -o '[0-9]+%'
