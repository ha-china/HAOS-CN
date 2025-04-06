# HAOS中国特供版
为中国地区专门加速的HAOS，不修改任何系统内的其它任何信息，只用来加速。系统由GitHub Actions自动构建
## 主要修改

移除了所有国内不稳定或者无法访问的官方自带的加载项源（ [官方加载项](https://github.com/home-assistant/addons) ，[官方社区加载项](https://github.com/hassio-addons/repository) ，[音乐助手](https://github.com/music-assistant/home-assistant-addon)），换成了加速源 [查看链接](https://gitee.com/desmond_GT/hassio-addons)

同时集成了极速版HACS(Alone)[HACS China](https://github.com/hacs-china), 免github帐号，免科学无损使用HACS
更新频率从一个月7~8降到一个月一次


## 测试是否达到测试条件

**网络无翻墙功能**

- 方法1
ping ghcr.io，延时很大甚至有丢包的
```bash
C:\Users\djhui>ping ghcr.io

Pinging ghcr.io [20.205.243.164] with 32 bytes of data:
Reply from 20.205.243.164: bytes=32 time=67ms TTL=112
Reply from 20.205.243.164: bytes=32 time=67ms TTL=112
Reply from 20.205.243.164: bytes=32 time=67ms TTL=112
Reply from 20.205.243.164: bytes=32 time=67ms TTL=112
```
- 方法2
通过docker 拉取镜像很慢，几乎不能拉取的

```bash
docker pull ghcr.io/home-assistant/home-assistant:stable
```

## 满足条件后测试方法

从这里下载静像

链接: [https://github.com/ha-china/HAOS-CN/releases/tag/15.1](https://github.com/ha-china/HAOS-CN/releases/tag/15.1)

其它版本与官方安装一致，
x86版本，如果没有物理机，可以通过解压后用qemu的方式测试，可能跟物理机会略有区别。

解压出文件haos_generic-x86-64-15.1.img

运行如下命令：

```bash
sudo qemu-system-x86_64 -m 2048 -smp 2 -drive file=haos_generic-x86-64-15.1.img,format=raw -display sdl -bios /usr/share/ovmf/OVMF.fd -netdev user,id=net0,hostfwd=tcp::8123-:8123 -device e1000,netdev=net0
```

- 浏览器访问localhost:8123

记录整个初始化的时间告诉我

> 当前版本已经集成了[HACS极速版](https://github.com/hacs-china)，可以在系统集成里直接添加

 > HACS极速版可以免github帐号让中国用户使用也是由不同的网友共享自己的Token来实现的，如果你用的官方原版，并且愿意共享你的Token，请[点击我](https://tokenhub.hacs.vip/)共享，或者想要具体步骤看怎么分享的，请[点击我](https://mp.weixin.qq.com/s/wjzuSbZm1oSsIbotfzOotA)查看操作方法

## 如果你能适配机型，欢迎提交各类适配机型配置
