#!/bin/bash


#通过修改这个来实现启动脚本

#
sh -c tail -f /dev/null


#/home/dmdba/dmdbms/bin/dmserver /dmdata/data/DAMENG/dm.ini





#下面的环境需要安装
#set -e
#
## 判断 curl 是否已安装（已安装则跳过）
#if command -v curl >/dev/null 2>&1; then
#    echo "✅ 常用工具已安装，跳过安装步骤"
#else
#    echo "🔄 安装常用工具..."
#    apt-get update -y
#    apt-get install -y \
#        curl \
#        wget \
#        vim \
#        net-tools \
#        iputils-ping \
#        procps \
#        unzip \
#        tar \
#        less \
#        git
#    echo "✅ 安装完成"
#    # 使用 LinuxMirrors 脚本进一步设置
##    bash <(curl -sSL https://linuxmirrors.cn/main.sh) \
##      --source mirror.aliyun.com \
##      --protocol http \
##      --use-intranet-source false \
##      --install-epel true \
##      --backup true \
##      --upgrade-software false \
##      --clean-cache false \
##      --ignore-backup-tips
#fi
#
