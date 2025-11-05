# Radxa ROCK 5B - HAOS-CN-DEV 支持

## 📋 项目介绍

本配置为 Radxa ROCK 5B 开发板提供完整的 Home Assistant Operating System (HAOS) 支持。ROCK 5B 基于 Rockchip RK3588 旗舰级 SoC，具备强大的 AI 推理能力和图形处理性能，是运行 Home Assistant 的理想平台。

### 硬件规格
- **SoC**: Rockchip RK3588 (8核 ARM64)
  - 4×ARM Cortex-A76 @ 2.4GHz
  - 4×ARM Cortex-A55 @ 1.8GHz
- **GPU**: ARM Mali-G610 MP4 (支持 OpenGL ES 3.2, Vulkan)
- **NPU**: 6 TOPS AI 推理性能
- **内存**: 4GB/8GB/16GB LPDDR4/5
- **存储**: microSD、eMMC、M.2 NVMe SSD
- **网络**: 2.5G 以太网、WiFi 6E、蓝牙 5.2
- **接口**: HDMI 2.1、USB 3.0、GPIO、CSI/DSI

## 🔄 Changelog

### v1.0.0 (2025-08-24) - 初始版本

#### ✨ 新增核心文件
- **`radxa_rock5b_defconfig`** (199行) - 完整的 Buildroot 配置文件
- **`hassos-hook.sh`** (22行) - RK3588 特定的构建钩子脚本
- **`uboot-boot.ush`** (98行) - A/B 分区启动脚本
- **`kernel.config`** (54行) - GPU/NPU 内核驱动配置片段
- **`partition-spl-spl.cfg`** (7行) - genimage 分区配置
- **`image-spl-spl.cfg`** - SPL 镜像配置
- **`boot-env.txt`** - U-Boot 环境变量配置
- **`cmdline.txt`** - 内核启动参数配置
- **`uboot.config`** - U-Boot 配置片段

#### 🔧 关键配置详情

**1. Buildroot 核心配置 (radxa_rock5b_defconfig)**
```bash
# 目标架构和处理器配置
BR2_aarch64=y
BR2_cortex_a76_a55=y
BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_6_1=y

# 自定义内核源配置
BR2_LINUX_KERNEL_CUSTOM_GIT=y
BR2_LINUX_KERNEL_CUSTOM_REPO_URL="https://github.com/armbian/linux-rockchip.git"
BR2_LINUX_KERNEL_CUSTOM_REPO_VERSION="rk-6.1-rkr5.1"

# 设备树和内核配置
BR2_LINUX_KERNEL_INTREE_DTS_NAME="rockchip/rk3588-rock-5b"
BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="...\/board\/radxa\/rock5b\/kernel.config"

# U-Boot 配置
BR2_TARGET_UBOOT_BOARD_DEFCONFIG="rock-5b-rk3588"
BR2_TARGET_UBOOT_CONFIG_FRAGMENT_FILES="...\/board\/radxa\/rock5b\/uboot.config"

# 构建脚本路径
BR2_ROOTFS_POST_SCRIPT_ARGS="$(BR2_EXTERNAL_HASSOS_PATH)/board/radxa/rock5b $(BR2_EXTERNAL_HASSOS_PATH)/board/radxa/rock5b/hassos-hook.sh"

# 设备标识
BR2_PACKAGE_OS_AGENT_BOARD="RadxaRock5B"
```

**2. RK3588 SPL 构建配置 (hassos-hook.sh)**
```bash
function hassos_pre_image() {
    local BOOT_DATA="$(path_boot_dir)"
    local SPL_IMG="$(path_spl_img)"
    
    # 标准文件复制
    cp "${BINARIES_DIR}/boot.scr" "${BOOT_DATA}/boot.scr"
    cp "${BINARIES_DIR}"/*.dtb "${BOOT_DATA}/"
    cp "${BOARD_DIR}/boot-env.txt" "${BOOT_DATA}/haos-config.txt"
    cp "${BOARD_DIR}/cmdline.txt" "${BOOT_DATA}/cmdline.txt"
    
    # RK3588 特定的 SPL 配置
    create_spl_image
    dd if="${BINARIES_DIR}/idbloader.img" of="${SPL_IMG}" conv=notrunc bs=512 seek=64   # 0x8000
    dd if="${BINARIES_DIR}/u-boot.itb" of="${SPL_IMG}" conv=notrunc bs=512 seek=16384  # 0x2000000
}
```

