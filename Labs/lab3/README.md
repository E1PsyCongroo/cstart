<<<<<<< HEAD
# Lab3_1 C语言基本语法
- 完成lab3_1中的四个.c文件
  - 请根据每个ex_中的TODO完成内容。

# Lab3_2 字符串和循环
- 本实验使用了参数char *argv[]，请在使用gcc编译后尝试输入参数如:
  ```
  gcc str_and_cyc.c -o str_and_cyc
  ./str_and_cyc California Oregon Washington Texas 
  ```
  会看到如下所示
  ```
  for:
  arg 1: California
  arg 2: Oregon
  arg 3: Washington
  arg 4: Texas

  state 0: California
  state 1: Oregon
  state 2: Washington
  state 3: Texas
  
  while:
  arg 0: ./str_and_cyc
  arg 1: California
  arg 2: Oregon
  arg 3: Washington
  arg 4: Texas

  state 0: California
  state 1: Oregon
  state 2: Washington
  state 3: Texas
  ```
- 请对srt_and_cyc.c文件中的for和while循环尝试以下操作并查看结果。
- for循环
  - 将i初始化为0看看会发生什么。是否也需要改动argc，不改动的话它能正常工作吗？为什么下标从0开始可以正常工作？
  - 将num_states改为错误的值使它变大，来看看会发生什么。
  - 查询NULL是什么东西，尝试将它用做states的一个元素，看看它会打印出什么。
  - 看看你是否能在打印之前将states的一个元素赋值给argv中的元素，再试试相反的操作。
- while循环
  - 使用while循环将argv中的值复制到states。
  - 让这个复制循环不会执行失败，即使argv之中有很多元素也不会全部放进states。
  - 研究你是否真正复制了这些字符串。答案可能会让你感到意外和困惑。


# 可选 递归
=======
# lab2:体验嵌入式

part1基础配置的相关配置我已经写好了插件,不过还是建议一步一步配置下去,这样才能快速了解环境,下次换台电脑也能很快的配置好环境
>>>>>>> upstream/dev

> 安装文件放在./install文件夹中

当然,假如你是在配到头大,那还是退回到上一个`快照`,然后在
bash中输入
```bash
./install/install.sh
```
一键安装,编译,和烧录
在烧录之前记得检查一下串口设备有没有接入
```bash
ls /dev/ttyUSB*
```
假如出现
```bash
mayge@mayge:~/Desktop/WorkSpace/lab2/install $ls /dev/ttyUSB*
ls: 无法访问 '/dev/ttyUSB*': 没有那个文件或目录
```
那检查一下在哪一部出现了问题,可以仔细阅读**Part1 基础配置**

假如出现
```bash
mayge@mayge:~/Desktop/WorkSpace/lab2/install $ls /dev/ttyUSB*
/dev/ttyUSB0
```
干的漂亮
假如是一键安装的话,成功之后还是尝试一下自己配置哦.

## Part1 基础配置
**所需材料**:一块stc89c52rc芯片,一个USB-TO-TTL(CH340),4根公对母杜邦线,2根跳线,2个10uF的电容,2个33pF的电容,1个10kΩ的电阻,1个4.7kΩ的电阻,以及一个1kΩ的电阻,最后再来一个发光二极管.

> 或者直接用虚拟的板子吧(Part4配置虚拟51)

![Core](./Image/Core.png)
![Bread](./Image/Bread.jpg)

试试看按照电路图进行连线吧,LED正极接在VCC,负极接在P2_0,别忘了串联上电阻哦(这里两个电阻并联意思是100Ω和1kΩ都可以)

### 配置sdcc
在ubuntu上搭建51单片机的开发环境,会被windows稍微麻烦一些,但是只要坚持下去,把环境配好,你在linux能学到一些不一样的知识.

配置sdcc会遇到很多小小的问题,让我们来一一解决

1. 进行解压
    ```bash
    mkdir ~/tmp
    tar -xvjf sdcc-src-4.4.0.tar.bz2 -C ~/tmp
    cd ~/tmp/sdcc-4.4.0
    ```

