#!/bin/bash


# 第一个参数是根目录的路径
# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"

mkdir -p "$TARGET_DIR/back"
# echo "请选择后端技术栈:"
# echo "1) Node.js (Express + TypeScript)"
# echo "2) Python (FastAPI)"
# read -p "输入选择 (1/2): " choice

# case $choice in
#     1)
    #     echo "设置 Node.js 后端..."
    #     # 初始化 Node.js 项目...
    #     # 请在此处添加使用 express-generator 或其他工具初始化 Node.js 项目的命令
      
    #     # 进入生成的项目目录
    #     pushd "$TARGET_DIR/back"  # 修改这里
    #     npx express-generator-typescript .

    #     # 安装项目依赖
    #     yarn install

    #     popd
    #     ;;
    # 2)
        echo "设置 Python 后端..."
        # 确保pip已安装
        if command -v pip3 &> /dev/null; then
            PIP_CMD=pip3
        elif command -v pip &> /dev/null; then
            PIP_CMD=pip
        else
            echo "pip 未安装。请先安装 Python，并确保 pip 可用。"
            exit 1
        fi
        # 进入后端项目目录
        pushd "$TARGET_DIR/back"  # 修改这里
        
        # 创建 Python 虚拟环境并激活它
        python3 -m venv venv
        source venv/bin/activate
        
        # 安装 FastAPI 和 Uvicorn
        $PIP_CMD install fastapi uvicorn
        
        # 创建一个简单的 FastAPI 应用文件 main.py
        cat > main.py <<EOF
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
EOF
    $PIP_CMD freeze > requirements.txt
  
    popd
        ;;
    # *)
        echo "no choice available"
        exit 1
        ;;
esac

echo "backend set up"