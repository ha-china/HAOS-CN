# ROCK 5B 主线内核配置变更说明

## 📋 变更概述

将 Radxa ROCK 5B 的内核配置从 Armbian 自定义内核切换到与 Orange Pi 5B 相同的主线内核 6.12.33。

## 🔄 主要变更

### 内核版本变更
- **之前**: Armbian linux-rockchip 6.1 (rk-6.1-rkr5.1 分支)
- **现在**: 主线内核 6.12.33

### 配置路径更新
```diff
- BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_6_1=y
+ BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_6_12=y

- BR2_LINUX_KERNEL_CUSTOM_GIT=y
- BR2_LINUX_KERNEL_CUSTOM_REPO_URL="https://github.com/armbian/linux-rockchip.git"  
- BR2_LINUX_KERNEL_CUSTOM_REPO_VERSION="rk-6.1-rkr5.1"
+ BR2_LINUX_KERNEL_CUSTOM_VERSION=y
+ BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.33"

- BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="$(BR2_EXTERNAL_HASSOS_PATH)/kernel/v6.1.y/kernel-arm64-rockchip.config"
+ BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="$(BR2_EXTERNAL_HASSOS_PATH)/kernel/v6.12.y/kernel-arm64-rockchip.config"

- BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="...v6.1.y/..."
+ BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="...v6.12.y/...device-support-wireless.config..."
```

## ⚠️ 功能影响分析

### ❌ 不再支持的功能
1. **RKNPU (神经网络处理单元)**
   - 主线内核不包含 ROCKCHIP_RKNPU 驱动
   - AI 推理性能将显著降低
   - 需要用户空间替代方案

2. **硬件视频编解码**
   - VPU 编解码器支持有限
   - ROCKCHIP_VDEC/VENC 可能不可用
   - 硬件加速视频处理受影响

3. **RGA (光栅图形加速)**
   - ROCKCHIP_RGA/RGA2 支持有限
   - 2D 图形加速性能下降

### ✅ 仍然支持的功能
1. **基础 GPU 支持**
   - Mali GPU 通过 Panfrost 驱动支持
   - OpenGL ES 和 Vulkan 基础功能

2. **标准外设**
   - 以太网 (2.5G)
   - USB 3.0/2.0
   - PCIe
   - SATA
   - I2C/SPI

3. **电源管理**
   - 基础的 CPU 频率调节
   - 温度监控

## 🔧 替代方案建议

### RKNPU 替代方案
1. **CPU 推理**: 使用 TensorFlow Lite、ONNX Runtime CPU 版本
2. **GPU 推理**: 利用 Mali GPU 的 OpenCL 支持（如果可用）
3. **外部加速器**: 考虑 USB/PCIe AI 加速卡

### 视频编解码替代方案
1. **软件编解码**: 使用 FFmpeg CPU 编解码
2. **GPU 加速**: 利用 Mali GPU 的有限硬件加速

## 📊 性能预期

| 功能域 | 预期性能变化 | 说明 |
|--------|-------------|------|
| AI推理 | 📉 显著下降 (50-80%) | 无专用NPU支持 |
| 视频编解码 | 📉 中等下降 (30-50%) | 软件回退 |
| 2D图形 | 📉 轻微下降 (10-20%) | 无RGA加速 |
| 3D图形 | 📊 基本相同 | Panfrost驱动支持 |
| 网络性能 | 📊 相同 | 2.5G以太网正常 |
| 存储性能 | 📊 相同 | SATA/eMMC正常 |
| 系统稳定性 | 📈 可能改善 | 主线内核更稳定 |

## 🎯 适用场景

### ✅ 适合的使用场景
- 标准 Home Assistant 功能
- 网络应用和服务
- 轻量级计算任务
- 开发和测试环境

### ❌ 不适合的使用场景  
- AI 边缘计算应用
- 高性能视频处理
- 需要专用 NPU 的应用
- 对硬件加速要求高的场景

## 🔄 回退方案

如果需要完整的 RK3588 硬件支持，可以：

1. **切换回 Armbian 内核**:
   ```bash
   git checkout feature/radxa-rock5b-support
   # 恢复 Armbian 6.1 内核配置
   ```

2. **或使用其他专门的 RK3588 发行版**

## 📝 总结

此变更提高了与项目其他 RK3588 设备的一致性，简化了维护工作，但牺牲了一些 RK3588 特有的硬件加速功能。适合标准应用场景，不适合对AI性能有高要求的用例。