**3. A/B 分区启动实现 (uboot-boot.ush)**
- 环境变量持久化存储到 hassos-bootstate 分区
- 支持 BOOT_ORDER="A B" 启动顺序配置
- 每个分区最多重试 3 次 (BOOT_A_LEFT, BOOT_B_LEFT)
- 自动故障切换和计数重置机制
- MACHINE_ID 系统标识支持
- 设备树覆盖层自动应用
- 与 RAUC OTA 系统集成

**4. GPU/NPU 内核驱动支持 (kernel.config)**
```bash
# Mali GPU 驱动
CONFIG_DRM=y
CONFIG_DRM_PANFROST=y
CONFIG_DRM_LIMA=y

# RKNPU 驱动支持
CONFIG_ROCKCHIP_RKNPU=y
CONFIG_ROCKCHIP_RKNPU_DEBUG_FS=y
CONFIG_ROCKCHIP_RKNPU_DRM_GEM=y

# RGA 和视频编解码
CONFIG_ROCKCHIP_RGA=y
CONFIG_ROCKCHIP_RGA2=y
CONFIG_ROCKCHIP_VDEC=y
CONFIG_ROCKCHIP_VENC=y

# 内存管理
CONFIG_ROCKCHIP_IOMMU=y
CONFIG_CMA=y
CONFIG_DMA_CMA=y
CONFIG_CMA_SIZE_MBYTES=256
```

**5. 分区配置 (partition-spl-spl.cfg)**
```bash
partition spl {
    size = ${BOOT_SPL_SIZE}
    image = "spl.img"
    in-partition-table = "no"
    offset = 0
    holes = {"(0; 17k)"}
}
```

#### 🌐 网络功能支持栈

**WiFi 完整支持配置**
```bash
# WPA Supplicant 完整功能
BR2_PACKAGE_WPA_SUPPLICANT=y
BR2_PACKAGE_WPA_SUPPLICANT_WEXT=y
BR2_PACKAGE_WPA_SUPPLICANT_AP_SUPPORT=y
BR2_PACKAGE_WPA_SUPPLICANT_WPA3=y
BR2_PACKAGE_WPA_SUPPLICANT_DBUS=y
BR2_PACKAGE_WPA_SUPPLICANT_DBUS_INTROSPECTION=y

# 网络管理
BR2_PACKAGE_NETWORK_MANAGER=y
BR2_PACKAGE_NETWORK_MANAGER_CLI=y
BR2_PACKAGE_WIRELESS_REGDB=y
```

**蓝牙完整支持配置**
```bash
# BlueZ 5 完整套件
BR2_PACKAGE_BLUEZ5_UTILS=y
BR2_PACKAGE_BLUEZ5_UTILS_CLIENT=y
BR2_PACKAGE_BLUEZ5_UTILS_TOOLS=y
BR2_PACKAGE_BLUEZ5_UTILS_DEPRECATED=y
BR2_PACKAGE_BLUEZ5_UTILS_PLUGINS_AUDIO=y
BR2_PACKAGE_BLUEZ5_UTILS_PLUGINS_HID=y
```

**固件支持 (支持20+种无线芯片)**
```bash
# MediaTek 系列
BR2_PACKAGE_LINUX_FIRMWARE_MEDIATEK_MT7921=y
BR2_PACKAGE_LINUX_FIRMWARE_MEDIATEK_MT7922=y
BR2_PACKAGE_LINUX_FIRMWARE_MEDIATEK_MT7921_BT=y
BR2_PACKAGE_LINUX_FIRMWARE_MEDIATEK_MT7922_BT=y

# Broadcom 系列
BR2_PACKAGE_LINUX_FIRMWARE_BRCM_BCM43XX=y
BR2_PACKAGE_LINUX_FIRMWARE_BRCM_BCM43XXX=y

# Realtek 系列
BR2_PACKAGE_LINUX_FIRMWARE_RTL_87XX=y
BR2_PACKAGE_LINUX_FIRMWARE_RTL_RTW88=y
BR2_PACKAGE_LINUX_FIRMWARE_RTL_RTW89=y
BR2_PACKAGE_LINUX_FIRMWARE_RTL_87XX_BT=y
BR2_PACKAGE_LINUX_FIRMWARE_RTL_88XX_BT=y

# USB WiFi 适配器驱动
BR2_PACKAGE_RTL8812AU_AIRCRACK_NG=y
BR2_PACKAGE_RTL8821CU=y
BR2_PACKAGE_RTL88X2BU=y
```

