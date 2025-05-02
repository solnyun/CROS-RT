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
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_1 -p 10 -st topic231_0_0 -pt topic231_0_1 -u 0.0033866452893862586 > ./result_8chains/node231_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_1 -p 38 -st topic231_1_0 -pt topic231_1_1 -u 0.0003541167671086143 > ./result_8chains/node231_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_1 -p 126 -st topic231_2_0 -pt topic231_2_1 -u 0.002754794956289386 > ./result_8chains/node231_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_1 -p 127 -st topic231_3_0 -pt topic231_3_1 -u 0.030215316979963436 > ./result_8chains/node231_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_4_1 -p 262 -st topic231_4_0 -pt topic231_4_1 -u 0.006651456049862781 > ./result_8chains/node231_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_5_1 -p 280 -st topic231_5_0 -pt topic231_5_1 -u 0.048370967609567425 > ./result_8chains/node231_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_6_1 -p 345 -st topic231_6_0 -pt topic231_6_1 -u 0.005811862598897634 > ./result_8chains/node231_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_7_1 -p 502 -st topic231_7_0 -pt topic231_7_1 -u 0.03272679180451716 > ./result_8chains/node231_7_1.txt &
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
    "./result_8chains/node231_0_1.txt 90"
    "./result_8chains/node231_1_1.txt 89"
    "./result_8chains/node231_2_1.txt 88"
    "./result_8chains/node231_3_1.txt 87"
    "./result_8chains/node231_4_1.txt 86"
    "./result_8chains/node231_5_1.txt 85"
    "./result_8chains/node231_6_1.txt 84"
    "./result_8chains/node231_7_1.txt 83"
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
