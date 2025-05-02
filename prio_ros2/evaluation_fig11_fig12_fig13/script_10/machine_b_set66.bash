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
ros2 run evaluation_3_randomdag uunifast_node -n node66_0_1 -p 78 -st topic66_0_0 -pt topic66_0_1 -u 0.007506365760515443 > ./result_10chains/node66_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_1_1 -p 156 -st topic66_1_0 -pt topic66_1_1 -u 0.023712072366467107 > ./result_10chains/node66_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_2_1 -p 215 -st topic66_2_0 -pt topic66_2_1 -u 0.03762902830419562 > ./result_10chains/node66_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_3_1 -p 276 -st topic66_3_0 -pt topic66_3_1 -u 0.0008641426922742501 > ./result_10chains/node66_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_4_1 -p 301 -st topic66_4_0 -pt topic66_4_1 -u 0.02677546186962948 > ./result_10chains/node66_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_5_1 -p 421 -st topic66_5_0 -pt topic66_5_1 -u 0.029192031225648257 > ./result_10chains/node66_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_6_1 -p 452 -st topic66_6_0 -pt topic66_6_1 -u 0.0011075524951044136 > ./result_10chains/node66_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_7_1 -p 588 -st topic66_7_0 -pt topic66_7_1 -u 0.012845023760430951 > ./result_10chains/node66_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_8_1 -p 882 -st topic66_8_0 -pt topic66_8_1 -u 0.007477574323401404 > ./result_10chains/node66_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_9_1 -p 916 -st topic66_9_0 -pt topic66_9_1 -u 0.03400810454107516 > ./result_10chains/node66_9_1.txt &
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
    "./result_10chains/node66_0_1.txt 90"
    "./result_10chains/node66_1_1.txt 89"
    "./result_10chains/node66_2_1.txt 88"
    "./result_10chains/node66_3_1.txt 87"
    "./result_10chains/node66_4_1.txt 86"
    "./result_10chains/node66_5_1.txt 85"
    "./result_10chains/node66_6_1.txt 84"
    "./result_10chains/node66_7_1.txt 83"
    "./result_10chains/node66_8_1.txt 82"
    "./result_10chains/node66_9_1.txt 81"
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
