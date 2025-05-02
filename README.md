# CROS-RT: Cross-Layer Priority Scheduling for Predictable Inter-Process Communication in ROS 2

This repository provides the code and resources used in the research on CROS-RT.

## Authors
- Sohyun Kim
- Juho Song
- Sangeun Oh
- Kilho Lee
- Hoon Sung Chwa

## Requirements

The following components are required before using this repository:

- **Ubuntu 22.04**
- **ROS2 Humble** with eProsima’s **FastDDS**
- **Linux Kernel 5.15**

### 1. Install ROS2 Humble

To install ROS2 Humble, follow the official installation guide and make sure to use the **Building from Source** method:
[ROS2 Humble Installation Guide](https://docs.ros.org/en/humble/Installation.html)

### 2. Kernel Installation on Orin Nano

To install the kernel on the NVIDIA Orin Nano, follow these steps:

##### Step 1: Download the kernel sources

- First, verify the version of the source on the device. A mismatch in the kernel version can lead to issues such as SSH working but no display output.

```bash
cat /etc/nv_tegra_release
```

- In a browser, navigate to the [NVIDIA Developer Linux for Tegra](https://developer.nvidia.com/embedded/jetson-linux-archive) page. Download the **L4T Sources** for your release.

- Use the following commands to download and extract the sources:

```bash
wget https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v2.0/sources/public_sources.tbz2
tar -xvf public_sources.tbz2
cd Linux_for_Tegra/source
tar -xvf kernel_src.tbz2
```

##### Step 2: Get the configuration file from the running Linux kernel

```bash
cd kernel/kernel-jammy-src
zcat /proc/config.gz > .config
```

##### Step 3: Compile the kernel

```bash
make menuconfig
make prepare && make modules_prepare && make -j6 Image && make -j6 modules
```

- If you encounter an error during `make menuconfig`, install the required tools:

```bash
sudo apt-get update
sudo apt-get install libncurses5-dev libncursesw5-dev
```

##### Step 4: Install the kernel

```bash
sudo make modules_install && sudo cp arch/arm64/boot/Image /boot/Image
```

##### Step 5: Reboot

```bash
sudo reboot
```

### 3. Install NTP

To synchronize the system time between two machines on the same network:

##### Machine 1 (Server Machine)

1. Install the NTP package:

```bash
sudo apt-get install ntp
```

2. Modify the NTP configuration file:

   - For example, assume the NTP server's IP address is `192.168.0.12`, and the other machines on the network have IP addresses in the range `192.168.0.1` to `192.168.0.255`.

```bash
sudo su
vim /etc/ntp.conf
```

```bash
# Specify the local network address and subnet mask
restrict 192.168.0.0 mask 255.255.255.0

# Allow other machines on the network to synchronize with this server
broadcast 192.168.0.255
```

3. Restart the NTP service:

```bash
sudo systemctl restart ntp
```

##### Machine 2

1. Install the NTP package:

```bash
sudo apt-get install ntp
```

2. Modify the NTP configuration file to specify the NTP server:

```bash
sudo su
vim /etc/ntp.conf
```

```bash
server 192.168.0.12
```

3. Restart the NTP service:

```bash
sudo systemctl restart ntp
```

## How to use?
```bash
git init
git remote add origin https://github.com/solnyun/CROS-RT.git
git remote -v
git fetch --all
git reset --hard origin/main
git pull origin main
```
