#!/bin/bash
# Automation script (run on orin5)
# For each iteration (0 to 500):
# 1. Execute machine_a_set<number>.bash locally.
# 2. When "End Priority Assignment" is detected, SSH into orin2 to execute machine_b_set<number>.bash.
# 3. After that, execute wait_signal and send_signal, restore terminal settings, and sleep for 5 seconds 
#    to ensure both machines have fully completed execution.

#for i in $(seq 31 50); do
for i in 33; do
    echo "===== Starting iteration $i ====="
    
    # Set up a temporary log file for the current iteration.
    OUTPUT_LOG="/tmp/machine_a_output_${i}.log"
    rm -f "$OUTPUT_LOG"
    touch "$OUTPUT_LOG"
    
    # Run machine_a_set<number>.bash locally.
    echo "Start machine_a_set${i}.bash..."
    stdbuf -oL bash script_10/machine_a_set${i}.bash framework no | tee "$OUTPUT_LOG" &
    SCRIPT_PID=$!
    
    # Monitor for "End Priority Assignment" in the log.
    while true; do
        if grep -q "End Priority Assignment" "$OUTPUT_LOG"; then
            echo "==> 'End Priority Assignment' detected for iteration ${i}."
            # Construct remote command to run machine_b_set<number>.bash on orin2.
            REMOTE_CMD="source /home/orin2/ros2_humble/install/setup.bash && \
                        source /home/orin2/prio_ros2/install/setup.bash && \
                        cd /home/orin2/prio_ros2/evaluation_2_fig10 && \
                        bash script_10/machine_b_set${i}.bash vanilla no"
            
            sshpass -p 'orin2' ssh -t root@192.168.0.21 "$REMOTE_CMD" | tee -a "$OUTPUT_LOG" &
            break
        fi
        sleep 1
    done

    # Execute wait_signal and send_signal commands.
    ./wait_signal 127.0.0.1 9999
    ./send_signal 192.168.0.21 9797

    # Restore terminal settings and wait for 5 seconds to ensure everything is complete.
    stty sane
    sleep 10

    echo "===== Finished iteration $i ====="
done

