#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"
#docker run -v $DIR/ksdemo:/data/instances/ksdemo -p 50053:9053 -p 50051:9051 -p 50022:22 --name ksdemo -d ks
docker run \
     -v $DIR/data/instances:/data/instances \
     -v $DIR/data/scripts:/data/scripts \
     -v $DIR/data/additional_data:/data/additional_data \
     -p 50053:9053 \
     -p 50051:9051 \
     -p 50022:22 \
     --name ks-demo \
     -d ks
