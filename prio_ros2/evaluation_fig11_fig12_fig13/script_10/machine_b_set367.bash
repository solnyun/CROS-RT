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
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_1 -p 95 -st topic367_0_0 -pt topic367_0_1 -u 0.022463281417637926 > ./result_10chains/node367_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_1 -p 102 -st topic367_1_0 -pt topic367_1_1 -u 0.002820005092044553 > ./result_10chains/node367_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_1 -p 170 -st topic367_2_0 -pt topic367_2_1 -u 0.0025128115286564 > ./result_10chains/node367_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_1 -p 308 -st topic367_3_0 -pt topic367_3_1 -u 0.0649532721877864 > ./result_10chains/node367_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_1 -p 357 -st topic367_4_0 -pt topic367_4_1 -u 0.004938002941887759 > ./result_10chains/node367_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_1 -p 420 -st topic367_5_0 -pt topic367_5_1 -u 0.024007537943360024 > ./result_10chains/node367_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_6_1 -p 453 -st topic367_6_0 -pt topic367_6_1 -u 0.029687109965049502 > ./result_10chains/node367_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_7_1 -p 600 -st topic367_7_0 -pt topic367_7_1 -u 0.018189421732632896 > ./result_10chains/node367_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_8_1 -p 640 -st topic367_8_0 -pt topic367_8_1 -u 0.00435000195161947 > ./result_10chains/node367_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_9_1 -p 935 -st topic367_9_0 -pt topic367_9_1 -u 0.060960217312849764 > ./result_10chains/node367_9_1.txt &
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
    "./result_10chains/node367_0_1.txt 90"
    "./result_10chains/node367_1_1.txt 89"
    "./result_10chains/node367_2_1.txt 88"
    "./result_10chains/node367_3_1.txt 87"
    "./result_10chains/node367_4_1.txt 86"
    "./result_10chains/node367_5_1.txt 85"
    "./result_10chains/node367_6_1.txt 84"
    "./result_10chains/node367_7_1.txt 83"
    "./result_10chains/node367_8_1.txt 82"
    "./result_10chains/node367_9_1.txt 81"
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
