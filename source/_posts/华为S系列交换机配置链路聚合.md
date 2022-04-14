---
title: 华为S系列交换机配置手工模式链路聚合示例（交换机之间直连）
author: mechenik
top: false
cover: 'https://download.huawei.com/mdl/image/download?uuid=ab78fd99b67741478d664a42d437cde6'
mathjax: false
summary: 用户希望SwitchA和SwitchB之间能够提供较大的链路带宽来使相同VLAN间互相通信。同时用户也希望能够提供一定的冗余度，保证数据传输和链路的可靠性。
categories: 运维手册
tags:
  - 交换机
  - 华为
abbrlink:
date: 2022-04-09 11:25:00
img:
coverImg:
password:
---

用户希望SwitchA和SwitchB之间能够提供较大的链路带宽来使相同VLAN间互相通信。同时用户也希望能够提供一定的冗余度，保证数据传输和链路的可靠性。

## 准备工作

1.两台华为 S5720-52P-EI-AC 交换机通过业务口（光口 gi 0/0/49 to gi 0/0/52）；

2.两条光纤线，四个多模（MM）光模块；


## 交换机配置


### 在SwitchA和SwitchB上创建Eth-Trunk接口并加入成员接口。

SwitchA
    
    [HUAWEI] sysname SwitchA
    [SwitchA] interface eth-trunk 1
    [SwitchA-Eth-Trunk1] trunkport gigabitethernet 0/0/1 to 0/0/3
    [SwitchA-Eth-Trunk1] quit
SwitchB

    <HUAWEI> system-view
    [HUAWEI] sysname SwitchB
    [SwitchB] interface eth-trunk 1
    [SwitchB-Eth-Trunk1] trunkport gigabitethernet 0/0/1 to 0/0/3
    [SwitchB-Eth-Trunk1] quit

### 创建VLAN并将接口加入VLAN。

创建VLAN10和VLAN20并分别加入接口。SwitchB的配置与SwitchA类似，不再赘述。

SwitchA

    [SwitchA] vlan batch 10 20
    [SwitchA] interface gigabitethernet 0/0/4
    [SwitchA-GigabitEthernet0/0/4] port link-type trunk
    [SwitchA-GigabitEthernet0/0/4] port trunk allow-pass vlan 10
    [SwitchA-GigabitEthernet0/0/4] quit
    [SwitchA] interface gigabitethernet 0/0/5
    [SwitchA-GigabitEthernet0/0/5] port link-type trunk
    [SwitchA-GigabitEthernet0/0/5] port trunk allow-pass vlan 20
    [SwitchA-GigabitEthernet0/0/5] quit
SwitchB

    [SwitchB] vlan batch 10 20
    [SwitchB] interface gigabitethernet 0/0/4
    [SwitchB-GigabitEthernet0/0/4] port link-type trunk
    [SwitchB-GigabitEthernet0/0/4] port trunk allow-pass vlan 10
    [SwitchB-GigabitEthernet0/0/4] quit
    [SwitchB] interface gigabitethernet 0/0/5
    [SwitchB-GigabitEthernet0/0/5] port link-type trunk
    [SwitchB-GigabitEthernet0/0/5] port trunk allow-pass vlan 20
    [SwitchB-GigabitEthernet0/0/5] quit

配置Eth-Trunk1接口允许VLAN10和VLAN20通过。SwitchB的配置与SwitchA类似，不再赘述。

SwitchA

    [SwitchA] interface eth-trunk 1
    [SwitchA-Eth-Trunk1] port link-type trunk
    [SwitchA-Eth-Trunk1] port trunk allow-pass vlan 10 20
    [SwitchA-Eth-Trunk1] quit

SwitchB

    [SwitchB] interface eth-trunk 1
    [SwitchB-Eth-Trunk1] port link-type trunk
    [SwitchB-Eth-Trunk1] port trunk allow-pass vlan 10 20
    [SwitchB-Eth-Trunk1] quit

### 配置Eth-Trunk1的负载分担方式

SwitchA

    [SwitchA] interface eth-trunk 1
    [SwitchA-Eth-Trunk1] load-balance src-dst-mac
    [SwitchA-Eth-Trunk1] quit

SwitchB

    [SwitchB] interface eth-trunk 1
    [SwitchB-Eth-Trunk1] load-balance src-dst-mac
    [SwitchB-Eth-Trunk1] quit


### 验证配置结果

在任意视图下执行display eth-trunk 1命令，检查Eth-Trunk是否创建成功，及成员接口是否正确加入。

    
    [SwitchA] display eth-trunk 1
    Eth-Trunk1's state information is: 
    WorkingMode: NORMAL   Hash arithmetic: According to SA-XOR-DA
    Least Active-linknumber: 1 Max Bandwidth-affected-linknumber: 8
    Operate status: up Number Of Up Port In Trunk: 3 
    --------------------------------------------------------------------------------
    PortName   Status   Weight
    GigabitEthernet0/0/1   Up   1
    GigabitEthernet0/0/2   Up   1
    GigabitEthernet0/0/3   Up   1

从以上信息看出Eth-Trunk 1中包含3个成员接口GigabitEthernet0/0/1、GigabitEthernet0/0/2和GigabitEthernet0/0/3，成员接口的状态都为Up。Eth-Trunk 1的“Operate status”为Up。
