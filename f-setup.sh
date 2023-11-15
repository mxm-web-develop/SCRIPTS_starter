#!/bin/bash

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"

# 创建前端文件夹
mkdir -p "$TARGET_DIR/front"

# 初始化前端
pushd "$TARGET_DIR/front"
if ! command -v yarn &> /dev/null; then
    echo "yarn 未安装。请先安装 yarn。"
    exit 1
else
    yarn create vite . --template react-ts
fi
popd

echo "前端项目已初始化在 $TARGET_DIR/front"
