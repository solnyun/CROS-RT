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
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_1 -p 21 -st topic178_0_0 -pt topic178_0_1 -u 0.021315449037377032 > ./result_8chains/node178_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_1 -p 97 -st topic178_1_0 -pt topic178_1_1 -u 0.016496964968668426 > ./result_8chains/node178_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_1 -p 219 -st topic178_2_0 -pt topic178_2_1 -u 0.009377991212512038 > ./result_8chains/node178_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_1 -p 257 -st topic178_3_0 -pt topic178_3_1 -u 0.0076494063292927295 > ./result_8chains/node178_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_1 -p 488 -st topic178_4_0 -pt topic178_4_1 -u 0.004081172185306237 > ./result_8chains/node178_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_1 -p 602 -st topic178_5_0 -pt topic178_5_1 -u 0.012376470129538464 > ./result_8chains/node178_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_6_1 -p 700 -st topic178_6_0 -pt topic178_6_1 -u 0.05031966518231102 > ./result_8chains/node178_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_7_1 -p 858 -st topic178_7_0 -pt topic178_7_1 -u 0.017788468426803095 > ./result_8chains/node178_7_1.txt &
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
    "./result_8chains/node178_0_1.txt 90"
    "./result_8chains/node178_1_1.txt 89"
    "./result_8chains/node178_2_1.txt 88"
    "./result_8chains/node178_3_1.txt 87"
    "./result_8chains/node178_4_1.txt 86"
    "./result_8chains/node178_5_1.txt 85"
    "./result_8chains/node178_6_1.txt 84"
    "./result_8chains/node178_7_1.txt 83"
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