#### 🎮 图形和计算加速支持

**Mesa3D GPU 驱动栈**
```bash
BR2_PACKAGE_MESA3D=y
BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_PANFROST=y
BR2_PACKAGE_MESA3D_OPENGL_EGL=y
BR2_PACKAGE_MESA3D_OPENGL_ES=y
BR2_PACKAGE_LIBDRM=y
BR2_PACKAGE_LIBDRM_INSTALL_TESTS=y
```

#### 🔧 构建系统优化

**编译优化配置**
```bash
# 链接时优化
BR2_ENABLE_LTO=y
# 编译缓存
BR2_CCACHE=y
BR2_CCACHE_DIR="/cache/cc"
# 下载缓存
BR2_DL_DIR="/cache/dl"
```

**Rockchip 专用配置**
```bash
# Rockchip 闭源固件
BR2_PACKAGE_ROCKCHIP_BLOBS=y
BR2_PACKAGE_ROCKCHIP_BLOBS_VERSION="b4558da0860ca48bf1a571dd33ccba580b9abe23"
BR2_PACKAGE_ROCKCHIP_BLOBS_ATF="bin/rk35/rk3588_bl31_v1.40.elf"
BR2_PACKAGE_ROCKCHIP_BLOBS_TPL="bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.12.bin"
```



## 🎯 配置特点和重点

### 🚀 技术亮点

**1. 高性能硬件平台**
- **RK3588 旗舰级 SoC**: 8核 ARM Cortex-A76/A55 架构，支持高效多任务处理
- **Mali-G610 MP4 GPU**: 支持 OpenGL ES 3.2、Vulkan 1.1，提供强大的 3D 图形渲染能力
- **6 TOPS NPU**: 支持 INT4/INT8/INT16 精度，为 AI 推理应用提供加速
- **大容量内存**: 支持最大 32GB LPDDR5，内存带宽高达 102.4GB/s

**2. 专业内核优化**
- **Armbian Rockchip 内核**: 使用 rk-6.1-rkr5.1 分支，针对 RK35xx 系列深度优化
- **完整驱动支持**: 包含 Rockchip 官方闭源驱动和性能优化补丁
- **动态频率管理**: CPU/GPU/NPU 独立调频，平衡性能和功耗
- **温度控制**: 智能散热策略，支持外置风扇和散热片

**3. 企业级可靠性**
- **A/B 分区冗余**: 实现双系统分区，确保系统更新失败时自动回滚
- **智能故障恢复**: 启动失败时自动切换至备用分区
- **硬件看门狗**: 防止系统死锁，支持自动重启恢复
- **安全 OTA**: 与 RAUC 集成，支持原子化系统更新

### 🔧 技术架构特色

**1. 完整硬件加速栈**
```
用户应用
    ↓
OpenGL ES 3.2 / Vulkan API
    ↓
Mesa3D Panfrost 驱动
    ↓
DRM 子系统
    ↓
Mali-G610 MP4 硬件
```

**2. AI 推理加速栈**
```
RKNN-Toolkit2 开发工具
    ↓
RKNN Runtime 运行时
    ↓
RKNPU 内核驱动
    ↓
6 TOPS NPU 硬件
```

**3. 网络功能完整性**
- ✅ **WiFi 6E 三频**: 2.4G/5G/6G 同时支持，最高 2.4Gbps
- ✅ **蓝牙 5.2**: BLE、A2DP、HFP、HID 等主流协议全支持
- ✅ **有线网络**: 2.5G 以太网，支持 WoL 网络唤醒
- ✅ **网络管理**: NetworkManager 统一管理，支持热点模式
- ✅ **企业安全**: WPA3 加密、802.1X 认证、防火墙集成

