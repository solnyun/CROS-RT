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
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_1 -p 90 -st topic273_0_0 -pt topic273_0_1 -u 0.009145511494998648 > ./result_10chains/node273_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_1 -p 309 -st topic273_1_0 -pt topic273_1_1 -u 0.0036168605191961856 > ./result_10chains/node273_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_1 -p 409 -st topic273_2_0 -pt topic273_2_1 -u 0.04234848025336274 > ./result_10chains/node273_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_1 -p 467 -st topic273_3_0 -pt topic273_3_1 -u 0.017836122366825857 > ./result_10chains/node273_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_1 -p 475 -st topic273_4_0 -pt topic273_4_1 -u 0.012234312174521172 > ./result_10chains/node273_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_1 -p 612 -st topic273_5_0 -pt topic273_5_1 -u 0.0028541810224436415 > ./result_10chains/node273_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_6_1 -p 674 -st topic273_6_0 -pt topic273_6_1 -u 0.0076510235981669394 > ./result_10chains/node273_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_7_1 -p 784 -st topic273_7_0 -pt topic273_7_1 -u 0.007100869369256149 > ./result_10chains/node273_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_8_1 -p 906 -st topic273_8_0 -pt topic273_8_1 -u 0.0006200268366175904 > ./result_10chains/node273_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_9_1 -p 942 -st topic273_9_0 -pt topic273_9_1 -u 0.01964664737216969 > ./result_10chains/node273_9_1.txt &
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
    "./result_10chains/node273_0_1.txt 90"
    "./result_10chains/node273_1_1.txt 89"
    "./result_10chains/node273_2_1.txt 88"
    "./result_10chains/node273_3_1.txt 87"
    "./result_10chains/node273_4_1.txt 86"
    "./result_10chains/node273_5_1.txt 85"
    "./result_10chains/node273_6_1.txt 84"
    "./result_10chains/node273_7_1.txt 83"
    "./result_10chains/node273_8_1.txt 82"
    "./result_10chains/node273_9_1.txt 81"
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
