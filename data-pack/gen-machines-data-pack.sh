#!/bin/sh

SCRIPT=$(readlink -f $0)
SCRIPTS_PATH=$(dirname $SCRIPT)

BASE_DIR="$SCRIPTS_PATH"

TARGET_NAME=machines-data-pack
DATE_STR=$(date +%Y%m%d)

rm -rf "$TARGET_NAME"
mkdir -p "$TARGET_NAME"

# Pre-scaled commands and few other images to fixup the scaling artefacts
cp -rf $BASE_DIR/pre-scaled-files/* "$TARGET_NAME" || exit 1

# Manually scaled files which are not good enough to get into the repository
cp -rf $BASE_DIR/even-more-files/* "$TARGET_NAME" || exit 1

# Grayscaled files which normally can be generated from machines-data files
# but not in CI environment due to missing X11 display (required for gimp)
cp -rf $BASE_DIR/grayscaled/* "$TARGET_NAME" || exit 1

# Data from machines-data repository
cp -rf $BASE_DIR/baked-machines-data/* "$TARGET_NAME" || exit 1

zip -r "$TARGET_NAME-$DATE_STR" "$TARGET_NAME" || exit 1
