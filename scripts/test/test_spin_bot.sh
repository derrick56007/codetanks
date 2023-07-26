#!/bin/bash

. ./scripts/helper/setup_host.sh

# ./scripts/dev/reset_db.sh

OUTPUT=$(./scripts/dev/no-docker/upload_tank.sh examples/dart/spin_bot.dart)


if [[ $OUTPUT != "1wexiev" ]]
then
  echo "Failed to upload examples/dart/spin_bot.dart"
  echo "Expected: 1wexiev"
  echo "Got: $OUTPUT"
  exit 1
fi

sleep 30

OUTPUT=$(./scripts/dev/no-docker/get_build_log.sh "1wexiev")


# this code needs fixing
if [[ "${OUTPUT}" == '"404"' ]]
then
  echo "Failed to get build log for 1wexiev"
  echo 'Got: "404"'
  exit 1
fi

echo "build log:"
echo "${OUTPUT}"

# docker compose logs builder

OUTPUT=$(./scripts/dev/no-docker/get_raw.sh "1wexiev")
RAW="$(<examples/dart/spin_bot.dart)"

if [[ "${OUTPUT}" != "${RAW}" ]]
then
  echo "Failed to get raw for 1wexiev"
  echo 'Got:'
  echo "${OUTPUT}"
  echo 'Expected:'
  echo "${RAW}"
  exit 1
fi

