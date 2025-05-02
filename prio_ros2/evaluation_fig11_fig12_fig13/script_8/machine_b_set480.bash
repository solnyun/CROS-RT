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
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_1 -p 112 -st topic480_0_0 -pt topic480_0_1 -u 0.010341220747486835 > ./result_8chains/node480_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_1 -p 114 -st topic480_1_0 -pt topic480_1_1 -u 0.0035809533457504816 > ./result_8chains/node480_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_1 -p 135 -st topic480_2_0 -pt topic480_2_1 -u 0.012268747443406058 > ./result_8chains/node480_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_1 -p 280 -st topic480_3_0 -pt topic480_3_1 -u 0.015551682647664766 > ./result_8chains/node480_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_1 -p 305 -st topic480_4_0 -pt topic480_4_1 -u 0.0060445267146234105 > ./result_8chains/node480_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_1 -p 320 -st topic480_5_0 -pt topic480_5_1 -u 0.03843306598077928 > ./result_8chains/node480_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_6_1 -p 865 -st topic480_6_0 -pt topic480_6_1 -u 0.02162501466304187 > ./result_8chains/node480_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_7_1 -p 888 -st topic480_7_0 -pt topic480_7_1 -u 0.06269037822387523 > ./result_8chains/node480_7_1.txt &
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
    "./result_8chains/node480_0_1.txt 90"
    "./result_8chains/node480_1_1.txt 89"
    "./result_8chains/node480_2_1.txt 88"
    "./result_8chains/node480_3_1.txt 87"
    "./result_8chains/node480_4_1.txt 86"
    "./result_8chains/node480_5_1.txt 85"
    "./result_8chains/node480_6_1.txt 84"
    "./result_8chains/node480_7_1.txt 83"
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
