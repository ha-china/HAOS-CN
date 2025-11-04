# ROCK 5B RKNPU 驱动集成指南

## 📋 **RKNPU 概述**

RKNPU (Rockchip Neural Processing Unit) 是 RK3588 SoC 中专用的 AI 加速单元，通过集成 Rockchip 提供的 out-of-tree 驱动，可以为 Home Assistant 提供强大的 AI 推理能力。

## 🚀 **主要功能**

### **硬件规格**
- **NPU算力**: RK3588 集成 6 TOPS NPU
- **支持架构**: INT4/INT8/INT16/FP16
- **内存接口**: 共享系统内存，支持大模型
- **并发处理**: 多核心并行计算

### **支持的 AI 模型**
- **大语言模型**: LLAMA, Qwen2/2.5/3, Phi2/3, ChatGLM3-6B
- **多模态模型**: Qwen2-VL, MiniCPM-V, InternVL2
- **轻量模型**: TinyLLAMA, MiniCPM3/4, SmolVLM
- **特殊模型**: RWKV7, DeepSeek-R1-Distill

## 🔧 **集成配置**

### **驱动信息**
- **驱动版本**: 0.9.8_20241009
- **驱动来源**: https://github.com/airockchip/rknn-llm
- **许可证**: GPL-2.0
- **支持平台**: RK3588 系列 (包括 RK3588S)

### **内核配置增强**
相比基础配置，RKNPU 版本增加了以下内核功能：

```bash
# DMA buffer framework for NPU memory management
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_HEAP=y
CONFIG_DMA_HEAP_SYSTEM=y
CONFIG_DMA_HEAP_CMA=y

# Enhanced CMA for NPU (increased from 256MB to 512MB)
CONFIG_CMA_SIZE_MBYTES=512

# Enhanced debugging for NPU development
CONFIG_DEBUG_FS=y

# Power management for NPU
CONFIG_ROCKCHIP_PM_DOMAINS=y
```

### **用户空间配置**
```bash
# RKNPU driver package
BR2_PACKAGE_RKNPU_DRIVER=y

# Basic DRM support for video acceleration
BR2_PACKAGE_LIBDRM=y
```

## 💻 **使用方式**

### **设备节点**
RKNPU 驱动会创建以下设备节点：
- `/dev/rknpu` - 主 NPU 设备
- `/dev/rknpu0` - NPU 核心 0
- `/dev/rknpu1` - NPU 核心 1 (如果可用)
- `/dev/rknpu2` - NPU 核心 2 (如果可用)

### **权限配置**
udev 规则自动设置设备权限：
```bash
# RKNPU device access (mode 0666)
SUBSYSTEM=="misc", KERNEL=="rknpu*", MODE="0666", GROUP="users"
```

### **内存分配**
- **CMA 内存**: 512MB 专用于 NPU 大内存分配
- **DMA Heap**: 动态内存管理，支持大模型推理
- **共享内存**: 与 CPU/GPU 高效数据交换

## 🎯 **应用场景**

### **✅ 适合的 AI 应用**
1. **智能家居助手**
   - 语音识别和合成
   - 自然语言处理
   - 智能对话系统

2. **视频分析**
   - 目标检测和跟踪
   - 人脸识别
   - 行为分析

3. **边缘计算**
   - 本地 AI 推理
   - 实时数据处理
   - 隐私保护计算

4. **Home Assistant 增强**
   - 智能自动化规则
   - 语音控制
   - 图像识别集成

### **⚠️ 性能考虑**
- **大模型**: 支持 7B 参数以下模型流畅运行
- **推理速度**: 根据模型复杂度，2-20 tokens/秒
- **内存需求**: 大模型需要 4-8GB 系统内存
- **功耗**: NPU 运行时增加 2-5W 功耗

## 🔍 **技术细节**

