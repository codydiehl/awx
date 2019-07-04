#!/bin/bash

# verify ansible is installed: 
if [ `command -v ansible` ]; then
  # store ansible version: 
  AVER=$(ansible --version | head -1 | cut -d' ' -f2)
  # compare it is the proper version needed: 
  if [[ "$AVER" = "2.8"* ]]; then
    # Version is 2.8
    echo "O - Ansible 2.8 is installed"
  else
    echo "X - Ansible is not version 2.8 please upgrade"
  fi
else
  echo "X - Ansible is not installed [pip install ansible]"
fi


# verify PIP Requirements
if [ `command -v pip` ]; then
  # check docker module installed
  PIPDKR=$(PYTHONWARNINGS=ignore:DEPRECATION pip list | grep -w "docker " >/dev/null 2>&1)
  if [[ $? -ne 1 ]]; then
    echo "O - Python Module docker is installed"
  else
    echo "X - Python Module docker is not installed [pip install docker]"
  fi

  # check docker-compose module installed
  PIPDKRCMP=$(PYTHONWARNINGS=ignore:DEPRECATION pip list | grep -w "docker-compose" >/dev/null 2>&1)
  if [[ $? -ne 1 ]]; then
    echo "O - Python Module docker-compose is installed"
  else
    echo "X - Python Module docker-compose is missing [pip install docker-compose]"
  fi
else
  echo "X - pip is not installed [curl https://bootstrap.pypa.io/get-pip.py | python]"
fi

# confirm docker is installed and running
if [ `command -v docker` ]; then
  docker_state=$(docker info >/dev/null 2>&1)
  if [[ $? -ne 1 ]]; then
    echo "O - Docker is running"
  else
    echo "X - Docker is not running, please start docker"
  fi
else
  echo "X - Docker is not installed [curl -fsSL https://get.docker.com | sh]"
fi

# confirm NodeJS NPM installed
if [ `command -v npm` ]; then
  npm_version=$(npm -v | grep '^6\.' >/dev/null 2>&1)
  if [[ $? -ne 1 ]]; then
    echo "O - NPM is at least Version 6"
  else 
    echo "X - NPM needs to be upgraded to version 6"
  fi
else
  echo "X - NPM is not installed [curl https://www.npmjs.org/install.sh | sh]"
fi

# confirm GNU Make installed
if [ `command -v make` ]; then
  echo "O - GNU Make is installed"
else
  echo "X - GNU Make is not installed"
fi

