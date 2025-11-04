# Radxa ROCK 5B A/B Partition Support

## 问题描述

原始的 ROCK 5B uboot-boot.ush 配置缺少 A/B 分区启动方案，仅提供了简单的单分区启动逻辑。这与 HAOS 的标准 A/B 分区冗余更新机制不匹配。

## 修复内容

### 原始配置 ❌
```bash
# 简单的单分区启动
load ${devtype} ${devnum}:1 ${kernel_addr_r} ${prefix}Image
setenv bootargs "root=/dev/mmcblk0p3 rootwait ro ${extra_bootargs}"
booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r}
```

### 新配置 ✅
```bash
# 完整的 A/B 分区启动方案
part start ${devtype} ${devnum} hassos-bootstate mmc_env
setenv loadbootstate "..."
setenv storebootstate "..."

# A/B 分区 PARTUUID
setenv bootargs_a "root=PARTUUID=8d3d53e3-6d49-4c38-8349-aff6859e82fd ro rootwait"
setenv bootargs_b "root=PARTUUID=a3ec664e-32ce-4665-95ea-7ae90ce9aa20 ro rootwait"

# A/B 启动逻辑
for BOOT_SLOT in "${BOOT_ORDER}"; do
  if test "x${BOOT_SLOT}" = "xA"; then
    # 尝试从 hassos-kernel0 启动 A 槽
  elif test "x${BOOT_SLOT}" = "xB"; then
    # 尝试从 hassos-kernel1 启动 B 槽
  fi
done
```

## A/B 分区方案的优势

### 1. **冗余启动** 🔄
- **双系统槽**: A/B 两个完整的系统分区
- **故障恢复**: 一个槽损坏时自动切换到另一个槽
- **启动计数**: 每个槽最多重试 3 次

### 2. **安全更新** 🛡️
- **原子更新**: 更新写入非活动槽，完成后切换
- **回滚机制**: 更新失败时自动回滚到上一个稳定版本
- **无缝升级**: 系统运行期间后台下载更新

### 3. **状态管理** 📊
- **启动状态**: 存储在 `hassos-bootstate` 分区
- **机器ID**: 持久化设备唯一标识
- **首次启动**: 支持 `systemd.condition-first-boot` 检测

## 关键组件

### 分区布局
```
hassos-bootstate  -> 启动状态存储
hassos-boot      -> U-Boot 配置和设备树
hassos-kernel0   -> A 槽内核
hassos-kernel1   -> B 槽内核
hassos-system0   -> A 槽根文件系统 (PARTUUID: 8d3d53e3...)
hassos-system1   -> B 槽根文件系统 (PARTUUID: a3ec664e...)
```

### 环境变量
```bash
BOOT_ORDER="A B"     # 启动顺序
BOOT_A_LEFT=3        # A 槽剩余尝试次数
BOOT_B_LEFT=3        # B 槽剩余尝试次数
MACHINE_ID=<uuid>    # 设备唯一标识
```

### RAUC 集成
- `rauc.slot=A` / `rauc.slot=B` 标识当前活动槽
- 与 HAOS 的 RAUC 更新系统完全兼容
- 支持增量更新和完整镜像更新

## 设备树配置
- **文件名**: `rk3588-rock-5b.dtb`
- **覆盖层**: 支持动态设备树覆盖 (*.dtbo)
- **错误处理**: 覆盖失败时恢复原始设备树

## 与其他设备的一致性

现在 ROCK 5B 的启动逻辑与以下设备保持一致：
- ✅ OrangePi 5B
- ✅ OrangePi CM4  
- ✅ OrangePi CM4 v1.4
- ✅ 其他 HAOS 支持的设备

## 验证方法

启动时在串口输出中查看：
```
loading env...
Trying to boot slot A, 2 attempts remaining. Loading kernel ...
Starting kernel
```

如果 A 槽失败，会看到：
```
Trying to boot slot B, 2 attempts remaining. Loading kernel ...
```