# Radxa ROCK 5B Kernel Configuration Changes

## 修正说明

根据用户要求使用 Armbian Linux Rockchip 内核源，对 ROCK 5B 的内核配置进行了以下修正：

## 原始配置 (有问题)
```bash
# 使用主线内核
BR2_LINUX_KERNEL_CUSTOM_VERSION=y
BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.35"

# 内核头文件版本
BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_6_12=y

# 配置文件路径
BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="$(BR2_EXTERNAL_HASSOS_PATH)/kernel/v6.12.y/kernel-arm64-rockchip.config"
BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="$(BR2_EXTERNAL_HASSOS_PATH)/kernel/v6.12.y/hassos.config ..."
```

## 修正后配置 ✅
```bash
# 使用 Armbian Linux Rockchip 内核源
BR2_LINUX_KERNEL_CUSTOM_GIT=y
BR2_LINUX_KERNEL_CUSTOM_REPO_URL="https://github.com/armbian/linux-rockchip.git"
BR2_LINUX_KERNEL_CUSTOM_REPO_VERSION="rk-6.1-rkr5.1"

# 内核头文件版本 (匹配 6.1)
BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_6_1=y

# 配置文件路径 (调整为 6.1)
BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="$(BR2_EXTERNAL_HASSOS_PATH)/kernel/v6.1.y/kernel-arm64-rockchip.config"
BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="$(BR2_EXTERNAL_HASSOS_PATH)/kernel/v6.1.y/hassos.config ..."
```

## 主要变更

### 1. 内核源地址
- **从**: 主线 Linux 内核 (默认)
- **到**: Armbian Linux Rockchip 仓库
- **地址**: `https://github.com/armbian/linux-rockchip.git`
- **分支**: `rk-6.1-rkr5.1`

### 2. 内核版本
- **从**: 6.12.35 (主线)
- **到**: 6.1.x (Armbian Rockchip)
- **优势**: 更好的 RK3588 硬件支持

### 3. 配置文件路径
- 所有内核相关配置路径从 `v6.12.y` 调整为 `v6.1.y`
- 确保与 Armbian 内核版本匹配

## 为什么使用 Armbian 内核？

1. **专门优化**: Armbian 内核专门为 Rockchip SoC 优化
2. **硬件支持**: 包含更多 RK3588 特定的驱动和补丁
3. **GPU/NPU**: 更好的 Mali GPU 和 RKNPU 支持
4. **稳定性**: 经过 Armbian 社区测试和验证

## 潜在风险

1. **兼容性**: 6.1 内核可能与某些新特性不兼容
2. **HAOS 支持**: 需要确认 HAOS v6.1.y 配置文件存在
3. **构建时间**: 首次构建需要下载完整内核源

## 验证方法

构建时检查内核源下载：
```bash
# 构建日志中应显示
>>> linux custom Downloading
>>> Cloning https://github.com/armbian/linux-rockchip.git
>>> Checking out rk-6.1-rkr5.1
```