RAW='1wexiev,1wexiev
21|10,0,0,0,-0.70710677,0.70710677,0,0,-0.70710677,0.70710677,0,0,-0.70710677,0.70710677
21|160,0,0,0,-0.70710677,0.70710677,0,0,-0.70710677,0.70710677,0,0,-0.70710677,0.70710677
21|11.666667,0,0,0,-0.71263844,0.70153147,0,0,-0.71263844,0.70153147,0,0,-0.71263844,0.70153147
21|161.66667,0,0,0,-0.71263844,0.70153147,0,0,-0.71263844,0.70153147,0,0,-0.71263844,0.70153147
21|13.333127,-0.026178617,0,0,-0.71812624,0.69591284,0,0,-0.71812624,0.69591284,0,0,-0.71812624,0.69591284
21|163.33313,-0.026178546,0,0,-0.71812624,0.69591284,0,0,-0.71812624,0.69591284,0,0,-0.71812624,0.69591284
21|14.998971,-0.07852963,0,0,-0.7235697,0.6902513,0,0,-0.7235697,0.6902513,0,0,-0.7235697,0.6902513
21|164.99898,-0.07852949,0,0,-0.7235697,0.6902513,0,0,-0.7235697,0.6902513,0,0,-0.7235697,0.6902513
21|16.663786,-0.15704003,0,0,-0.72896856,0.6845472,0,0,-0.72896856,0.6845472,0,0,-0.72896856,0.6845472
21|166.66379,-0.15703999,0,0,-0.72896856,0.6845472,0,0,-0.72896856,0.6845472,0,0,-0.72896856,0.6845472
21|18.327164,-0.2616905,0,0,-0.7343224,0.6788008,0,0,-0.7343224,0.6788008,0,0,-0.7343224,0.6788008
21|168.32716,-0.26169047,0,0,-0.7343224,0.6788008,0,0,-0.7343224,0.6788008,0,0,-0.7343224,0.6788008
21|19.988693,-0.39245534,0,0,-0.73963106,0.67301255,0,0,-0.73963106,0.67301255,0,0,-0.73963106,0.67301255
21|169.9887,-0.39245543,0,0,-0.73963106,0.67301255,0,0,-0.73963106,0.67301255,0,0,-0.73963106,0.67301255
21|21.647963,-0.54930234,0,0,-0.744894,0.6671828,0,0,-0.744894,0.6671828,0,0,-0.744894,0.6671828
21|171.64796,-0.54930246,0,0,-0.744894,0.6671828,0,0,-0.744894,0.6671828,0,0,-0.744894,0.6671828
21|23.304565,-0.7321927,0,0,-0.75011104,0.6613119,0,0,-0.75011104,0.6613119,0,0,-0.75011104,0.6613119
21|173.30457,-0.73219275,0,0,-0.75011104,0.6613119,0,0,-0.75011104,0.6613119,0,0,-0.75011104,0.6613119
21|24.95809,-0.9410812,0,0,-0.75528175,0.6554002,0,0,-0.75528175,0.6554002,0,0,-0.75528175,0.6554002
21|174.9581,-0.94108135,0,0,-0.75528175,0.6554002,0,0,-0.75528175,0.6554002,0,0,-0.75528175,0.6554002
21|26.60813,-1.1759164,0,0,-0.7604059,0.6494481,0,0,-0.7604059,0.6494481,0,0,-0.7604059,0.6494481
21|176.60814,-1.1759166,0,0,-0.7604059,0.6494481,0,0,-0.7604059,0.6494481,0,0,-0.7604059,0.6494481
21|28.254276,-1.4366403,0,0,-0.7654832,0.6434559,0,0,-0.7654832,0.6434559,0,0,-0.7654832,0.6434559
21|178.25429,-1.4366405,0,0,-0.7654832,0.6434559,0,0,-0.7654832,0.6434559,0,0,-0.7654832,0.6434559
21|29.896126,-1.7231885,0,0,-0.7705132,0.63742405,0,0,-0.7705132,0.63742405,0,0,-0.7705132,0.63742405
21|179.89613,-1.7231889,0,0,-0.7705132,0.63742405,0,0,-0.7705132,0.63742405,0,0,-0.7705132,0.63742405
21|31.533272,-2.0354905,0,0,-0.7754957,0.63135284,0,0,-0.7754957,0.63135284,0,0,-0.7754957,0.63135284
21|181.53328,-2.0354908,0,0,-0.7754957,0.63135284,0,0,-0.7754957,0.63135284,0,0,-0.7754957,0.63135284
21|33.16531,-2.373469,0,0,-0.7804304,0.6252427,0,0,-0.7804304,0.6252427,0,0,-0.7804304,0.6252427
21|183.16531,-2.3734694,0,0,-0.7804304,0.6252427,0,0,-0.7804304,0.6252427,0,0,-0.7804304,0.6252427
21|34.791836,-2.737041,0,0,-0.7853169,0.619094,0,0,-0.7853169,0.619094,0,0,-0.7853169,0.619094
21|184.79184,-2.7370415,0,0,-0.7853169,0.619094,0,0,-0.7853169,0.619094,0,0,-0.7853169,0.619094
21|36.412453,-3.1261165,0,0,-0.790155,0.6129071,0,0,-0.790155,0.6129071,0,0,-0.790155,0.6129071
21|186.41246,-3.1261168,0,0,-0.790155,0.6129071,0,0,-0.790155,0.6129071,0,0,-0.790155,0.6129071
21|38.02676,-3.5405993,0,0,-0.79494435,0.60668236,0,0,-0.79494435,0.60668236,0,0,-0.79494435,0.60668236
21|188.02676,-3.5405998,0,0,-0.79494435,0.60668236,0,0,-0.79494435,0.60668236,0,0,-0.79494435,0.60668236
21|39.634357,-3.9803877,0,0,-0.79968464,0.60042024,0,0,-0.79968464,0.60042024,0,0,-0.79968464,0.60042024
21|173.30457,-211.47006,0,0,0.744894,0.6671828,0,0,0.744894,0.6671828,0,0,0.744894,0.6671828
21|21.647963,-211.65295,0,0,0.73963106,0.67301255,0,0,0.73963106,0.67301255,0,0,0.73963106,0.67301255
21|171.64795,-211.65295,0,0,0.73963106,0.67301255,0,0,0.73963106,0.67301255,0,0,0.73963106,0.67301255
21|19.988693,-211.8098,0,0,0.7343225,0.67880076,0,0,0.7343225,0.67880076,0,0,0.7343225,0.67880076
21|169.98868,-211.8098,0,0,0.7343225,0.67880076,0,0,0.7343225,0.67880076,0,0,0.7343225,0.67880076
21|18.327164,-211.94058,0,0,0.7289686,0.6845471,0,0,0.7289686,0.6845471,0,0,0.7289686,0.6845471
21|168.32715,-211.94058,0,0,0.7289686,0.6845471,0,0,0.7289686,0.6845471,0,0,0.7289686,0.6845471
21|16.663786,-212.04521,0,0,0.72356975,0.6902513,0,0,0.72356975,0.6902513,0,0,0.72356975,0.6902513
21|166.66377,-212.04521,0,0,0.72356975,0.6902513,0,0,0.72356975,0.6902513,0,0,0.72356975,0.6902513
21|14.998969,-212.12373,0,0,0.7181263,0.69591284,0,0,0.7181263,0.69591284,0,0,0.7181263,0.69591284
21|164.99896,-212.12373,0,0,0.7181263,0.69591284,0,0,0.7181263,0.69591284,0,0,0.7181263,0.69591284
21|13.333125,-212.17609,0,0,0.7126385,0.70153147,0,0,0.7126385,0.70153147,0,0,0.7126385,0.70153147
21|163.33311,-212.17609,0,0,0.7126385,0.70153147,0,0,0.7126385,0.70153147,0,0,0.7126385,0.70153147
21|11.666664,-212.20227,0,0,0.70710677,0.7071068,0,0,0.70710677,0.7071068,0,0,0.70710677,0.7071068
21|161.66666,-212.20227,0,0,0.70710677,0.7071068,0,0,0.70710677,0.7071068,0,0,0.70710677,0.7071068
{"1wexiev1wexiev-1wexiev-0":{"damage_given":10,"health":100,"index":0,"tank_id":"1wexiev"},"1wexiev1wexiev-1wexiev-1":{"damage_given":0,"health":90,"index":1,"tank_id":"1wexiev"},"tanks":["1wexiev"],"winner":"1wexiev1wexiev-1wexiev-0","winner_index":0}'

OUTPUT=$(./scripts/dev/no-docker/run_sim.sh "1wexiev" "1wexiev")
if [[ "${OUTPUT}" != "waiting to build" ]]
then
  echo "Failed run sim for 1wexiev"
  echo 'Got:'
  echo "${OUTPUT}"
  echo 'Expected:'
  echo "waiting to build"
  exit 1
fi

sleep 120
OUTPUT=$(./scripts/dev/no-docker/run_sim.sh "1wexiev" "1wexiev")

echo "${OUTPUT}" > ./scripts/test/output.txt
tr -d '\r'  < ./scripts/test/output.txt > ./scripts/test/output1.txt

echo "${RAW}" > ./scripts/test/raw.txt

if cmp ./scripts/test/output1.txt ./scripts/test/raw.txt;
then
    echo "success"
else
  echo "Failed determinism for sim 1wexiev"
  echo 'Got:'
  echo "${OUTPUT}"
  echo 'Expected:'
  echo "${RAW}"
  docker compose logs simulator
  # docker compose logs server
#   docker ps
  # docker compose logs
  exit 1
fi

echo "sim:"
echo "${OUTPUT}"