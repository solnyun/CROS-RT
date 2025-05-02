## Experiment Setup
This experiment follows the same setup as **motivation_1_fig2a**.

### How to Run the Experiment
Enable the `ksoftirqd` Thread for Detailed Results
Before starting the experiment, enable the `ksoftirqd` thread as follows:
```bash
echo 1 > /sys/module/softirq/parameters/ksoftirqd_test
```

##### Machine 1 (orin1): Direct Access Required (No SSH)
> Note: KernelShark requires direct access; do not use SSH.

1. **Pre-Execution**: Restrict `subscriber` to a single CPU core.
   ```bash
   cd prio_ros2
   bash start.bash
   ```
2. **Execution**: Packet size is not specified for this experiment.
   ```bash
   cd motivation_2
   bash motivation_1_sub.bash 2 0
   ```
3. **KernelShark Setup**:
   - Open a new terminal and run:
     ```bash
     kernelshark
     ```
   - Configure KernelShark:
     1. Go to `Tools > Record`.
     2. Select **All Events**.
     3. Set the command to:
        ```bash
        sleep 100
        ```

---

##### Machine 2 (orin2): Allow All CPU Cores for the `publisher`
1. **Pre-Execution**: Ensure full CPU access for the `publisher`.
   ```bash
   cd prio_ros2
   bash start.bash
   bash end.bash
   ```
2. **Execution**: Packet size is not specified for this experiment.
   ```bash
   cd motivation_2
   bash motivation_1_pub.bash 2 0
   ```

---

### Machine 3 (v22): Open KernelShark Results
1. Use a high-performance machine to analyze the KernelShark results.
2. Transfer the trace data file from `orin1`:
   ```bash
   scp orin1@XXX.XXX.XXX.XXX:/home/orin1/prio_ros2/motivation_2/trace.dat ./
   ```
3. Open the file in KernelShark:
   ```bash
   kernelshark trace.dat
   ```

### Experiment Results
- **When `ksoftirqd` is disabled**:
  Results are saved in `irq_trace.dat`.

- **When `ksoftirqd` is enabled**:
  Results are saved in `ksoftirqd_trace.dat`.

