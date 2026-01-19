[中文说明, 请点击这里](README_CN.md)  
---

## ⚠️ Important Notice

### 📦 Firmware Usage Guidelines
- 🚫 **Do NOT use test versions of firmware in production environments. All test firmware filenames contain `dev`.**

- 🎯 **Purpose of This Project:**  
  Designed to allow Chinese users to seamlessly enjoy the native Home Assistant OS experience without worrying about network accessibility issues.

---

### 🛡️ Server Protection Measures

Due to a recent surge of excessive invalid server requests (up to tens of thousands daily), to protect server resources and reduce operational costs, we've implemented the following strategies:

- 🔒 **Open Source Commitment**: Project source code remains fully open, adhering strictly to the open source spirit.
- 🛡️ **Build Information Protection**: Server-related information is concealed during the build process to prevent malicious or unintentional reference.

---

##  ![Home Assistant OS Turbo Edition](https://img.shields.io/badge/Home%20Assistant%20OS-%E6%9E%81%E9%80%9F%E7%89%88-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white) ![Home Assistant OS China](https://img.shields.io/badge/Home%20Assistant%20OS-China-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white) ![Home Assistant OS Turbo](https://img.shields.io/badge/Home%20Assistant%20OS-Turbo-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white)
### [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/ha-china/HAOS-CN) [`Changelog`](https://www.hasscn.top/Changelog.html)


**This system is an optimized Home Assistant OS distribution, tailored specifically for users in China and based on the [official Home Assistant repository](https://github.com/home-assistant/operating-system).**

### 🚀 Network Speed-Up Optimizations
- 🕵️‍♂️ `Version check service` relocated to a Tencent BGP node in China
- 🛡️ `System connectivity check` migrated to a China Tencent BGP node
- ⏰ `Time synchronization server` switched to Mainland China public NTP servers
- 🏫 `Image download service` uses Tencent BGP node in China
- 🔄 `OTA update service` migrated to China Tencent BGP node
- ⚡ `System download URLs` optimized for China through Tencent BGP
- 🐳 Integrated Mainland China [`docker.io`](https://github.com/dongyubin/DockerHub) mirror into the system
- 📨 `Automatic error reporting service` now running via China Tencent BGP node

---

### ⚙️ System Configuration Enhancements
- 🕰️ Default time zone set to `Asia/Shanghai`
- 📅 System automatically updates on the 28th of each month
- 📢 Terminal page now displays server sponsorship information

---

### 📦 Add-ons Optimization
- ❌ Removed unstable [`Official Add-ons`](https://github.com/home-assistant/addons) repository
- ❌ Removed unstable [`Official Community`](https://github.com/hassio-addons/repository) repository
- ❌ Removed unstable [`Music Assistant`](https://github.com/music-assistant/home-assistant-addon) repository
- ❌ Removed unstable [`ESP Home`](https://github.com/esphome/home-assistant-addon) repository
- ✅ Added a fully optimized and localized [`Add-ons source`](https://gitee.com/desmond_GT/hassio-addons/blob/main/README.md) as the default add-ons repository (including all of the above removals)

---

### 🤖 Intelligent Installation Experience
- 🚦 On system startup, **automatically** detects the network and installs ![HACS-China](https://img.shields.io/badge/HACS-China-41BDF5?style=for-the-badge&logo=home-assistant&logoColor=white)
> To help more users experience Turbo Edition, friends willing to share a Token are welcome to [share here](https://tokenhub.hacs.vip/)

---

> 🚀 *A Home Assistant OS specifically optimized and accelerated for users in China*

- 🔧 Maintains the official system experience; all adjustments are solely for acceleration and compliance.
- 🛡️ **Free for all individuals and businesses (if you'd like to support the project, please scan the QR code below!)**
- 🛠️ The newest version is automatically built **on the 27th of every month** by **GitHub Actions**
- ⭐ If you find this helpful, please consider giving the project a Star!

---

### 🚦 Speed Demonstration

- [Initialization Speed Demonstration](https://www.bilibili.com/video/BV1tr7VzCE35/?share_source=copy_web&vd_source=9b5dc5e48277a13da484e0352d3707e9)  
  > Download Bandwidth: 1Gbps about 1~1.5 minutes, 500Mbps around 3 minutes, 100Mbps about 5 minutes

- [Upgrade Speed Demonstration](https://www.bilibili.com/video/BV1judBY2ES7?t=82.3)  
  > Upgrade speed is similar to initialization


---

Thank you for your attention and support! If you have any questions, feel free to reach out anytime.

- **Panther x2 (panther_x2)** adaptation source: [https://github.com/jianyun8023/operating-system](https://github.com/jianyun8023/operating-system)
- **Sonoff iHost** adaptation source: [https://github.com/iHost-Open-Source-Project/ha-operating-system](https://github.com/iHost-Open-Source-Project/ha-operating-system)
- **Orangepi CM4** adaptation source: [https://github.com/hhuangpeiqi/home-assistant-OS](https://github.com/hhuangpeiqi/home-assistant-OS)
> Hardware version v1.3.1 is verified; version v1.4 is not supported.
---


Thank you again for your understanding and support! 🙏

## 🖥️ Device Adaptation Contributions Welcome

🎉 Thank you for your willingness to contribute device adaptations to HAOS! To ensure user safety and system stability, all submitted code will be carefully reviewed. Thank you for your cooperation.

⚠️ As the official team is gradually phasing out devices with arm32 architecture, only x86_64 and aarch64 device adaptations are generally accepted (device manufacturers may discuss exceptions).

## 📝 PR Submission Guidelines

To keep the project structure organized and ensure smooth multi-device compilations, please adhere to these guidelines:

### 📂 Directory Structure Requirements
- 🗂️ **Device configuration directories**  
  Place them under `buildroot-external\board\`  
  - 📍 Direct placement, e.g.: `board\orangepi_CM4`  
  - 🏷️ Brand subdirectory, e.g.: `board\orangepi\computer_model4`

- ⚙️ **Build configuration files**  
  Place all defconfig files in `buildroot-external\config`  
  Example: `orangepi_cm4_deconfig`

- 📦 **Additional packages**  
  Any extra packages should be added to the `packages` directory, one folder per package

- ❓ **For files outside these directories**  
  Please provide clear reasons in your submission

## ⚡ Important Reminders
1. 🚫 Do NOT edit HAOS official source files or other directories
2. 🚫 Do NOT create directories outside those specified above
3. 🔍 If there are questions regarding your code or your PR lacks sufficient description, you may be contacted for clarification
4. ❌ Code submissions that cannot be reasonably explained will not be merged

🤝 We look forward to building a better HAOS ecosystem in China together!

🐛 If there are bugs or questions about the firmware you submit, please help respond in the issues area. Thank you very much!

---


## Official Information

- 🌐 Official Website: [https://www.hasscn.top](https://www.hasscn.top)

- 📱 Official WeChat Public Account

<div align="left">
  <img src="./img/WeChat_QRCode.png" alt="Follow me" width="400"/>
</div>


## ☕ If you find this project helpful

- Feel free to buy me a coffee~


| WeChat | Alipay |
|--------|--------|
| ![WeChat](./img/WeChat_Pay.jpg) | ![Alipay](./img/Ali_Pay.jpg) |

> The donor list is published [on this page](https://www.hasscn.top/sponsor.html#-%E7%89%B9%E5%88%AB%E9%B8%A3%E8%B0%A2)
