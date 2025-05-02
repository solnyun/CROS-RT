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
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_1 -p 43 -st topic67_0_0 -pt topic67_0_1 -u 0.0012495467715045172 > ./result_10chains/node67_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_1 -p 124 -st topic67_1_0 -pt topic67_1_1 -u 0.02026662856490319 > ./result_10chains/node67_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_1 -p 374 -st topic67_2_0 -pt topic67_2_1 -u 0.02860692316777086 > ./result_10chains/node67_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_1 -p 444 -st topic67_3_0 -pt topic67_3_1 -u 0.03272456494781617 > ./result_10chains/node67_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_1 -p 471 -st topic67_4_0 -pt topic67_4_1 -u 0.06047289287831384 > ./result_10chains/node67_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_1 -p 518 -st topic67_5_0 -pt topic67_5_1 -u 0.02022860357157355 > ./result_10chains/node67_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_6_1 -p 644 -st topic67_6_0 -pt topic67_6_1 -u 0.02434149642306785 > ./result_10chains/node67_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_7_1 -p 661 -st topic67_7_0 -pt topic67_7_1 -u 0.0027946565441658577 > ./result_10chains/node67_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_8_1 -p 947 -st topic67_8_0 -pt topic67_8_1 -u 0.0015880314001064516 > ./result_10chains/node67_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_9_1 -p 951 -st topic67_9_0 -pt topic67_9_1 -u 0.022115264297928275 > ./result_10chains/node67_9_1.txt &
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
    "./result_10chains/node67_0_1.txt 90"
    "./result_10chains/node67_1_1.txt 89"
    "./result_10chains/node67_2_1.txt 88"
    "./result_10chains/node67_3_1.txt 87"
    "./result_10chains/node67_4_1.txt 86"
    "./result_10chains/node67_5_1.txt 85"
    "./result_10chains/node67_6_1.txt 84"
    "./result_10chains/node67_7_1.txt 83"
    "./result_10chains/node67_8_1.txt 82"
    "./result_10chains/node67_9_1.txt 81"
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
