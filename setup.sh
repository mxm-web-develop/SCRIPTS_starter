#!/bin/bash

# 脚本所在的目录，即setups文件夹的路径
SETUP_DIR="$(dirname "$(realpath "$0")")"

# 根目录 - 即setups文件夹的父目录
ROOT_DIR="$(dirname "$SETUP_DIR")"

# 赋予所有脚本执行权限
chmod +x "$SETUP_DIR/f-setup.sh" "$SETUP_DIR/b-setup.sh" "$SETUP_DIR/d-setup.sh" "$SETUP_DIR/s-setup.sh"

#调用前端设置脚本
bash "$SETUP_DIR/f-setup.sh" "$ROOT_DIR"

# 调用后端设置脚本
bash "$SETUP_DIR/b-setup.sh" "$ROOT_DIR"

# 调用Docker设置脚本
bash "$SETUP_DIR/d-setup.sh" "$ROOT_DIR"


# # 调用Scripts脚本
bash "$SETUP_DIR/s-setup.sh" "$ROOT_DIR"

# 调用文档脚本
bash "$SETUP_DIR/doc-setup.sh" "$ROOT_DIR"


# 删除已执行的脚本文件
rm -f "$SETUP_DIR/f-setup.sh"
rm -f "$SETUP_DIR/b-setup.sh"
rm -f "$SETUP_DIR/d-setup.sh"
rm -f "$SETUP_DIR/s-setup.sh"
rm -f "$SETUP_DIR/doc-setup.sh"

echo "所有设置已完成。"
