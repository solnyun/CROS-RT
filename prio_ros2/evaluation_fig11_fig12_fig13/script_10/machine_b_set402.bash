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
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_1 -p 158 -st topic402_0_0 -pt topic402_0_1 -u 0.01353145023167851 > ./result_10chains/node402_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_1 -p 196 -st topic402_1_0 -pt topic402_1_1 -u 0.029007022005737848 > ./result_10chains/node402_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_1 -p 208 -st topic402_2_0 -pt topic402_2_1 -u 0.013668468921173571 > ./result_10chains/node402_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_1 -p 224 -st topic402_3_0 -pt topic402_3_1 -u 0.009271705613689729 > ./result_10chains/node402_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_4_1 -p 406 -st topic402_4_0 -pt topic402_4_1 -u 0.04322843890989858 > ./result_10chains/node402_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_5_1 -p 407 -st topic402_5_0 -pt topic402_5_1 -u 0.00023729546009779168 > ./result_10chains/node402_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_6_1 -p 479 -st topic402_6_0 -pt topic402_6_1 -u 0.00885938572322928 > ./result_10chains/node402_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_7_1 -p 634 -st topic402_7_0 -pt topic402_7_1 -u 0.016032600362087174 > ./result_10chains/node402_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_8_1 -p 668 -st topic402_8_0 -pt topic402_8_1 -u 0.008585671269424472 > ./result_10chains/node402_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_9_1 -p 679 -st topic402_9_0 -pt topic402_9_1 -u 0.04032665318259559 > ./result_10chains/node402_9_1.txt &
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
    "./result_10chains/node402_0_1.txt 90"
    "./result_10chains/node402_1_1.txt 89"
    "./result_10chains/node402_2_1.txt 88"
    "./result_10chains/node402_3_1.txt 87"
    "./result_10chains/node402_4_1.txt 86"
    "./result_10chains/node402_5_1.txt 85"
    "./result_10chains/node402_6_1.txt 84"
    "./result_10chains/node402_7_1.txt 83"
    "./result_10chains/node402_8_1.txt 82"
    "./result_10chains/node402_9_1.txt 81"
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