2. 运行./configure
    ```bash
    ./configure
    ```
    期间也许你会遇到各种各样的问题,不过没关系,借助强大的搜索软件和gpt,聪明的你一定会想出合理的解决方法,配置环境本身也是锻炼自身能力的一部分.

    这里就简单列出一些常见问题吧,有问题可以谷歌,实在不行还可以带上你的日志,问一下你的牛马学长哦.
    ```bash
    #一般来说,问题都会出现在输出内容的最后
    #就比如说
    configure:error: Cannot find required program bison
    #这段报错指的是你可能没有安装bison这个库,简单装一下就行
    sudo apt update
    sudo apt install bison
    ####################################
    #或者是这段报错
    configure: error: boost library not found (boost/graph/adjacency_list.hpp).
    #你只需要输入
    sudo apt install libboost-all-dev
    ####################################
    #或者说是这个
    configure:error: Cannot find required program flex
    #你只需要输入
    configure:error: Cannot find required program bison
    #Sorry,黏贴错了,应该是这个
    sudo apt install flex
    ####################################
    #我碰到的唯一比较难办的就是这段报错
    failedfor device/lib/pic14
    #解决方法也很简单把输入的指令做一下更改就行
    ./configure --disable-pic14-port--disable-pic16-port
    #反正只要报错,问gpt,问google都没问题
    ```

3. 当处理完configure的报错之后,就可以进行下一步的操作了
    ```bash
    sudo make install
    ```
    这里吐嘈一下,这个安装是真的好慢

4. 最后,在验证一下安装是否成功
    ```bash
    sdcc --version
    ```
    假如你输出的是这样的界面
    ```bash
    sdcc --version
    SDCC : mcs51/z80/z180/r2k/r2ka/r3ka/sm83/tlcs90/ez80_z80/z80n/r800/ds390/TININative/ds400/hc08/s08/stm8/pdk13/pdk14/pdk15/mos6502/mos65c02 TD- 4.4.0 #14620 (Linux)
    published under GNU General Public License (GPL)
    ```
    good job(吐嘈fcitx打不出gou xi这两个字,服了)

5. 尝试编译
先尝试随便建一个工程,就比如说main.c
    ```c
    #include <8052.h>

    void delay100ms()		//@11.0592MHz
    {
        unsigned char i, j;

        i = 180;
        j = 73;
        do
        {
            while (--j);
        } while (--i);
    }

    void main()
    {
        while(1)
        {
            P2_0 = !P2_0;
            delay100ms();
        }
    }
    ```
    编写完成后,`Ctrl+Alt+T`召唤神龙,再cd到main.c的目录,输入
    ```bash
    sdcc -mmcs51 main.c
    ```
    这个时候跳出了一大堆文件
    ```bash
    mayge@mayge:~/Desktop/tmp $ls
    main.asm  main.ihx  main.lst  main.mem  main.rst
    main.c    main.lk   main.map  main.rel  main.sym
    ```
    接下了,我们需要使用的就是main.ihx文件

### 配置stcgal
在上一节,我们获得了需要烧录的文件`main.ihx`,那我们怎么将其转移到我们的单片机中呢,我们就需要配置烧录工具,最简单的就是stcgal,不过它只能烧录stc系列的一些单片机,对于stm32这类单片机,就需要另外的解决方法了.
1. 打开终端输入
    ```bash
    pip3 install stcgal
    ```
2. 验证安装
    ```bash
    stcgal -h
    ```

3. 然而在我们检查串口设备的时候,却出现了一些意外
    ```bash
    mayge@mayge:~/Desktop ls /dev/ttyUSB*

    ls: 无法访问 '/dev/ttyUSB*': 没有那个文件或目录
    ```
    这就奇怪了,明明我们已经接上了我们的串口驱动程序,可是为什么仍然检测不到呢?
    ```bash
    mayge@mayge:~/Desktop/tmp $sudo dmesg | grep -i ch34

    [ 3109.998639] usbcore: registered new interface driver ch341
    [ 3109.998653] usbserial: USB Serial support registered for ch341-uart
    [ 3109.998663] ch341 1-2.1:1.0: ch341-uart converter detected
    [ 3110.010320] usb 1-2.1: ch341-uart converter now attached to ttyUSB0
    [ 3110.591802] usb 1-2.1: usbfs: interface 0 claimed by ch341 while 'brltty' sets config #1
    [ 3110.595796] ch341-uart ttyUSB0: ch341-uart converter now disconnected from ttyUSB0
    [ 3110.595811] ch341 1-2.1:1.0: device disconnected
    [ 3658.565668] ch341 1-2.1:1.0: ch341-uart converter detected
    [ 3658.575821] usb 1-2.1: ch341-uart converter now attached to ttyUSB0
    [ 3659.520808] usb 1-2.1: usbfs: interface 0 claimed by ch341 while 'brltty' sets config #1
    [ 3659.523783] ch341-uart ttyUSB0: ch341-uart converter now disconnected from ttyUSB0
    [ 3659.523826] ch341 1-2.1:1.0: device disconnected
    ```
    重新连接并查询ttyUSB0的历史连接状态,我们发现在接入的一瞬间USB0设备是成功连接上的,只是后来`brltty`这个服务打断了我们的连接.

    查询到`brltty`这个服务是用来控制**盲文显示器**的,我又不瞎,直接送它进小黑屋
    ```bash
    #停止 brltty 服务
    sudo systemctl stop brltty
    #禁用 brltty 服务
    sudo systemctl disable brltty
    #这里重新插入CH340设备
    sudo dmesg | grep -i ch34
    ```

    ```bash
    mayge@mayge:~/Desktop/tmp $ls /dev/ttyUSB*
    /dev/ttyUSB0
    ```
    这就非常成功了

