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
# # 确认是否要自动安装 React 项目相关工具
# read -p "是否开始 React 项目相关工具的安装？(自动/手动): " install_choice

# if [ "$install_choice" == "自动" ]; then
#     # 添加 React 项目相关工具的安装命令，例如：
#     yarn add some-library
# fi

  # 从 GitHub 拉取文件并添加到 front/README.md
  curl --connect-timeout 30 -o "$TARGET_DIR/front/README.md" "https://raw.githubusercontent.com/mxm-web-develop/DOCS_mydocs/main/mxm-js-libs.md"

  echo "README 已更新。"
popd

echo "前端项目已初始化在 $TARGET_DIR/front"
