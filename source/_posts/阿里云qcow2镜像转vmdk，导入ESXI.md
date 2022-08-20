---
title: 阿里云qcow2镜像转vmdk，导入ESXi
author: mechenik
top: false
cover: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdev-tang.com%2Fpost%2F2020%2F03%2Fimgs%2Fvmdk%2F01.png&refer=http%3A%2F%2Fdev-tang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663565612&t=1bbc5fc3aaf57685a454edca67bb6052'
mathjax: false
summary: 阿里云的ecs服务器打包镜像后是qcow2格式，如果要将镜像导入到VMware Workstation Pro或者VMware ESXi，就需要将qcow2格式转成vmdk格式才可以。
categories: 运维手册
tags:
  - 虚拟化
  - ESXI
abbrlink:
date: 2022-08-09 09:25:00
img:
coverImg:
password:
---

阿里云的ecs服务器打包镜像后是qcow2格式，如果要将镜像导入到VMware Workstation Pro或者VMware ESXi，就需要将qcow2格式转成vmdk格式才可以。

在此以ESXi 6.7导入为例来演示整个过程。

## 1、工具准备

前置条件，你已将qcow2镜像下载的本地，且安装好了qemu工具。

如果没有qemu，可以从这里下载安装：https://qemu.weilnetz.de/w64/

安装好qemu后，环境变量也是需要配置的，在path里面将路径指向qemu安装后目录就可以了。

## 2、开始转换

笔者的qcow2镜像文件是aliyun-ecs.qcow2。现在用下面命令将镜像转成vmdk格式：

	qemu-img convert -f qcow2 -O vmdk aliyun-ecs.qcow2 aliyun-ecs.vmdk

转换时间会很长，需要耐心等待。转换成功后发现生成了aliyun-ecs.vmdk文件。

## 3、上传镜像

接下来，需要将aliyun-ecs.vmdk文件上传到ESXi的存储中。笔者在datastore1的存储中，创建了一个目录aliyun-ecs-vmdk，然后将aliyun-ecs.vmdk 文件上传到这个目录中。如图3-1所示。

图3-1 
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/106878/14/30782/61878/63006fc0E0cf5b771/9b6e96f849499881.png)

这个时候的vmdk还不能直接使用，还需要转成磁盘管理工具vmkfstools，将qemu-img转换的vmdk文件再转成ESXi所能识别的vmdk。

## 4、二次转换

我们需要通过shell连接ESXi，然后进入到datastore1存储中，进行转换。如果你没有开启ssh功能，在web管理系统中的：主机->管理->服务中依次开启TMS、TMS-SSH就可以，如图4-1所示。

图4-1 
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/41388/40/18096/84341/63007008E97d5cbbb/1eb5877adcbcd763.png)

如果已经开启过了，那么通过xshell或者其他ssh工具连接到ESXi的服务上，使用命令进入到之前上传的vmdk文件所在的存储位置：

	cd /vmfs/volumes/datastore1/aliyun-ecs-vmdk

笔者的存储位置在/vmfs/volumes/datastore1/aliyun-ecs-vmdk，各位读者需要根据自己的实际情况进行修改。

然后使用下面这条命令，将vmdk转成ESXi可以识别的vmdk。

	vmkfstools -i aliyun-ecs.vmdk -d thin out-aliyun-ecs.vmdk 

转换成功后，会发现生成了两个文件：out-aliyun-ecs.vmdk和out-aliyun-ecs-flat.vmdk

## 5、开始导入

最后创建新的虚拟机，并把硬盘指向out-aliyun-ecs.vmdk文件就可以了。

### 5.1、创建新虚拟机
开始创建一个新的虚拟机，如图5-1-1所示。

图5-1-1
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/54902/38/21578/41288/6300707eEe8bba461/4b43968448b950d4.png)

### 5.2、选择名称和客户机操作系统

如图5-2-1所示，填写好名称和选择好原来镜像对应的操作系统。

图5-2-1
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/39135/37/18296/51793/630070abEbebc0c28/156a5af071b195c9.png)

### 5.3、选择存储

如图5-3-1所示，这里一般默认，直接点击下一步就可以了。除非你有多个存储。

图5-3-1
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/176116/8/29279/40453/630070d2Ef7a9b613/35ee1ac570ba4f09.png)

### 5.4、自定义设置，最重要的一步操作，完成导入

先删除默认的硬盘，如图5-4-1所示。再添加一个新的已存在的现有硬盘，如图5-4-2所示。然后选择你在第4步二次转换好的vmdk文件，如图5-4-3所示，千万别选错了哦。然后点击选择按钮，回到自定义界面，如图5-4-4所示，继续点击下一步操作，进入到图5-4-5所示界面，点击完成按钮。再回到ESXi的主界面，就可以看到镜像已导入成功，如图5-4-6所示。点击启动虚拟机，用以前的用户密码进入就可以了。

图5-4-1
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/125246/38/25351/54259/63007106Ec2843ee1/b4b7e1f9a5a5b068.png)

图5-4-2
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/103566/29/32007/54388/63007122E82246703/8d0c8ffb76b1bb11.png)

图5-4-3
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/68936/33/22008/41003/6300713dE615a6b8b/a3b42fcd09c44688.png)

图5-4-4
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/187373/29/27964/55530/63007153Ebfce8d7d/81c4fa2ce71ff313.png)

图5-4-5
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/36747/27/17303/60217/63007169Eb17ffdeb/04a9d817c1c6ea51.png)

图5-4-6
![image.png](https://dd-static.jd.com/ddimg/jfs/t1/65513/23/21327/108756/6300717eE8012861d/4c855221a6fa29b4.png)

## 6、总结
有两个地方需要注意：第一个就是第4个步骤的二次转换操作；另一个就是第5.4步骤的自定义添加现有硬盘操作。
