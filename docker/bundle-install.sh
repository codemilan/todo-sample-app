#!/bin/bash

set -x
apt-get install -y libmysqlclient-dev
gem     update
bundle  install
