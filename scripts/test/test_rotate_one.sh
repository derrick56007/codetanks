#!/bin/bash

. ./scripts/helper/setup_host.sh

# ./scripts/dev/reset_db.sh

OUTPUT=$(./scripts/upload_tank.sh examples/dart/rotate_one.dart)


if [[ $OUTPUT != "9651569" ]]
then
  echo "Failed to upload examples/dart/rotate_one.dart"
  echo "Expected: 9651569"
  echo "Got: $OUTPUT"
  exit 1
fi

sleep 30

OUTPUT=$(./scripts/get_build_log.sh "9651569")


# this code needs fixing
if [[ "${OUTPUT}" == '"404"' ]]
then
  echo "Failed to get build log for 9651569"
  echo 'Got: "404"'
  exit 1
fi

echo "build log:"
echo "${OUTPUT}"

# docker compose logs builder

OUTPUT=$(./scripts/get_raw.sh "9651569")
RAW="$(<examples/dart/rotate_one.dart)"

if [[ "${OUTPUT}" != "${RAW}" ]]
then
  echo "Failed to get raw for 9651569"
  echo 'Got:'
  echo "${OUTPUT}"
  echo 'Expected:'
  echo "${RAW}"
  exit 1
fi

RAW="$(cat ./scripts/test/expected/test_rotate_one.txt)"

OUTPUT=$(./scripts/run_sim.sh "9651569")
if [[ "${OUTPUT}" != "waiting to build" ]]
then
  echo "Failed run sim for 9651569"
  echo 'Got:'
  echo "${OUTPUT}"
  echo 'Expected:'
  echo "waiting to build"
  exit 1
fi

sleep 120
OUTPUT=$(./scripts/run_sim.sh "9651569")

echo "${OUTPUT}" > ./scripts/test/output.txt
tr -d '\r'  < ./scripts/test/output.txt > ./scripts/test/output1.txt

echo "${RAW}" > ./scripts/test/raw.txt

if cmp ./scripts/test/output1.txt ./scripts/test/raw.txt;
then
    echo "success"
else
  echo "Failed determinism for sim 9651569"
  echo 'Got:'
  echo "${OUTPUT}"
  echo 'Expected:'
  echo "${RAW}"
  docker compose logs simulator
  exit 1
fi

echo "sim:"
echo "${OUTPUT}"