---
title: Docker容器间的通信
date: 2025-09-10 20:55:17
tags:
  - Docker
categories: Linux
cover:
description: mysql是由Docker容器生成，后续产生新的服务想要使用往往连接不上，这时就可以使用自定义网络来搭建容器的通信桥梁。
---

# Docker容器间通信

1. 创建自定义网络 (如果尚未创建) 默认的bridge网络虽然方便，但有时为了更好的隔离和管理，建议使用自定义网络。
   ```bash
   docker network create my-app-network
   ```
2. 将容器连接到自定义网络 将你的MySQL容器和应用容器都连接到这个新创建的网络。
   ```bash
   docker network connect my-app-network your-mysql-container
   docker network connect my-app-network your-app-container
   ```
   如果容器尚未运行，可以在运行时就指定网络：
   ```bash
   # 运行MySQL容器并加入自定义网络
   docker run -d --name your-mysql-container --network my-app-network -e MYSQL_ROOT_PASSWORD=your_password mysql:tag
   
   # 运行应用容器并加入同一自定义网络
   docker run -d --name your-app-container --network my-app-network your-app-image
   ```
3. 验证网络连接 进入应用容器，尝试ping MySQL容器的主机名（Docker内置的DNS服务可以解析容器名）。
   ```bash
   docker exec -it your-app-container /bin/sh
   ping your-mysql-container # 或使用你MySQL容实际名称
   ```
   如果ping不通，检查容器是否都在同一网络：docker network inspect my-app-network。
