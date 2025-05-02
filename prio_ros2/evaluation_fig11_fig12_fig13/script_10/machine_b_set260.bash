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
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_1 -p 159 -st topic260_0_0 -pt topic260_0_1 -u 0.01259915519324123 > ./result_10chains/node260_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_1 -p 230 -st topic260_1_0 -pt topic260_1_1 -u 0.003596670352601472 > ./result_10chains/node260_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_1 -p 262 -st topic260_2_0 -pt topic260_2_1 -u 0.032448512358716375 > ./result_10chains/node260_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_1 -p 272 -st topic260_3_0 -pt topic260_3_1 -u 0.001638225214721789 > ./result_10chains/node260_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_1 -p 533 -st topic260_4_0 -pt topic260_4_1 -u 0.0009177630986179075 > ./result_10chains/node260_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_1 -p 544 -st topic260_5_0 -pt topic260_5_1 -u 0.0010824778763009468 > ./result_10chains/node260_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_6_1 -p 600 -st topic260_6_0 -pt topic260_6_1 -u 0.020789463283851728 > ./result_10chains/node260_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_7_1 -p 772 -st topic260_7_0 -pt topic260_7_1 -u 0.020062736603334713 > ./result_10chains/node260_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_8_1 -p 906 -st topic260_8_0 -pt topic260_8_1 -u 0.00035727066556756615 > ./result_10chains/node260_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_9_1 -p 951 -st topic260_9_0 -pt topic260_9_1 -u 0.030774738307151404 > ./result_10chains/node260_9_1.txt &
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
    "./result_10chains/node260_0_1.txt 90"
    "./result_10chains/node260_1_1.txt 89"
    "./result_10chains/node260_2_1.txt 88"
    "./result_10chains/node260_3_1.txt 87"
    "./result_10chains/node260_4_1.txt 86"
    "./result_10chains/node260_5_1.txt 85"
    "./result_10chains/node260_6_1.txt 84"
    "./result_10chains/node260_7_1.txt 83"
    "./result_10chains/node260_8_1.txt 82"
    "./result_10chains/node260_9_1.txt 81"
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
