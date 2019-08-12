#!/bin/bash

set -eu

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export fly_target=${fly_target:-devops}
echo "Concourse API target ${fly_target}"
echo "Tutorial $(basename $DIR)"

pushd "$DIR"
   fly -t ${fly_target} validate-pipeline --config pipeline.yml
  fly -t ${fly_target} set-pipeline -p concourse-nodejs -c pipeline.yml
  fly -t ${fly_target} unpause-pipeline -p concourse-nodejs
  fly -t ${fly_target} trigger-job -w -j concourse-nodejs/integration-test
popd