4. 接下来我们进行烧写
    ```bash
    mayge@mayge:~/Desktop/tmp $stcgal -p /dev/ttyUSB0 -b 115200 main.ihx
    ```
    不过很遗憾,又报错了
    ```bash
    Serial port error: [Errno 13] could not open port /dev/ttyUSB0: [Errno 13] Permission denied: '/dev/ttyUSB0'
    ```
    但这次的报错处理起来还是很简单的,只需要给ttyUSB0赋一个较低的权限,我们的串口程序就能对其进行访问了
    ```bash
    sudo chmod 666 /dev/ttyUSB0
    ```
    再次输入烧写指令,插拔Vcc引脚,就能开始烧录了

    ```bash
    mayge@mayge:~/Desktop/tmp $stcgal -p /dev/ttyUSB0 -b 115200 main.ihx

    Waiting for MCU, please cycle power: done
    Protocol detected: stc89
    Target model:
    Name: STC89C52RC/LE52RC
    Magic: F002
    Code flash: 8.0 KB
    EEPROM flash: 6.0 KB
    Target frequency: 11.030 MHz
    Target BSL version: 6.6C
    Target options:
    cpu_6t_enabled=False
    bsl_pindetect_enabled=False
    eeprom_erase_enabled=False
    clock_gain=high
    ale_enabled=True
    xram_enabled=True
    watchdog_por_enabled=False
    Loading flash: 118 bytes (Intel HEX)
    Switching to 115200 baud: checking setting testing done
    Erasing 2 blocks: done
    Writing flash: 640 Bytes [00:00, 7497.76 Bytes/s]                               
    Setting options: done
    Disconnected!
    ```
    这样我们就能看到单片机的现象啦

## Part2 进阶配置
### 配置EIDE
想要在vscode中拥有一套完善的开发环境就少不了一些好用的工具,下面我来讲解一下怎么配置EIDE这款好用的工具
1. 第一步当然是下载`Enbedded IDE`这款插件了,动动你的小手指,在扩展里面下载一下吧

2. 然后我们开始配置我们的EIDE,此时你一定会发现,在vscode的左边,出现了一个小芯片的按钮,我们点一下它,在新跳出来的界面中点击`New Project`开启第一个项目,选择**内置项目模板**,再选择**89C52 SDCC QuickStart** 输入一个项目名称这里我就随便输入一个`test`吧.

3. 选择切换到目录,此时进入跳转,再然后,我们什么都不需要更改,只需要点击`build`,项目就成功构建好了

4. 点击烧录,发现一个奇怪的报错
    ```bash
    终端进程“/bin/bash '-c', 'python ./tools/stcflash.py -p /dev/ttyS0 "/home/mayge/Desktop/WorkSpace/lab2/test0/test/build/Debug/test.hex"'”启动失败(退出代码: 1)。
    ```
    原来是调用了ttyS0这个设备啊,很明显,我们的CH340接在了ttyUSB0这个端口上
    
    最简单的处理办法就是直接更改eide.json文件,找到这一行
    ```json
    "commandLine": "python ./tools/stcflash.py -p ${port} \"${hexFile}\"",
    ```
    将其修改为
    ```json
    "commandLine": "python ./tools/stcflash.py -p /dev/ttyUSB0 \"${hexFile}\"",
    ```
    或者更进一步,直接把之前更改权限的命令也加上,这样一劳永逸
    ```bash
    "commandLine": "sudo chmod 666 /dev/ttyUSB0 && python ./tools/stcflash.py -p /dev/ttyUSB0 \"${hexFile}\""
    ```
    这是点击烧录,就成功啦

