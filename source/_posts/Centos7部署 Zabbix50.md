---
title: Centos7 部署 Zabbix5.0
author: mechenik
top: false
cover: 'https://img.zcool.cn/community/0109965ca02190a8012141686db857.jpg'
mathjax: false
summary: zabbix是一个企业级解决方案，支持实时监控数千台服务器，虚拟机和网络设备采集百万级监控指标。
categories: Windows
tags:
  - 系统
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


![](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.1j74912g8rpc.png)


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


右击授权服务器——激活服务器

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.5zat1wpp43w0.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.6nrdcbjqy6g0.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.1wucs2nyty8w.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.1hhocsn4hups.png)

输入注册信息（必填选项），下一步

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.137zmti5zzsg.png)

可选信息无需输入，直接下一步

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.2fy82zm34olc.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.4t5rsntqpgu0.png)

默认已经勾选“立即启动许可证安装向导”，直接下一步

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.6yb8t6vgy3k0.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.6zoa2nah5z40.png)

许可证计划选择“企业协议”，下一步

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.1k4sjfdmrm3k.png)

输入协议号码：```6565792```，下一步

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.29d4fobudce8.png)

产品版本：“Windows Server 2008或Windows Server 2008 R2”

许可证类型：“TS或RDS每用户CAL”

数量：输入你想允许的最大远程连接数量

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.5k3jl57ac8k0.png)

点击完成

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.3q5h84bm2p60.png)

RD授权服务器已经激活，图标也由红×变为绿√，到这里远程桌面服务的配置和激活全部完成

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.2ku2xacfpk80.png)

还需要修改  “远程桌面授权服务器”，需要指定，“添加”

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.423yo71t5iu0.png)

添加===每用户

至此安装完成，敬请使用。
