#!/bin/bash

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

sudo apt update && sudo apt-get install -y mongodb-org git

sudo systemctl start mongod && sudo systemctl enable mongod

git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install

puma -d