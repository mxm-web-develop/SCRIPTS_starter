#!/bin/bash

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"


mkdir -p "$TARGET_DIR/doc"

echo "doc file build on $TARGET_DIR/doc"