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
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_1 -p 27 -st topic18_0_0 -pt topic18_0_1 -u 0.03779111704017685 > ./result_10chains/node18_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_1 -p 160 -st topic18_1_0 -pt topic18_1_1 -u 0.019158372115230304 > ./result_10chains/node18_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_1 -p 174 -st topic18_2_0 -pt topic18_2_1 -u 0.004716366704763497 > ./result_10chains/node18_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_1 -p 292 -st topic18_3_0 -pt topic18_3_1 -u 0.04795943166800781 > ./result_10chains/node18_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_1 -p 366 -st topic18_4_0 -pt topic18_4_1 -u 0.0021807404995249358 > ./result_10chains/node18_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_1 -p 469 -st topic18_5_0 -pt topic18_5_1 -u 0.017493336645519886 > ./result_10chains/node18_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_6_1 -p 488 -st topic18_6_0 -pt topic18_6_1 -u 0.004013057648535934 > ./result_10chains/node18_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_7_1 -p 601 -st topic18_7_0 -pt topic18_7_1 -u 0.0064455430291852495 > ./result_10chains/node18_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_8_1 -p 771 -st topic18_8_0 -pt topic18_8_1 -u 0.005694219756362709 > ./result_10chains/node18_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node18_9_1 -p 940 -st topic18_9_0 -pt topic18_9_1 -u 0.03587016330025529 > ./result_10chains/node18_9_1.txt &
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
    "./result_10chains/node18_0_1.txt 90"
    "./result_10chains/node18_1_1.txt 89"
    "./result_10chains/node18_2_1.txt 88"
    "./result_10chains/node18_3_1.txt 87"
    "./result_10chains/node18_4_1.txt 86"
    "./result_10chains/node18_5_1.txt 85"
    "./result_10chains/node18_6_1.txt 84"
    "./result_10chains/node18_7_1.txt 83"
    "./result_10chains/node18_8_1.txt 82"
    "./result_10chains/node18_9_1.txt 81"
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
