#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_1 -p 119 -st topic337_0_0 -pt topic337_0_1 -u 0.015492477852314057 > ./result_10chains/node337_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_1 -p 147 -st topic337_1_0 -pt topic337_1_1 -u 0.016188901119820853 > ./result_10chains/node337_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_1 -p 171 -st topic337_2_0 -pt topic337_2_1 -u 0.02678421775167611 > ./result_10chains/node337_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_1 -p 365 -st topic337_3_0 -pt topic337_3_1 -u 0.0026101657224245622 > ./result_10chains/node337_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_1 -p 664 -st topic337_4_0 -pt topic337_4_1 -u 0.0040054354464425235 > ./result_10chains/node337_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_1 -p 783 -st topic337_5_0 -pt topic337_5_1 -u 0.001318880684135243 > ./result_10chains/node337_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_6_1 -p 838 -st topic337_6_0 -pt topic337_6_1 -u 0.00486137886518237 > ./result_10chains/node337_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_7_1 -p 851 -st topic337_7_0 -pt topic337_7_1 -u 0.020427155316194448 > ./result_10chains/node337_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_8_1 -p 904 -st topic337_8_0 -pt topic337_8_1 -u 0.004008402307902153 > ./result_10chains/node337_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_9_1 -p 915 -st topic337_9_0 -pt topic337_9_1 -u 0.004296666517176608 > ./result_10chains/node337_9_1.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_10chains/node337_0_1.txt 90"
    "./result_10chains/node337_1_1.txt 89"
    "./result_10chains/node337_2_1.txt 88"
    "./result_10chains/node337_3_1.txt 87"
    "./result_10chains/node337_4_1.txt 86"
    "./result_10chains/node337_5_1.txt 85"
    "./result_10chains/node337_6_1.txt 84"
    "./result_10chains/node337_7_1.txt 83"
    "./result_10chains/node337_8_1.txt 82"
    "./result_10chains/node337_9_1.txt 81"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
