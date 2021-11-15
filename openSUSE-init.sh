#!/bin/sh

# openSUSE Tumbleweed

# 禁用官方源
sudo zypper mr -da

# 添加 TUNA 镜像源
# 开源软件
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/oss/' tuna-oss
# 非开源软件
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/non-oss/' tuna-non-oss

# See https://zh.opensuse.org/%E8%A7%A3%E7%A0%81%E5%99%A8
# 通过 Packman 安装解码器
sudo zypper ar -cfp 90 https://mirrors.ustc.edu.cn/packman/suse/openSUSE_Tumbleweed packman

# See https://en.opensuse.org/Visual_Studio_Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper ar https://packages.microsoft.com/yumrepos/vscode vscode

# 刷新软件源
sudo zypper refresh

# 发行版升级
sudo zypper dist-upgrade --from packman --allow-vendor-change
sudo zypper dup

# 常用软件
# 使用zypper
sudo zypper install \
	zsh \
	wget \
	code \
	ripgrep \
	jq \
	proxychains-ng

# 其他方式
# clash
# see https://github.com/Dreamacro/clash/releases