- 小插曲:使用EIDE时还需要安装`.NET6`这个包,众所周知,微软的产品对linux一直不大友好,按照常规的安装方法,一定会出现一大堆问题,所以,这里着重强调一下安装过程:
    ![NET6](./Image/NET6.png)
    - 打开终端,输入
        ```bash
        sudo apt install dotnet-sdk-7.0
        ```
        验证安装:
        ```bash
        mayge@mayge:~/Desktop/WorkSpace/lab2 $dotnet --version
        7.0.119
        ```
        这样就好了,其实也并不难,但是假设自己慢慢去找,一定会遇到很多没办法解决的问题,尤其是在`CSDN`这种平台上,很大可能遇到不正确的解决方法,还是建议使用[stackoverflow](https://stackoverflow.com/questions/73753672/a-fatal-error-occurred-the-folder-usr-share-dotnet-host-fxr-does-not-exist).各位新手同志们,别忘了点一点快照,学会优雅的读档哦

> EIDE的程序示例放在了./Demo文件中

### 串口调试工具
在硬件开发的工程中,并不能像在家用电脑上使用`printf`打印出当前状态来得轻松,我们这时候就需要借助串口这一工具,将数据传输到电脑上,这点非常重要,可以极大的方便我们进行调试.
这里我们需要一个usb转ttl的设备,并安装其对应的驱动程序,就比如说,我现在使用的是`CH340`首先我要去查看ubuntu中有没有其对应的驱动程序
```bash
mayge@mayge:~/Desktop/WorkSpace/lab2 $ls /lib/modules/$(uname -r)/kernel/drivers/usb/serial

aircable.ko         io_ti.ko        navman.ko        ti_usb_3410_5052.ko
ark3116.ko          ipaq.ko         omninet.ko       upd78f0730.ko
belkin_sa.ko        ipw.ko          opticon.ko       usb_debug.ko
ch341.ko            ir-usb.ko       option.ko        usbserial.ko
cp210x.ko           iuu_phoenix.ko  oti6858.ko       usb-serial-simple.ko
cyberjack.ko        keyspan.ko      pl2303.ko        usb_wwan.ko
cypress_m8.ko       keyspan_pda.ko  qcaux.ko         visor.ko
digi_acceleport.ko  kl5kusb105.ko   qcserial.ko      whiteheat.ko
empeg.ko            kobil_sct.ko    quatech2.ko      wishbone-serial.ko
f81232.ko           mct_u232.ko     safe_serial.ko   xr_serial.ko
f81534.ko           metro-usb.ko    sierra.ko        xsens_mt.ko
ftdi_sio.ko         mos7720.ko      spcp8x5.ko
garmin_gps.ko       mos7840.ko      ssu100.ko
io_edgeport.ko      mxuport.ko      symbolserial.ko
```
这里我们看到了ch341.ko这个文件就不需要额外的操作了

- 安装cutecom
```bash
sudo apt install cutecom
cutecom
```
启动串口助手,去网上随便搞一点`stc89c52rc`的串口驱动程序体验一下吧

## Part3 小任务
接下来我们将会有一些小小的任务,很简单的哦
### 任务1
这里会有三份程序源码以及三个十六进制文件,你需要做的就是通过烧录之后的现象,给他们进行配对,很简单吧.

### 任务2
看出来了吧,task1.c是一段呼吸灯的代码.不过他并不完善,他只能呼气不能吸气
请在终端中使用指令copy一份`task1.c`,将其命名为`task3.c`,完善呼吸灯之后对其进行编译,烧录到单片机中

tips:
> 编译代码 sdcc -mmcs51 taskx.c
> 烧录代码 stcgal -p /dev/ttyUSB0 -b 115200 taskx.ihx

> 任务文件放在./task文件夹中
> 答题卡是./AnswerSheet.md

## Part4 虚拟51单片机安装
很遗憾,我们没有那么多资源购置人手一块的芯片,大家也暂时不会深入研究硬件相关的内容
假如大家不想要购置实体的板材的话,这里还有一款工具用来虚拟51单片机
具体的程序以及安装说明放在了./emu目录下