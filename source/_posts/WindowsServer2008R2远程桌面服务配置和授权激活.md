---
title: Windows Server 2008 R2远程桌面服务配置和授权激活
author: mechenik
top: false
cover: 'https://img.zcool.cn/community/0109965ca02190a8012141686db857.jpg'
mathjax: false
summary: 远程桌面服务安装好之后使用的是120天临时授权，所以会跳出以下提示，我们介绍远程桌面授权的激活。
categories: Windows
tags:
  - 系统
abbrlink: d6e6
date: 2021-07-09 09:25:00
img:
coverImg:
password:
---

远程桌面服务安装好之后使用的是120天临时授权，所以会跳出以下提示，我们介绍远程桌面授权的激活。

## 开始安装


![](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.1j74912g8rpc.png)

现在我们使用命令 mstsc /admin 强制登录服务器

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.1k8tves0mrz4.png)

需要在“远程桌面服务”--安装“远程桌面授权”--默认安装

“计算机”单击右键“管理”--“角色”

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.2butnsjwwbr4.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.5bgsi1ct53k0.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.6b5ufnnst6c0.png)

默认的都是 “下一步”

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.65mjyc0u4yg0.png)

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.4ddxhjkhu9u0.png)

正在安装

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.2f96mr9ra3r.png)

需要重启，才可以完成安装

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.54m8k85quec0.png)

## 二、 远程桌面授权激活

管理工具——远程桌面服务——(远程桌面授权管理)RD授权管理器；

![image](https://cdn.jsdelivr.net/gh/mechenik/imgpt1080@master/images/image.5y1wo1mst2k0.png)

由于我们的RD授权服务器还未激活，所以授权服务器图标右下角显示红色×号；

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