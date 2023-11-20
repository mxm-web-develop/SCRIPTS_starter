#!/bin/bash

# 获取脚本所在的当前目录
TARGET_DIR="$(dirname "$(realpath "$0")")"

# 创建 docker-compose.yml 文件
cat > "$TARGET_DIR/docker-compose.yml" <<EOF
version: '3'
services:
  front:
    build:
      context: .  # 指定构建上下文为当前目录 (MYPROJECT)
      dockerfile: front/Dockerfile  # Dockerfile 位于 frontend 子目录中
    ports:
      - "80:80"
    # volumes:
    #   - ./front:/usr/share/nginx/html
  back:
    build: ./back
    ports:
      - "8080:8000"
    volumes:
      - ./back/app:/usr/src/app/app
    environment:
      - PYTHONUNBUFFERED=1
      - HOST=0.0.0.0
      - PORT=8000
    depends_on:
      - mongodb
      - postgresql

  mongodb:
    image: mongo
    volumes:
      - mongo-data:/data/db
    environment:
      - MONGO_INITDB_ROOT_USERNAME=root
      - MONGO_INITDB_ROOT_PASSWORD=12345
    ports:
      - "27017:27017"
      
  mongo-express:
    image: mongo-express
    ports:
      - "8081:8081"
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=mongoadmin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=secret
      - ME_CONFIG_MONGODB_SERVER=mongodb
    depends_on:
      - mongodb

  postgresql:
    image: postgres
    volumes:
      - postgres-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=mydb
      - POSTGRES_USER=root
      - POSTGRES_PASSWORD=12345
    ports:
      - "5432:5432"

  pgadmin:
    image: dpage/pgadmin4
    ports:
      - "5050:80"
    environment:
      - PGADMIN_DEFAULT_EMAIL=user@example.com
      - PGADMIN_DEFAULT_PASSWORD=secret
    depends_on:
      - postgresql
volumes:
  mongo-data:
  postgres-data:
EOF

echo "Docker配置已创建在 $TARGET_DIR/docker-compose.yml"
