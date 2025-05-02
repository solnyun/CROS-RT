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
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_1 -p 53 -st topic154_0_0 -pt topic154_0_1 -u 0.008581866687186024 > ./result_10chains/node154_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_1 -p 74 -st topic154_1_0 -pt topic154_1_1 -u 0.012192419827741607 > ./result_10chains/node154_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_1 -p 117 -st topic154_2_0 -pt topic154_2_1 -u 0.018870777791190785 > ./result_10chains/node154_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_1 -p 208 -st topic154_3_0 -pt topic154_3_1 -u 0.0005876512146401058 > ./result_10chains/node154_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_1 -p 286 -st topic154_4_0 -pt topic154_4_1 -u 0.005160521629816117 > ./result_10chains/node154_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_1 -p 310 -st topic154_5_0 -pt topic154_5_1 -u 0.004359753954617462 > ./result_10chains/node154_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_6_1 -p 374 -st topic154_6_0 -pt topic154_6_1 -u 0.011115277385513461 > ./result_10chains/node154_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_7_1 -p 463 -st topic154_7_0 -pt topic154_7_1 -u 0.033537256508566274 > ./result_10chains/node154_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_8_1 -p 869 -st topic154_8_0 -pt topic154_8_1 -u 0.0021853633652635096 > ./result_10chains/node154_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_9_1 -p 874 -st topic154_9_0 -pt topic154_9_1 -u 0.005894931641657983 > ./result_10chains/node154_9_1.txt &
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
    "./result_10chains/node154_0_1.txt 90"
    "./result_10chains/node154_1_1.txt 89"
    "./result_10chains/node154_2_1.txt 88"
    "./result_10chains/node154_3_1.txt 87"
    "./result_10chains/node154_4_1.txt 86"
    "./result_10chains/node154_5_1.txt 85"
    "./result_10chains/node154_6_1.txt 84"
    "./result_10chains/node154_7_1.txt 83"
    "./result_10chains/node154_8_1.txt 82"
    "./result_10chains/node154_9_1.txt 81"
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
