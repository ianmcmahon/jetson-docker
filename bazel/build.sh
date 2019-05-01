#!/bin/sh
echo "Building bazel"

docker build -t ianmcmahon/jetson-docker:bazel-build .

docker container create --name extract ianmcmahon/jetson-docker:bazel-build
docker container cp extract:/root/bazel/output/bazel .
docker conatiner rm -f extract
