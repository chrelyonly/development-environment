#!/bin/bash
# 一键创建 dmdba 用户并安装达梦数据库

set -e  # 遇到错误立即退出
set -u  # 使用未定义变量时报错

# 安装目录和数据目录
INSTALL_DIR="/data/dm8_20250506_x86_rh7_64"
DATA_DIR="/dmdata/data"
DMDBMS_DIR="/home/dmdba/dmdbms"

# 1. 创建用户组和用户（如果不存在）
if ! id dmdba &>/dev/null; then
  echo ">>> 创建 dinstall 组和 dmdba 用户..."
  groupadd -g 2000 dinstall
  useradd -u 2000 -g dinstall -m -s /bin/bash dmdba
  echo "dmdba:dmdba" | chpasswd
else
  echo ">>> 用户 dmdba 已存在"
fi

# 2. 创建文集目录（如果不存在）并赋权
if [ ! -d "$DMDBMS_DIR" ]; then
  echo ">>> 创建文集目录 $DMDBMS_DIR ..."
  mkdir -p "$DMDBMS_DIR"
  chown -R dmdba:dinstall "$DMDBMS_DIR"
  chmod -R 755 "$DMDBMS_DIR"
else
  echo ">>> 文集目录 $DMDBMS_DIR 已存在"
fi

# 3. 修改安装目录权限
echo ">>> 修改安装目录权限..."
chown -R dmdba:dinstall "$INSTALL_DIR"
chmod -R 755 "$INSTALL_DIR"

# 4. 切换用户执行达梦安装
echo ">>> 切换到 dmdba 用户执行达梦安装..."
su - dmdba -c "cd $INSTALL_DIR && ./DMInstall.bin -i"

# 5. 后续操作全部用 root 执行

# 执行 root 脚本（如果存在）
if [ -f "$DMDBMS_DIR/script/root/root_installer.sh" ]; then
  echo ">>> 执行 root 安装脚本..."
  bash "$DMDBMS_DIR/script/root/root_installer.sh"
fi

# 初始化数据库
echo ">>> 初始化数据库..."
"$DMDBMS_DIR/bin/dminit" path="$DATA_DIR" SYSDBA_PWD=Admin12345678 SYSAUDITOR_PWD=Admin12345678

# 启动达梦数据库服务
echo ">>> 启动达梦数据库服务..."
"$DMDBMS_DIR/bin/dmserver" "$DATA_DIR/DAMENG/dm.ini" &

echo ">>> 达梦数据库安装及启动完成！"