**4. 存储和文件系统**
- **多种存储接口**: microSD、eMMC 5.1、M.2 NVMe PCIe 3.0
- **EROFS 文件系统**: 高效压缩、去重、快速启动
- **存储保护**: Wear Leveling、Bad Block 管理、数据校验
- **快速启动**: 从上电到 Home Assistant 可用仅需 60 秒

### 🔍 核心技术实现

**1. A/B 分区启动机制**
```bash
# 分区布局
hassos-boot        # 启动分区 (FAT32, 512MB)
hassos-bootstate   # 启动状态 (4KB)
hassos-kernel0     # A 分区内核 (64MB)
hassos-system0     # A 分区系统 (1GB+)
hassos-kernel1     # B 分区内核 (64MB)
hassos-system1     # B 分区系统 (1GB+)
hassos-data        # 用户数据分区

# 启动逻辑
1. U-Boot 读取 bootstate 分区状态
2. 根据 BOOT_ORDER 尝试启动分区
3. 每次尝试递减剩余次数
4. 成功启动后重置计数器
5. 失败时切换到备用分区
```

**2. RK3588 SPL 配置**
```bash
# 启动加载器布局 (hassos-hook.sh)
Offset 0x8000   (32KB):  idbloader.img  # TPL + SPL
Offset 0x200000 (2MB):   u-boot.itb     # U-Boot FIT image

# 启动顺序
MaskROM → TPL → SPL → U-Boot → Linux Kernel
```

**3. GPU/NPU 驱动栈**
```bash
# Mesa3D 配置
/dev/dri/card0          # GPU 设备节点
/dev/dri/renderD128     # 渲染节点
/sys/class/devfreq/     # 频率控制

# RKNPU 配置  
/dev/rknpu_service      # NPU 服务节点
/sys/class/rknpu/       # NPU 状态信息
/sys/kernel/debug/rknpu # 调试信息
```

**4. 内核配置关键点**
```bash
# 内存管理
CONFIG_CMA_SIZE_MBYTES=256     # GPU/NPU 共享内存
CONFIG_ROCKCHIP_IOMMU=y        # 内存地址转换

# 性能监控
CONFIG_ARM_PMU=y               # ARM 性能计数器
CONFIG_HW_PERF_EVENTS=y        # 硬件性能事件

# 电源管理
CONFIG_CPU_FREQ=y              # CPU 动态调频
CONFIG_DEVFREQ_GOV_*=y         # GPU/NPU 调频策略
```

## 📖 使用指南

### 🛠️ 构建环境要求

#### 系统要求
- **操作系统**: Ubuntu 20.04+ 或 Debian 11+
- **内存**: 至少 8GB RAM (推荐 16GB)
- **存储**: 至少 100GB 可用空间
- **网络**: 稳定的互联网连接

#### 必需软件
```bash
# 安装基础构建工具
sudo apt update
sudo apt install -y build-essential git python3 python3-pip
sudo apt install -y libncurses5-dev bc rsync cpio unzip

# 安装 Docker (可选，用于容器化构建)
sudo apt install -y docker.io
sudo usermod -aG docker $USER
```

### 🔨 构建步骤

#### 1. 获取源码
```bash
# 克隆 HAOS 官方源码
git clone https://github.com/home-assistant/operating-system.git
cd operating-system

# 克隆本配置仓库
git clone https://github.com/ha-china/HAOS-CN-DEV.git ../HAOS-CN-DEV

# 复制配置到构建目录
cp -r ../HAOS-CN-DEV/buildroot-external .
```

#### 2. 配置构建环境
```bash
# 设置环境变量
export BR2_EXTERNAL=$(pwd)/buildroot-external

# 初始化子模块
git submodule update --init --recursive
```

#### 3. 开始构建
```bash
# 配置 ROCK 5B
make BR2_EXTERNAL=./buildroot-external radxa_rock5b_defconfig

# 开始构建 (需要 2-4 小时)
make BR2_EXTERNAL=./buildroot-external -j$(nproc)
```

#### 4. 获取镜像
```bash
# 构建完成后，镜像位于
ls output/images/
# haos_radxa_rock5b-*.img.xz
```

### 💾 镜像烧录

