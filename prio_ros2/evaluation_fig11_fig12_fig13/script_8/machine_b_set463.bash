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
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_1 -p 73 -st topic463_0_0 -pt topic463_0_1 -u 0.00178600370218851 > ./result_8chains/node463_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_1 -p 83 -st topic463_1_0 -pt topic463_1_1 -u 0.025840660922298975 > ./result_8chains/node463_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_1 -p 280 -st topic463_2_0 -pt topic463_2_1 -u 0.04168638235656558 > ./result_8chains/node463_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_1 -p 312 -st topic463_3_0 -pt topic463_3_1 -u 0.07937825754146643 > ./result_8chains/node463_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_1 -p 431 -st topic463_4_0 -pt topic463_4_1 -u 0.008402897541677223 > ./result_8chains/node463_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_1 -p 818 -st topic463_5_0 -pt topic463_5_1 -u 0.0005539595690772225 > ./result_8chains/node463_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_6_1 -p 888 -st topic463_6_0 -pt topic463_6_1 -u 0.00824746898757138 > ./result_8chains/node463_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_7_1 -p 907 -st topic463_7_0 -pt topic463_7_1 -u 0.03439530141546144 > ./result_8chains/node463_7_1.txt &
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
    "./result_8chains/node463_0_1.txt 90"
    "./result_8chains/node463_1_1.txt 89"
    "./result_8chains/node463_2_1.txt 88"
    "./result_8chains/node463_3_1.txt 87"
    "./result_8chains/node463_4_1.txt 86"
    "./result_8chains/node463_5_1.txt 85"
    "./result_8chains/node463_6_1.txt 84"
    "./result_8chains/node463_7_1.txt 83"
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
