#!/bin/bash

. ./scripts/helper/setup_host.sh

curl -sS $HOST/log/$1 --http1.1
# docker run --network host --rm curlimages/curl:7.80.0 -sS $HOST/log/$1 --http1.1
echo ""
