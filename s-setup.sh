#!/bin/bash

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"


mkdir -p "$TARGET_DIR/scripts"

echo "脚本工程已初始化在 $TARGET_DIR/scripts"