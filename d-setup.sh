#!/bin/bash

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"

# 创建 docker-compose.yml 文件
cat > "$TARGET_DIR/docker-compose.yml" <<EOF
version: '3'
services:
  front:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./front:/usr/share/nginx/html
  back:
    image: python:3.9
    ports:
      - "8000:8000"
    volumes:
      - ./back:/usr/src/app
    working_dir: /usr/src/app
    command: /usr/src/app/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
    environment:
      - PYTHONUNBUFFERED=1
EOF

echo "Docker配置已创建在 $TARGET_DIR/docker-compose.yml"
