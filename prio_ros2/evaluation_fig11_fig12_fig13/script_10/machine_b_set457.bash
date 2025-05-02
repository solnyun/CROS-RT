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
ros2 run evaluation_3_randomdag uunifast_node -n node457_0_1 -p 103 -st topic457_0_0 -pt topic457_0_1 -u 0.05420507840894956 > ./result_10chains/node457_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_1_1 -p 133 -st topic457_1_0 -pt topic457_1_1 -u 0.02359368326767247 > ./result_10chains/node457_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_2_1 -p 154 -st topic457_2_0 -pt topic457_2_1 -u 0.0011384688346582905 > ./result_10chains/node457_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_3_1 -p 442 -st topic457_3_0 -pt topic457_3_1 -u 0.0026631358270965966 > ./result_10chains/node457_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_4_1 -p 531 -st topic457_4_0 -pt topic457_4_1 -u 0.02468039316338927 > ./result_10chains/node457_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_5_1 -p 543 -st topic457_5_0 -pt topic457_5_1 -u 0.015955207380511788 > ./result_10chains/node457_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_6_1 -p 587 -st topic457_6_0 -pt topic457_6_1 -u 0.008186970700040652 > ./result_10chains/node457_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_7_1 -p 655 -st topic457_7_0 -pt topic457_7_1 -u 0.01400600909391464 > ./result_10chains/node457_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_8_1 -p 679 -st topic457_8_0 -pt topic457_8_1 -u 0.008912375370940265 > ./result_10chains/node457_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node457_9_1 -p 879 -st topic457_9_0 -pt topic457_9_1 -u 0.04686605906257483 > ./result_10chains/node457_9_1.txt &
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
    "./result_10chains/node457_0_1.txt 90"
    "./result_10chains/node457_1_1.txt 89"
    "./result_10chains/node457_2_1.txt 88"
    "./result_10chains/node457_3_1.txt 87"
    "./result_10chains/node457_4_1.txt 86"
    "./result_10chains/node457_5_1.txt 85"
    "./result_10chains/node457_6_1.txt 84"
    "./result_10chains/node457_7_1.txt 83"
    "./result_10chains/node457_8_1.txt 82"
    "./result_10chains/node457_9_1.txt 81"
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
