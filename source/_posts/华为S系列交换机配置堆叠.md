---
title: 华为S系列交换机配置堆叠
author: mechenik
top: false
cover: 'https://pic.imgdb.cn/item/625639cd239250f7c5aade33.png'
mathjax: false
summary: 根下面是对交换机业务口堆叠方法的案例，必须按照步骤一步一步来,首先规划好硬件连接方案，把软件配置好重启之后，再进行硬件连接。
categories: 运维手册
tags:
  - 交换机
  - 华为
abbrlink:
date: 2022-04-09 09:25:00
img:
coverImg:
password:
---

根下面是对交换机业务口堆叠方法的案例，必须按照步骤一步一步来,首先规划好硬件连接方案，把软件配置好重启之后，再进行硬件连接。

## 准备工作

1.两台华为 S5720-52P-EI-AC 交换机通过业务口（光口 gi 0/0/49 to gi 0/0/52）；

2.两条光纤线，四个多模（MM）光模块；


## 交换机配置

### 0号交换机（Master）



    interface stack-port 0/1
    port interface GigabitEthernet 0/0/49 to interface GigabitEthernet 0/0/50 enable


创建并进入0号交换机的1号逻辑堆叠端口讲49和50这两个物理端口加入到1号逻辑堆叠端口中

然后保存重启


### 1号交换机

    stack slot 0 renumber 1

将设备的堆叠ID由0改为1（默认是0，堆叠ID对堆叠优先级无影响）

然后保存重启

    interface stack-port 1/2
    port interface GigabitEthernet 0/0/51 to interface GigabitEthernet 0/0/52 enable
    stack slot 1 priority 50

然后保存重启

## 堆叠连线

![](https://pic.imgdb.cn/item/625772bf239250f7c53f48c7.jpg)

## 查看堆叠状态

1.执行命令`display device`查看堆叠系统中各成员交换机的个数与实际组网中交换机的个数是否一致

2.执行`display stack`命令，查看堆叠系统的连接拓扑



3.执行`display stack peers`命令，查看堆叠系统的邻居信息



4.执行`display stack port`命令，查看与逻辑堆叠端口绑定的物理成员端口的信息



5.执行`display stack channel all`命令，查看堆叠链路的连线及状态信息


## 如何拆分堆叠

1.执行命令save，保存配置。

2.执行命令`copy source-filename destination-filename all`，备份配置文件到所有成员交换机，以备再次组建堆叠时使用。



3.拆除成员交换机之间的堆叠线缆。拆除堆叠线缆后，堆叠系统分裂，会导致部分成员交换机重启。由于堆叠成员交换机IP地址等部分配置相同，远程登录可能不成功，因此请通过Console口登录交换机进行后续配置。



4.执行命令`system-view`，进入系统视图。



5.执行命令`reset stack configuration`，清除堆叠的相关配置。



6.清除的堆叠配置包括：交换机槽位号、堆叠优先级、堆叠保留VLAN、系统MAC切换时间、堆叠口配置、堆叠口速率配置。执行该命令会导致设备重启。

最后将成员交换机下电。