### **驱动架构**
```
应用层 (RKLLM Runtime)
├── RKNN API
├── 用户空间库
└── 设备节点接口
    ↓
内核层 (RKNPU Driver)  
├── 字符设备驱动
├── DMA 内存管理
├── 中断处理
└── 电源管理
    ↓
硬件层 (RK3588 NPU)
├── 6 TOPS 算力
├── 多核心架构
└── 共享内存总线
```

### **与其他组件协作**
- **Mali GPU**: 并行工作，各自处理适合的任务
- **CPU**: 协同计算，数据预处理和后处理
- **内存**: 统一内存架构，高效数据共享
- **存储**: 模型缓存，快速加载常用模型

## 📊 **性能测试**

### **基准测试命令**
```bash
# 检查 NPU 设备状态
ls -la /dev/rknpu*

# 查看 NPU 驱动信息
cat /proc/version
lsmod | grep rknpu

# 检查内存分配
cat /proc/meminfo | grep -i cma
cat /sys/kernel/debug/dma_buf/bufinfo

# NPU 使用率监控 (需要工具支持)
# 具体监控工具依赖于 RKLLM Runtime
```

### **典型性能指标**
| 模型类型 | 参数量 | 推理速度 | 内存占用 | 适用场景 |
|----------|--------|----------|----------|----------|
| **TinyLLAMA** | 1.1B | 15-20 t/s | 2GB | 轻量对话 |
| **Qwen2-0.5B** | 0.5B | 20-25 t/s | 1.5GB | 快速响应 |
| **Phi3-3.8B** | 3.8B | 8-12 t/s | 4GB | 平衡性能 |
| **ChatGLM3-6B** | 6B | 5-8 t/s | 6GB | 高质量对话 |

## 🛠️ **开发集成**

### **Home Assistant 集成示例**
```python
# 在 Home Assistant 中使用 RKNPU
# (需要安装 RKLLM Python 包)

import rkllm

# 初始化 NPU
npu = rkllm.RKLLM()
model_path = "/config/models/qwen2-0.5b.rkllm"
npu.load(model_path)

# AI 推理
def ai_chat(prompt):
    response = npu.inference(prompt)
    return response

# 集成到 Home Assistant 自动化
```

### **Docker 容器支持**
```dockerfile
# Dockerfile 中添加 NPU 设备访问
FROM homeassistant/home-assistant:latest

# 添加 NPU 设备访问权限
# 在 docker run 时添加: --device /dev/rknpu
```

## 🔧 **故障排除**

### **常见问题**

1. **设备节点不存在**
   ```bash
   # 检查驱动是否加载
   lsmod | grep rknpu
   dmesg | grep -i rknpu
   ```

2. **权限被拒绝**
   ```bash
   # 检查设备权限
   ls -la /dev/rknpu*
   # 应该显示 crw-rw-rw- 权限
   ```

3. **内存不足**
   ```bash
   # 检查 CMA 内存
   cat /proc/meminfo | grep -i cma
   # 确保有足够的可用内存
   ```

4. **性能不佳**
   ```bash
   # 检查 CPU 频率
   cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
   # 检查温度限制
   cat /sys/class/thermal/thermal_zone*/temp
   ```

## 📈 **未来扩展**

### **计划功能**
- **模型自动下载**: 集成模型仓库
- **性能监控**: NPU 使用率仪表板
- **自动优化**: 根据硬件自动选择最佳模型
- **多模型支持**: 同时运行多个小模型

### **社区贡献**
- **模型优化**: 针对 Home Assistant 场景的专用模型
- **插件开发**: Home Assistant RKNPU 集成插件
- **性能测试**: 更多模型的性能基准

## 🎉 **总结**

RKNPU 驱动集成为 ROCK 5B 带来了强大的 AI 能力：

- ✅ **高性能**: 6 TOPS NPU 算力，支持大模型推理
- ✅ **低延迟**: 本地推理，无网络依赖
- ✅ **隐私保护**: 数据不离开设备
- ✅ **能效比**: 专用 NPU 比 CPU 推理能效更高
- ✅ **易集成**: 标准设备节点，支持多种开发语言

这使得 ROCK 5B 成为一个真正的智能家居 AI 计算中心！