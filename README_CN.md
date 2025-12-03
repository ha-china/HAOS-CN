

## ⚠️ 重要提醒

### 📦 固件使用说明
- 🚫 **请勿错误的将测试版固件用于生产环境，测试版固件名称均包含`dev`**
---

### 🛡️ 服务器保护措施

由于近期服务器遭受大量无效流量（日均数万次无效请求），为保护服务器资源并降低运营成本，我们采取了以下措施：

- 🔒 **代码开源**：项目代码继续完全开源，遵循开源精神
- 🛡️ **构建保护**：隐藏构建过程包含服务器的相关信息，防止恶意（或无心）引用

---

##  ![Home Assistant OS 极速版](https://img.shields.io/badge/Home%20Assistant%20OS-%E6%9E%81%E9%80%9F%E7%89%88-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white) ![Home Assistant OS China](https://img.shields.io/badge/Home%20Assistant%20OS-China-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white) ![Home Assistant OS Turbo](https://img.shields.io/badge/Home%20Assistant%20OS-Turbo-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white)
### [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/ha-china/HAOS-CN) [`Changelog`](https://www.hasscn.top/Changelog.html)



**本系统是基于Home Assistant [官方仓库](https://github.com/home-assistant/operating-system)优化而来**

### 🚀 网络加速优化
- 🕵️‍♂️ `版本检测服务`迁移至国内腾讯BGP节点
- 🛡️ `系统网络检查`迁移至国内腾讯BGP节点
- ⏰ `时间同步服务器`迁移至国内公共节点
- 🏫 `镜像拉取服务`迁移至国内腾讯BGP节点
- 🔄 `OTA升级服务`迁移至国内腾讯BGP节点
- ⚡ `系统下载地址`优化至国内腾讯BGP节点
- 🐳 添加国内 [`docker.io`](https://github.com/dongyubin/DockerHub)镜像地址至系统
- 📨 `后台自动错误报告`服务迁移至国内腾讯BGP节点

---

### ⚙️ 系统配置优化
- 🕰️ 默认时区设置为 `Asia/Shanghai`
- 📅 系统更新频率调整为`每月28日`定期更新
- 📢 终端页面添加`服务器赞助信息`声明

---

### 📦 加载项优化
- ❌ 移除不稳定的 [`官方加载项源`](https://github.com/home-assistant/addons)
- ❌ 移除不稳定的 [`官方社区源`](https://github.com/hassio-addons/repository)
- ❌ 移除不稳定的 [`Music Assistant 源`](https://github.com/music-assistant/home-assistant-addon)
- ❌ 移除不稳定的 [`ESP Home 源`](https://github.com/esphome/home-assistant-addon)
- ✅ 添加经过全面优化与汉化的[`加载项源`](https://gitee.com/desmond_GT/hassio-addons/blob/main/README.md)为默认加载项源（上述移除内容均已包含在内）

---

### 🤖 智能安装体验
- 🚦 系统启动时**自动**检测网络并安装 ![](https://img.shields.io/badge/HACS-%E6%9E%81%E9%80%9F%E7%89%88-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white)
> 为了让更多人体验极速版，欢迎愿意共享 Token 的朋友[点击链接](https://tokenhub.hacs.vip/)共享

---

> 🚀 *专为中国用户优化加速的 Home Assistant OS*

- 🔧 保持系统原生体验，所有更改仅为提速优化以及合规性。
- 🛡️ **所有个人或者商家均可免费使用此产品（愿意赞助的朋友可以扫下面二维码）**
- 🛠️ 每月**27日**由 **GitHub Actions** 自动构建最新版。
- ⭐ 如果觉得有帮助，欢迎点个 Star 支持！

---

### 🚦 速度演示

- [初始化速度演示](https://www.bilibili.com/video/BV1tr7VzCE35/?share_source=copy_web&vd_source=9b5dc5e48277a13da484e0352d3707e9)  
  > 家庭宽带：1G约1~1.5分钟，500M约3分钟，100M约5分钟

- [升级速度演示](https://www.bilibili.com/video/BV1judBY2ES7?t=82.3)  
  > 升级速度与初始化类似

---



##  官方信息

- 🌐 官方网站：[https://www.hasscn.top](https://www.hasscn.top)

- 📱 官方公众号

<div align="left">
  <img src="./img/WeChat_QRCode.png" alt="关注我" width="400"/>
</div>

---

感谢您的关注与支持！如有疑问，欢迎随时联系我。

- **黑豹x2（panther_x2）** 适配来源：[https://github.com/jianyun8023/operating-system](https://github.com/jianyun8023/operating-system)
- **Sonoff iHost** 适配来源：[https://github.com/iHost-Open-Source-Project/ha-operating-system](https://github.com/iHost-Open-Source-Project/ha-operating-system)
- **Orangepi CM4** 适配来源：[https://github.com/hhuangpeiqi/home-assistant-OS](https://github.com/hhuangpeiqi/home-assistant-OS)
> 已验证硬件版本v1.3.1，确认v1.4的硬件版本无法使用
---





## ☕ 如果你觉得本项目对你有帮助

- 欢迎请我喝杯咖啡~


| 微信支持 | 支付宝支持 |
|----------|------------|
| ![微信](./img/WeChat_Pay.jpg) | ![支付宝](./img/Ali_Pay.jpg) |

> 名单公示在[此页面上](https://www.hasscn.top/sponsor.html#-%E7%89%B9%E5%88%AB%E9%B8%A3%E8%B0%A2)


感谢您的理解与支持！ 🙏

## 🖥️ 欢迎参与机型适配

🎉 首先，衷心感谢您愿意为 HAOS 贡献机型适配！为确保用户使用安全及系统稳定性，我们将对提交的代码进行严格审核，敬请理解。

⚠️ 因官方开始淘汰 arm32 架构的设备，原则上只接受 x86_64 和 aarch64 的设备适配，厂家设备可协商

## 📝 提交规范说明

为保持项目结构清晰，避免多机型编译时出现混乱，请遵循以下规范：

### 📂 目录结构要求
- 🗂️ **机型配置目录**  
  统一放置于 `buildroot-external\board\` 目录下  
  - 📍 直接放置，如：`board\orangepi_CM4`  
  - 🏷️ 按品牌分类，如：`board\orangepi\computer_model4`

- ⚙️ **编译配置文件**  
  所有 defconfig 文件请放入 `buildroot-external\config` 目录  
  示例：`orangepi_cm4_deconfig`

- 📦 **额外软件包**  
  如需添加额外软件包，请统一放置于 `packages` 目录下，并确保一个软件包对应一个独立目录

- ❓ **非指定目录文件**  
  提交的时候请一定说清楚原因

## ⚡ 重要注意事项
1. 🚫 禁止修改 HAOS 官方源文件及其他目录
2. 🚫 禁止创建非规范要求的额外目录
3. 🔍 对于存在疑问的代码，如果提交时描述不够清楚我可能将与您沟通确认其作用
4. ❌ 无法合理解释的代码将不予合并

🤝 我们期待与您共同打造更完善的 HAOS 生态！

🐛 如果用户对于您提交的固件有 bug 或者有疑问，还需要您在 issue 区帮忙回复，万分感谢！
