---
title: Centos7 部署 Zabbix5.0
author: mechenik
top: false
cover: 'https://cdn.jsdelivr.net/npm/images-npm@1.0.0/blog/operation_1032_23.jpg'
mathjax: false
summary: zabbix是一个企业级解决方案，支持实时监控数千台服务器，虚拟机和网络设备采集百万级监控指标。
categories: 运维手册
tags:
  - Linux
  - Zabbix
abbrlink:
date: 2021-11-09 09:25:00
img:
coverImg:
password:
---

zabbix是一个企业级解决方案，支持实时监控数千台服务器，虚拟机和网络设备采集百万级监控指标。

## Zabbix的主要特点

1.指标收集:从任何设备、系统、应用程序上进行指标采集；

2.问题监测:定位智能阀值；

3.可视化:单一界面管理平台；

4.告警和修复:确保及时，有效的告警

5.安全和认证：保护您所有层级的数据

6.轻松搭建部署：大批模板、开箱即用、节省您宝贵的时间

7.自动发现：自动监控大型动态环境

8.分布式监控：无限制扩展

## 部署实践

### 1.关闭防火墙和selinux

```
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

```

运行以下命令关闭防火墙

```
systemctl disable --now firewalld
```

重启生效

```
reboot
```

### 2 .安装zabbix rpm源

运行以下命令安装zabbix rpm源

```
rpm -Uvh https://mirrors.aliyun.com/zabbix/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm

sed -i 's#http://repo.zabbix.com#https://mirrors.aliyun.com/zabbix#' /etc/yum.repos.d/zabbix.repo

yum clean all
```

### 3 .安装zabbix server和agent

运行以下命令安装zabbix server和agent
```
yum install zabbix-server-mysql zabbix-agent -y
```
### 4 .安装zabbix前端

运行以下命令 安装Software Collections
```
yum install centos-release-scl -y
```
运行以下命令， 将[zabbix-frontend]下的 enabled 改为 1
```
vi /etc/yum.repos.d/zabbix.repo
```
:wq 保存

运行以下命令安装zabbix 前端和相关环境
```
yum install zabbix-web-mysql-scl zabbix-apache-conf-scl -y
```
### 5 .安装mariadb数据库

运行以下命令安装数据库
```
yum install mariadb-server -y
```
运行以下命令启动数据库并配置开机启动
```
systemctl enable --now mariadb
```
运行以下命令初始化数据库
```
mysql_secure_installation
```
### 6 .zabbix数据库配置

运行以下命令创建zabbix数据库及数据库用户
```
mysql -u root -p （输入数据库root密码进入数据库）
```
运行以下命令创建zabbix数据库
```
create database zabbix default character set utf8 COLLATE utf8_ bin ;
```
运行以下命令创建zabbix数据库用户
```
grant all privileges on zabbix.* to zabbix@localhost identified by " zabbix_pwd " ;
quit 退出
```
运行以下命令导入zabbix数据库
```
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
```
### 7 .zabbix配置及前端页面安装

运行以下命令修改zabbix server配置文件里的数据库信息
```
vi /etc/zabbix/zabbix_server.conf
找到 DBPassword=password ，将数据库密码改为zabbix数据库的密码
:wq 保存
```

运行以下命令修改zabbix php配置文件里的时区
```
vi /etc/opt/rh/rh-php72/php-fpm.d/zabbix.conf
```
找到php_value[date.timezone]，去掉注释及前面的标点符号，改成
php_value[date.timezone] = Asia/Shanghai

:wq 保存
```

运行以下命令启动相关服务并配置开机自动启动
```
systemctl restart zabbix-server zabbix-agent httpd rh-php72-php-fpm
systemctl enable zabbix-server zabbix-agent httpd rh-php72-php-fpm
```
使用浏览器访问zabbix web页面继续安装
