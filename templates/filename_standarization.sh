#!/bin/bash

# 检查是否提供了目录作为参数
if [ -z "$1" ]; then
    echo "请提供要重命名的目录作为参数。"
    exit 1
fi

# 遍历目录中的所有文件
for file in "$1"/*; do
    if [ -f "$file" ]; then
        # 获取文件的创建日期和时间
        created_date=$(stat -f "%SB" -t "%Y%m%d" "$file")
        created_time=$(stat -f "%SB" -t "%H%M%S" "$file")

        # 获取文件大小
        file_size=$(stat -f "%z" "$file")

        # 获取文件扩展名
        extension="${file##*.}"

        # 构建新的文件名
        new_name="${created_date}_${created_time}_${file_size}.${extension}"

        # 使用mv命令重命名文件
        mv "$file" "$1/$new_name"

        echo "文件已重命名为：$new_name"
    fi
done