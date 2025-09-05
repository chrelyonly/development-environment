#!/bin/bash
# 一键创建 dmdba 用户并安装达梦数据库

# 1. 创建用户组和用户（如果不存在）
if ! id dmdba &>/dev/null; then
  echo ">>> 创建 dinstall 组和 dmdba 用户..."
  groupadd -g 2000 dinstall
  useradd -u 2000 -g dinstall dmdba
  echo "dmdba:dmdba" | chpasswd
else
  echo ">>> 用户 dmdba 已存在"
fi

# 2. 修改安装目录权限
INSTALL_DIR="/data/dm8_20250506_x86_rh7_64"
chown -R dmdba:dinstall "$INSTALL_DIR"

# 3. 切换用户并执行安装
su - dmdba -c "cd $INSTALL_DIR && ./DMInstall.bin -i"




#/home/dmdba/dmdbms/script/root/root_installer.sh

#cd /home/dmdba/dmdbms/bin
#./dminit path=/dmdata/data  SYSDBA_PWD=Admin12345678 SYSAUDITOR_PWD=Admin12345678
#/home/dmdba/dmdbms/bin/dmserver /dmdata/data/DAMENG/dm.ini
