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

  # 从 GitHub 拉取文件并添加到 front/README.md
  if ! curl --connect-timeout 30 -o "$TARGET_DIR/front/README.md" "https://raw.githubusercontent.com/mxm-web-develop/DOCS_mydocs/main/mxm-js-libs.md"; then
      echo "MXM RECOMMEND LIB LIST: https://github.com/mxm-web-develop/DOCS_mydocs/blob/main/mxm-js-libs.md" > "$TARGET_DIR/front/README.md"
  fi
  echo "README 已更新。"

# 创建 nginx.conf 文件
cat > "$TARGET_DIR/front/nginx.conf" <<EOF
# Nginx 配置内容
server {
    listen       80;
    server_name  localhost;

    # MIME 类型
    include      /etc/nginx/mime.types;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    # 其他配置...
}
EOF

# 创建 Dockerfile
cat > "$TARGET_DIR/front/Dockerfile" <<EOF
FROM node:latest as build
WORKDIR /app
COPY ./front/package.json ./front/package-lock.json* ./
RUN npm install -g typescript  # 全局安装 TypeScript
RUN npm install  # 安装所有依赖项
COPY ./front .
RUN npm run build


# 使用 Nginx 镜像作为运行环境
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
# 将 Nginx 配置文件复制到 conf.d 目录
COPY ./front/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

echo "nginx.conf 和 Dockerfile 已创建在 $TARGET_DIR/front"


popd

echo "前端项目已初始化在 $TARGET_DIR/front"
