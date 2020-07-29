#!/bin/bash -eu

echo "Initialize local valuables"

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export AWS_DEFAULT_REGION=$3
readonly PACKAGE_FILE=$4
readonly TARGET_DIR=$5
readonly package=$(yq -y .package ${PACKAGE_FILE} | head -n1)
readonly s3_bucket="s3://${package}"
readonly commit_id=$(echo ${package} | tr "." "\n" | head -n 1 | tr "." "\n" | tail -n 1)

echo "[Show valuables]"
echo "AWS_DEFAULT_REGION: ${AWS_DEFAULT_REGION}"
echo "package: ${package}"
echo "commit_id: ${commit_id}"
echo "TARGET_DIR: ${TARGET_DIR}"
echo "PACKAGE_FILE: ${PACKAGE_FILE}"
echo "[Start copy ${s3_bucket} to current dir]"
echo "::set-env name=COMMIT_ID::${commit_id}"

aws s3 cp ${s3_bucket} package.tar.gz

mkdir -p ${TARGET_DIR}
echo "[Show contents of ${TARGET_DIR}]"
ls ${TARGET_DIR}

echo "[Open ${package} to ${TARGET_DIR}]"
tar -zxvf package.tar.gz -C ${TARGET_DIR}

echo "[Show content of ${TARGET_DIR}]"
ls -aR ${TARGET_DIR}
