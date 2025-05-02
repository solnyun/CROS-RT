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

- **NVIDIA Jetson Orin Nano**
- **Ubuntu 22.04**
- **ROS2 Humble** with eProsima’s **FastDDS**
- **Linux Kernel 5.15**

Please refer to the following resources:

- [ROS2 Humble Installation Guide](https://docs.ros.org/en/humble/Installation.html)
- [NVIDIA Developer Linux for Tegra](https://developer.nvidia.com/embedded/jetson-linux-archive)


## Code Organization

CROS-RT is organized into the following parts:

- **Cross-Layer Components** (located in `ros2_framework`):
  Includes cross-layer priority identifier, RT handler, and Non-RT handler kernel modules.

- **Message Selector** (located in `r8169_main.c`):
  A kernel-level component integrated in the network driver.

- **Thread Mapping Info** (provided in `ros2_humble`):
  Shows how application, DDS, and kernel threads are organized across layers.

### Cross-Layer Components

The `ros2_framework` directory contains kernel modules for:

- Cross-layer Priority Identifier  
- RT Handler  
- Non-RT Handler  

These modules are implemented separately and must be loaded using `insmod` before running experiments.

To load all required modules at once, execute:

```bash
cd prio_ros2
./start.bash
```

