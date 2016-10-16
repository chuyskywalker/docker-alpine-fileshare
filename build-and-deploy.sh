#!/bin/bash

set -e # break on error.
set -u # break on using undefined variable.

# Go to right place
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

TS=$(git show -s --format=%ct HEAD)
ID=$(git rev-parse --short=12 HEAD)
CNAME="registry.service.consul/fs:$TS-$ID"

echo "-- Build deployment container ($CNAME)"
docker build -t $CNAME .

echo "-- Push to registry"
docker push $CNAME

echo "-- Short pause..."
sleep 5

echo "-- Refresh Nomad Deployment"
cp nomad.hcl /tmp/nomad.hcl
sed -i -e "s#{image}#$CNAME#" /tmp/nomad.hcl
docker cp /tmp/nomad.hcl nomad:/tmp/nomad.hcl
docker exec -ti nomad nomad run -address=http://192.168.1.51:4646 /tmp/nomad.hcl

echo "-- Done!"
