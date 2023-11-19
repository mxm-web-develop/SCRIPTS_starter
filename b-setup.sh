#!/bin/bash

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"

mkdir -p "$TARGET_DIR/back/app"
echo "设置 Python 后端..."
touch "$TARGET_DIR/back/app/__init__.py"
# 确保pip已安装
if command -v pip3 &> /dev/null; then
    PIP_CMD=pip3
elif command -v pip &> /dev/null; then
    PIP_CMD=pip
else
    echo "pip 未安装。请先安装 Python，并确保 pip 可用。"
    exit 1
fi

cd "$TARGET_DIR/back"
# 创建虚拟环境和其他操作
python3 -m venv venv

cat > main.py <<EOF
import os
import uvicorn

host = os.getenv("HOST", "127.0.0.1")
port = int(os.getenv("PORT", 8000))

if __name__ == "__main__":
    uvicorn.run("app.index:app", host=host, port=port)
EOF

cat > app/index.py <<EOF
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
EOF

# 创建 Dockerfile
cat > Dockerfile <<EOF
FROM python:3.9

# 设置工作目录
WORKDIR /usr/src/app

# 复制 requirements.txt 并安装依赖
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY ./app /usr/src/app/app
COPY main.py /usr/src/app/

# 暴露端口
EXPOSE 8000

# 运行应用
CMD ["python", "main.py"]
EOF

# 创建 run.sh 启动脚本
cat > run.sh <<EOF
#!/bin/bash
source venv/bin/activate
python main.py
EOF

cd -  # 返回之前的目录

# 进入后端项目目录
pushd "$TARGET_DIR/back"
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    source "$TARGET_DIR/back/venv/Scripts/activate"
else
    source "$TARGET_DIR/back/venv/bin/activate"
fi
# 安装 FastAPI 和 Uvicorn
$PIP_CMD install fastapi uvicorn
$PIP_CMD freeze > requirements.txt

popd

echo "Backend set up completed."
