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
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_1 -p 100 -st topic177_0_0 -pt topic177_0_1 -u 0.006125947672788068 > ./result_10chains/node177_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_1 -p 164 -st topic177_1_0 -pt topic177_1_1 -u 0.006104088516018125 > ./result_10chains/node177_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_1 -p 194 -st topic177_2_0 -pt topic177_2_1 -u 0.015893756406213044 > ./result_10chains/node177_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_1 -p 216 -st topic177_3_0 -pt topic177_3_1 -u 0.004697597920000934 > ./result_10chains/node177_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_1 -p 730 -st topic177_4_0 -pt topic177_4_1 -u 0.007261913195798775 > ./result_10chains/node177_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_1 -p 781 -st topic177_5_0 -pt topic177_5_1 -u 0.03258312919229234 > ./result_10chains/node177_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_6_1 -p 899 -st topic177_6_0 -pt topic177_6_1 -u 0.020543130201872567 > ./result_10chains/node177_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_7_1 -p 927 -st topic177_7_0 -pt topic177_7_1 -u 0.03964235873417881 > ./result_10chains/node177_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_8_1 -p 957 -st topic177_8_0 -pt topic177_8_1 -u 0.003999144972329165 > ./result_10chains/node177_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_9_1 -p 971 -st topic177_9_0 -pt topic177_9_1 -u 0.006662129211320396 > ./result_10chains/node177_9_1.txt &
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
    "./result_10chains/node177_0_1.txt 90"
    "./result_10chains/node177_1_1.txt 89"
    "./result_10chains/node177_2_1.txt 88"
    "./result_10chains/node177_3_1.txt 87"
    "./result_10chains/node177_4_1.txt 86"
    "./result_10chains/node177_5_1.txt 85"
    "./result_10chains/node177_6_1.txt 84"
    "./result_10chains/node177_7_1.txt 83"
    "./result_10chains/node177_8_1.txt 82"
    "./result_10chains/node177_9_1.txt 81"
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
