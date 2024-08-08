#!/bin/bash

NEW_REPO_URL="https://mechenik.eu.org/link/CentOS-tencent-centos-vault.repo"
ORIGINAL_REPO_PATH="/etc/yum.repos.d/CentOS-Base.repo"

if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root用户身份运行" 1>&2
   exit 1
fi

echo "正在备份原有的 CentOS-Base.repo 文件..."
cp $ORIGINAL_REPO_PATH "${ORIGINAL_REPO_PATH}.bak"

echo "正在下载新的 CentOS-tencent-centos-vault.repo 文件..."
curl -o $ORIGINAL_REPO_PATH $NEW_REPO_URL

echo "清除yum缓存并重新生成..."
yum clean all
yum makecache
echo "已成功替换为 CentOS Vault 仓库源。"

