# Radxa ROCK 5B GPU/NPU Support

## Overview
This configuration enables GPU and NPU support for the Radxa ROCK 5B board based on RK3588 SoC.

## Hardware Specifications
- **SoC**: Rockchip RK3588
- **GPU**: ARM Mali-G610 MP4 (Bifrost architecture)
- **NPU**: RKNPU with 6 TOPS AI performance
- **Video Codecs**: Hardware-accelerated encoding/decoding

## Kernel Configuration

### GPU Support
- **DRM/KMS**: Direct Rendering Manager support
- **Panfrost Driver**: Open-source Mali GPU driver
- **Mesa3D**: OpenGL ES and EGL support in userspace

### NPU Support  
- **RKNPU Driver**: Rockchip NPU kernel driver
- **DRM GEM**: GPU memory management integration
- **Debug Support**: Enable debug filesystem for NPU

### Video Processing
- **RGA**: Raster Graphics Acceleration unit
- **VPU**: Video processing unit for codec acceleration
- **V4L2**: Video4Linux2 memory-to-memory device support

### Memory Management
- **IOMMU**: I/O Memory Management Unit support
- **CMA**: Contiguous Memory Allocator (256MB reserved)
- **DMA**: Direct Memory Access engine support

## Device Tree Changes
The device tree patch ensures:
- GPU device is enabled with proper power supply
- NPU device is enabled with proper power supply  
- NPU MMU is activated for memory management

## Userspace Support
- **libdrm**: Direct Rendering Manager userspace library
- **Mesa3D**: 3D graphics library with Panfrost driver
- **OpenGL ES**: Hardware-accelerated graphics API

## Usage Notes
1. GPU acceleration is available through standard OpenGL ES APIs
2. NPU requires specific SDK or frameworks (like RKNN-Toolkit)
3. Video codecs are accessible through V4L2 or GStreamer
4. RGA can be used for 2D graphics acceleration

## Performance Considerations
- CMA memory is pre-allocated for GPU/NPU usage
- IOMMU provides memory protection and virtualization
- Performance monitoring counters are enabled

## Development Tools
- Use `drminfo` to check GPU capabilities
- Use `v4l2-ctl` to test video codec functionality
- Monitor NPU usage through debug filesystem (if enabled)