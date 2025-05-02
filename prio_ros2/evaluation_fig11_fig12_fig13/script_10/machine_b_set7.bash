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
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_1 -p 25 -st topic7_0_0 -pt topic7_0_1 -u 0.04817636183751728 > ./result_10chains/node7_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_1 -p 115 -st topic7_1_0 -pt topic7_1_1 -u 0.005371831119147907 > ./result_10chains/node7_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_1 -p 236 -st topic7_2_0 -pt topic7_2_1 -u 0.04568600171243831 > ./result_10chains/node7_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_1 -p 267 -st topic7_3_0 -pt topic7_3_1 -u 0.0023350731237694045 > ./result_10chains/node7_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_1 -p 273 -st topic7_4_0 -pt topic7_4_1 -u 0.042311821548077305 > ./result_10chains/node7_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_1 -p 331 -st topic7_5_0 -pt topic7_5_1 -u 0.005627194455834733 > ./result_10chains/node7_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_6_1 -p 471 -st topic7_6_0 -pt topic7_6_1 -u 0.000109547457856074 > ./result_10chains/node7_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_7_1 -p 670 -st topic7_7_0 -pt topic7_7_1 -u 0.013493750056615336 > ./result_10chains/node7_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_8_1 -p 742 -st topic7_8_0 -pt topic7_8_1 -u 0.0010029363430753002 > ./result_10chains/node7_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node7_9_1 -p 820 -st topic7_9_0 -pt topic7_9_1 -u 0.0005893193687499746 > ./result_10chains/node7_9_1.txt &
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
    "./result_10chains/node7_0_1.txt 90"
    "./result_10chains/node7_1_1.txt 89"
    "./result_10chains/node7_2_1.txt 88"
    "./result_10chains/node7_3_1.txt 87"
    "./result_10chains/node7_4_1.txt 86"
    "./result_10chains/node7_5_1.txt 85"
    "./result_10chains/node7_6_1.txt 84"
    "./result_10chains/node7_7_1.txt 83"
    "./result_10chains/node7_8_1.txt 82"
    "./result_10chains/node7_9_1.txt 81"
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