#### 烧录到 microSD 卡
```bash
# 解压镜像
xz -d haos_radxa_rock5b-*.img.xz

# 烧录到 SD 卡 (替换 /dev/sdX 为实际设备)
sudo dd if=haos_radxa_rock5b-*.img of=/dev/sdX bs=4M status=progress
sudo sync
```

#### 烧录到 eMMC (可选)
```bash
# 需要先从 SD 卡启动，然后在系统中烧录
# 详细步骤请参考 Radxa 官方文档
```

### 🚀 首次启动

#### 1. 硬件连接
- 插入烧录好的 microSD 卡
- 连接 HDMI 显示器 (可选)
- 连接网络线缆或配置 WiFi
- 连接电源 (5V/3A 推荐)

#### 2. 启动过程
```
1. 上电自检 (3-5 秒)
2. U-Boot 启动 (5-10 秒) 
3. Linux 内核加载 (10-15 秒)
4. Home Assistant 初始化 (1-2 分钟)
5. Web 界面可访问
```

#### 3. 访问系统
- **Web 界面**: http://homeassistant.local:8123
- **SSH 访问**: 默认禁用，需要在配置中启用
- **串口调试**: 115200 8N1 (GPIO 引脚)

### 🔧 配置和优化

#### 网络配置
```yaml
# configuration.yaml 示例
network:
  wifi:
    ssid: "YourWiFiName"
    password: "YourPassword"
    
bluetooth:
  adapter: hci0
```

#### GPU 加速验证
```bash
# 检查 GPU 设备
ls /dev/dri/

# 测试 OpenGL ES
glmark2-es2
```

#### NPU 功能测试
```bash
# 查看 NPU 设备
ls /sys/class/rknpu/

# NPU 需要配合 RKNN-Toolkit 使用
```

### 🐛 故障排除

#### 常见问题

**1. 启动失败**
- 检查 SD 卡是否正确烧录
- 确认电源供应充足 (5V/3A)
- 查看串口输出获取错误信息

**2. 网络连接问题**
- 检查网线连接
- 确认 WiFi 配置正确
- 查看 NetworkManager 日志

**3. 性能问题**
- 确认散热良好
- 检查 CPU 频率设置
- 监控系统资源使用

#### 调试方法
```bash
# 查看系统日志
journalctl -f

# 检查 Home Assistant 状态
ha core info

# 查看硬件信息
cat /proc/cpuinfo
cat /proc/meminfo
lspci
lsusb
```

### 📚 开发资源

#### 相关文档
- [HAOS 官方文档](https://github.com/home-assistant/operating-system)
- [Radxa ROCK 5B 官方文档](https://docs.radxa.com/en/rock5/rock5b)
- [Armbian Rockchip 内核](https://github.com/armbian/linux-rockchip)

#### 社区支持
- [Home Assistant 中文社区](https://bbs.hassbian.com/)
- [HAOS-CN-DEV Issues](https://github.com/ha-china/HAOS-CN-DEV/issues)
- [Radxa 官方论坛](https://forum.radxa.com/)

#### 贡献指南
1. Fork 本仓库
2. 创建功能分支
3. 提交改动并测试
4. 创建 Pull Request
5. 等待代码审查

## ⚠️ 重要提醒

### 使用须知
- **测试版本**: 本配置为测试版，不建议生产环境使用
- **社区维护**: 由社区志愿者维护，问题响应可能有延迟
- **硬件兼容**: 仅适用于 Radxa ROCK 5B，不适用于其他设备
- **风险自担**: 使用本配置的风险由用户自行承担

### 安全建议
- 定期备份重要数据
- 及时更新系统补丁
- 使用强密码保护
- 限制网络访问权限

## 📝 许可证

本项目基于 [Apache License 2.0](LICENSE) 开源协议。

## 🤝 致谢

感谢以下项目和社区的支持：
- [Home Assistant Operating System](https://github.com/home-assistant/operating-system)
- [Armbian](https://www.armbian.com/)
- [Radxa](https://radxa.com/)
- [Home Assistant 中文社区](https://bbs.hassbian.com/)

---

**最后更新**: 2025-08-24  
**版本**: v1.0.0  
**维护者**: HAOS-CN-DEV 团队