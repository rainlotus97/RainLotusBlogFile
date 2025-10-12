#!/bin/bash

if [ -z "$1" ]; then
    echo "使用方法: $0 \"文章标题\""
    echo "示例: $0 \"我的技术笔记：使用C#开发\""
    exit 1
fi

# 创建文章
echo "正在创建文章: $1"
hexo new "$1"

# 查找最新创建的文件
# Hexo创建的文件通常有日期前缀，我们找最近修改的markdown文件
latest_post=$(find ./source/_posts -name "*.md" -type f -exec ls -t {} + | head -n1)

if [ -n "$latest_post" ] && [ -f "$latest_post" ]; then
    echo "找到文章文件: $latest_post"
    open -a Typora "$latest_post"
    echo "✅ 文章已在Typora中打开！"
else
    echo "❌ 无法找到创建的文章文件，请手动检查"
    echo "尝试在以下位置查找: ./source/_posts/"
fi