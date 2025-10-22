---
title: 网格益智游戏开发:1.配置VSCode与Godot
date: 2025-10-22 21:45:43
tags: 
  - C#
  - Godot
  - VSCode
categories: Godot
cover:
description: 在Mac下配置VSCode与Godot
---

# 准备工作

在[VSCode官网](https://code.visualstudio.com/docs/?dv=osx)及[Godot官网](https://godotengine.org/download/macos/)下载对应的编辑器，其中Godot mono版本支持C#语言，需要额外下载[.net环境](https://dotnet.microsoft.com/zh-cn/download)

## 设置VSCode为Godot的外部编辑器

![image-20251022215137753](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022215137753-47afaa.png)

## 设置文档为C#类型

![image-20251022220926881](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022220926881-8a23f4.png)

![image-20251022221119231](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022221119231-f6b750.png)

Mac中通过option和space空格键组合，即可快速打开文档查询

## 设置场景和脚本命名格式

![image-20251022221546165](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022221546165-c4c0a8.png)

## 安装VSCode插件

![image-20251022221805702](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022221805702-c47434.png)

## 设置VSCode调试

- 使用command + p 打开命令输入Godot选择下图所示，即可对当前项目创建调试任务文件。

![image-20251022222118633](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022222118633-e35784.png)

- 修改launch.json

![image-20251022222537188](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022222537188-a629e8.png)

其中mac的Godot目录通常为：/Applications/Godot_mono.app/Contents/MacOS/Godot

下方为点击Launch后运行实录：

![image-20251022222940335](https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-22/image-20251022222940335-e04638.png)
