## ⚠️ Important Reminder

### 📦 Firmware Usage Instructions
- 🚫 **Do not use the test version firmware in production environments. All test firmware file names contain `dev`**
---

### 🛡️ Server Protection Measures

Due to a recent surge in invalid server traffic (tens of thousands of invalid requests daily), to protect server resources and reduce operational costs, we have adopted the following measures:

- 🔒 **Open Source Code**: The project code remains fully open source, upholding the open source spirit.
- 🛡️ **Build Protection**: Information related to the server is hidden during the build process to prevent malicious (or unintentional) referencing.
- 💰 **Cost Control**: Reduce invalid traffic and lower server operational costs.
- 🔐 **Security Protection**: Safeguard the server from malicious attacks.
---

##  ![Home Assistant OS Turbo Edition](https://img.shields.io/badge/Home%20Assistant%20OS-%E6%9E%81%E9%80%9F%E7%89%88-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white) ![Home Assistant OS China](https://img.shields.io/badge/Home%20Assistant%20OS-China-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white) ![Home Assistant OS Turbo](https://img.shields.io/badge/Home%20Assistant%20OS-Turbo-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white)
### [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/ha-china/HAOS-CN) [`Changelog`](https://www.hasscn.top/Changelog.html)

[English](README_EN.md) **Chinese**

**This system is an optimized version based on the Home Assistant [official repository](https://github.com/home-assistant/operating-system).**

### 🚀 Network Acceleration Optimization
- 🕵️‍♂️ `Version check service` migrated to China Mainland Tencent BGP node
- 🛡️ `System network check` migrated to China Mainland Tencent BGP node
- ⏰ `Time synchronization server` migrated to China Mainland public NTP server
- 🏫 `Image pull service` migrated to China Mainland Tencent BGP node
- 🔄 `OTA update service` migrated to China Mainland Tencent BGP node
- ⚡ `System download addresses` optimized to China Tencent BGP node
- 🐳 Added China Mainland [`docker.io`](https://github.com/dongyubin/DockerHub) mirror in the system
- 📨 `Automatic background error report` service migrated to China Mainland Tencent BGP node

---

### ⚙️ System Configuration Optimization
- 🕰️ Default time zone set to `Asia/Shanghai`
- 📅 System updates scheduled regularly on the 28th of every month
- 📢 Server sponsorship info statement added to terminal page

---

### 📦 Add-ons Optimization
- ❌ Removed unstable [`Official Add-ons`](https://github.com/home-assistant/addons) source
- ❌ Removed unstable [`Official Community`](https://github.com/hassio-addons/repository) source
- ❌ Removed unstable [`Music Assistant`](https://github.com/music-assistant/home-assistant-addon) source
- ❌ Removed unstable [`ESP Home`](https://github.com/esphome/home-assistant-addon) source
- ✅ Added a comprehensively optimized and localized [`Add-ons source`](https://gitee.com/desmond_GT/hassio-addons/blob/main/README.md) as the default add-ons source (includes the above removals)

---

### 🤖 Smart Installation Experience
- 🚦 On system startup, **automatically** detects network and installs ![](https://img.shields.io/badge/HACS-%E6%9E%81%E9%80%9F%E7%89%88-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white)
> To let more users experience the Turbo Edition, friends willing to share a Token are invited to [share here](https://tokenhub.hacs.vip/)

---

> 🚀 *A Home Assistant OS optimized and accelerated specifically for users in China*

- 🔧 Maintains the native system experience, all changes are only for acceleration and compliance.
- 🛡️ **All individuals or businesses may use this product for free (if you wish to sponsor, please scan the QR code below)**
- 🛠️ The latest version is built **automatically on the 27th of each month** by **GitHub Actions**
- ⭐ If you find it helpful, please give it a Star!

---

### 🚦 Speed Demonstration

- [Initialization Speed Demo](https://www.bilibili.com/video/BV1tr7VzCE35/?share_source=copy_web&vd_source=9b5dc5e48277a13da484e0352d3707e9)  
  > Home broadband: 1G about 1~1.5 minutes, 500M about 3 minutes, 100M about 5 minutes

- [Upgrade Speed Demo](https://www.bilibili.com/video/BV1judBY2ES7?t=82.3)  
  > Upgrade speed is similar to initialization

---



## Official Information

- 🌐 Official Website: [https://www.hasscn.top](https://www.hasscn.top)

- 📱 Official WeChat Public Account

<div align="left">
  <img src="./img/WeChat_QRCode.png" alt="Follow me" width="400"/>
</div>

---

Thank you for your attention and support! If you have any questions, feel free to contact me at any time.

- **Panther x2 (panther_x2)** adaptation source: [https://github.com/jianyun8023/operating-system](https://github.com/jianyun8023/operating-system)
- **Sonoff iHost** adaptation source: [https://github.com/iHost-Open-Source-Project/ha-operating-system](https://github.com/iHost-Open-Source-Project/ha-operating-system)
- **Orangepi CM4 (v1.3.1)** adaptation source: [https://github.com/hhuangpeiqi/home-assistant-OS](https://github.com/hhuangpeiqi/home-assistant-OS)
> Hardware version v1.3.1 has been verified, version v1.4 is not supported
---





## ☕ If you find this project useful

- Feel free to buy me a coffee~


| WeChat Support | Alipay Support |
|----------|------------|
| ![WeChat](./img/WeChat_Pay.jpg) | ![Alipay](./img/Ali_Pay.jpg) |

> Sponsorship list is published [on this page](https://www.hasscn.top/sponsor.html#-%E7%89%B9%E5%88%AB%E9%B8%A3%E8%B0%A2)


Thank you for your understanding and support! 🙏

## 🖥️ Device Adaptation Contributions Welcome

🎉 First of all, heartfelt thanks for your willingness to contribute device adaptations to HAOS! To ensure user safety and system stability, we will strictly review all submitted code. Thanks for your understanding.

⚠️ Since the official team has started phasing out arm32 architecture devices, in principle only x86_64 and aarch64 device adaptations are accepted, device manufacturers can discuss exceptions.

## 📝 Submission Guidelines

To keep the project structure clear and avoid confusion when compiling for multiple devices, please follow these guidelines:

### 📂 Directory Structure Requirements
- 🗂️ **Device configuration directories**  
  Place them uniformly under `buildroot-external\board\`  
  - 📍 Place directly, e.g.: `board\orangepi_CM4`  
  - 🏷️ Brand categorization, e.g.: `board\orangepi\computer_model4`

- ⚙️ **Build configuration files**  
  All defconfig files must be placed in `buildroot-external\config`  
  Example: `orangepi_cm4_deconfig`

- 📦 **Additional packages**  
  If you need to add additional packages, please place them uniformly in the `packages` directory, and ensure one folder per package

- ❓ **Files outside designated directories**  
  Please clearly state the reason when submitting

## ⚡ Important Notes
1. 🚫 It is forbidden to modify HAOS official source files or other directories
2. 🚫 It is forbidden to create extra directories not specified by the requirements
3. 🔍 If there is any question about your code and the submission description is not clear enough, I may contact you for clarification
4. ❌ Code that cannot be reasonably explained will not be merged

🤝 We look forward to working with you to build a better HAOS ecosystem!

🐛 If there are bugs or questions about the firmware you submit, please help respond in the issue area. Thank you very much!
