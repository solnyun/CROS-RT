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
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_1 -p 204 -st topic253_0_0 -pt topic253_0_1 -u 0.0008411099203519123 > ./result_10chains/node253_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_1 -p 293 -st topic253_1_0 -pt topic253_1_1 -u 0.030321127122802993 > ./result_10chains/node253_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_1 -p 451 -st topic253_2_0 -pt topic253_2_1 -u 0.021694506628653465 > ./result_10chains/node253_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_1 -p 498 -st topic253_3_0 -pt topic253_3_1 -u 0.02981587504433575 > ./result_10chains/node253_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_1 -p 517 -st topic253_4_0 -pt topic253_4_1 -u 0.008174374003793505 > ./result_10chains/node253_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_1 -p 579 -st topic253_5_0 -pt topic253_5_1 -u 0.021143035140347682 > ./result_10chains/node253_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_6_1 -p 692 -st topic253_6_0 -pt topic253_6_1 -u 0.002256088880163265 > ./result_10chains/node253_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_7_1 -p 703 -st topic253_7_0 -pt topic253_7_1 -u 0.06906905384137321 > ./result_10chains/node253_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_8_1 -p 748 -st topic253_8_0 -pt topic253_8_1 -u 0.029037443185356768 > ./result_10chains/node253_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_9_1 -p 962 -st topic253_9_0 -pt topic253_9_1 -u 0.02029205680626718 > ./result_10chains/node253_9_1.txt &
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
    "./result_10chains/node253_0_1.txt 90"
    "./result_10chains/node253_1_1.txt 89"
    "./result_10chains/node253_2_1.txt 88"
    "./result_10chains/node253_3_1.txt 87"
    "./result_10chains/node253_4_1.txt 86"
    "./result_10chains/node253_5_1.txt 85"
    "./result_10chains/node253_6_1.txt 84"
    "./result_10chains/node253_7_1.txt 83"
    "./result_10chains/node253_8_1.txt 82"
    "./result_10chains/node253_9_1.txt 81"
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
