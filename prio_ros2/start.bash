#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Set CPU frequency scaling governor to performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Restart ntp service
sudo systemctl restart ntp

# Turn off CPU cores 1 to 11
for i in {1..5}
do
   echo 0 | sudo tee /sys/devices/system/cpu/cpu$i/online
done

# Restart ntp service again
sudo systemctl restart ntp

# Check the status of ntp
ntp_status=$(sudo systemctl status ntp | grep 'active (running)')

if [ -z "$ntp_status" ]; then
    echo "Failed to restart ntp service."
    exit 1
else
    echo "ntp service restarted successfully."
fi

#: << "END"
# Move to the specified directory
cd /home/orin5/Linux_for_Tegra/source/kernel/kernel-jammy-src/ros2_framework

# Insert the module
sudo insmod rt_handler.ko
sudo insmod non_rt_bg.ko

# Wait for the module to fully load and the thread to start
sleep 5

# Get the PID of the 'krtd' thread
kmond_pid=$(pgrep kmond)
krtd_pid=$(pgrep krtd)
knonrtd_pid=$(pgrep knonrtd)

# Check if the PID was found
if [ -z "$kmond_pid" ]; then
    echo "Could not find the PID of 'kmond' thread"
    exit 1
fi

if [ -z "$krtd_pid" ]; then
    echo "Could not find the PID of 'krtd' thread"
    exit 1
fi


if [ -z "$knonrtd_pid" ]; then
    echo "Could not find the PID of 'knonrtd' thread"
    exit 1
fi

# Write the PID to the module parameter
echo $kmond_pid | sudo tee /sys/module/r8169/parameters/kmond_pid > /dev/null
echo $krtd_pid | sudo tee /sys/module/r8169/parameters/krtd_pid > /dev/null
echo $knonrtd_pid | sudo tee /sys/module/r8169/parameters/knonrtd_pid > /dev/null

echo "PID of 'kmond' ($kmond_pid) written to /sys/module/r8169/parameters/kmond_pid"
echo "PID of 'krtd' ($krtd_pid) written to /sys/module/r8169/parameters/knonrtd_pid"
echo "PID of 'knonrtd' ($knonrtd_pid) written to /sys/module/r8169/parameters/knonrtd_pid"

echo "1" | sudo tee /sys/module/r8169/parameters/krtd_on > /dev/null
echo "Change krtd_on 0 to 1"
#END
