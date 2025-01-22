#!/bin/bash

# 通过命令行参数传递 project_path、new_package_name 和 new_app_name
project_path="$1"
new_package_name="$2"
new_app_name="$3"

# 检查参数是否提供
if [ -z "$project_path" ] || [ -z "$new_package_name" ] || [ -z "$new_app_name" ]; then
    echo "Usage: $0 <project_path> <new_package_name> <new_app_name>"
    exit 1
fi

# 修改 AndroidManifest.xml 文件中的 application label
manifest_path="$project_path/app/src/main/AndroidManifest.xml"
sed -i "" "s|android:label=\"[^\"]*\"|android:label=\"$new_app_name\"|" $manifest_path

# 修改 build.gradle 文件中的 applicationId
gradle_path="$project_path/app/build.gradle"
sed -i "" "s|applicationId \".*\"|applicationId \"$new_package_name\"|" $gradle_path
