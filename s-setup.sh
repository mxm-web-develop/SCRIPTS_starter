#!/bin/bash

# Define the GitHub repositories to clone
REPOS=(
    "https://github.com/mxm-web-develop/SCRIPTS_apiGenerator.git"
    # Add more repositories if needed
)

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"


mkdir -p "$TARGET_DIR/scripts"
# 从github地址抓取要用的工具包,比如第一个包是https://github.com/mxm-web-develop/SCRIPTS_apiGenerator
for repo in "${REPOS[@]}"; do
    repo_name=$(basename "$repo" .git)
    if [ ! -d "$TARGET_DIR/scripts/$repo_name" ]; then
        git clone "$repo" "$TARGET_DIR/scripts/$repo_name"
        echo "Cloned $repo_name into $TARGET_DIR/scripts/$repo_name"
    else
        echo "$repo_name already exists in $TARGET_DIR"
    fi
done

echo "脚本工程已初始化在 $TARGET_DIR/scripts"