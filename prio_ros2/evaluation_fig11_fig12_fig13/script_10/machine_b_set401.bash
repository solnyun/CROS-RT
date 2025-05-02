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
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_1 -p 42 -st topic401_0_0 -pt topic401_0_1 -u 0.0026489876090336484 > ./result_10chains/node401_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_1 -p 70 -st topic401_1_0 -pt topic401_1_1 -u 0.03566617075035661 > ./result_10chains/node401_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_1 -p 174 -st topic401_2_0 -pt topic401_2_1 -u 0.02520749389391208 > ./result_10chains/node401_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_1 -p 226 -st topic401_3_0 -pt topic401_3_1 -u 0.007945646179953525 > ./result_10chains/node401_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_1 -p 259 -st topic401_4_0 -pt topic401_4_1 -u 0.027353760719877607 > ./result_10chains/node401_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_1 -p 331 -st topic401_5_0 -pt topic401_5_1 -u 0.014162293198729747 > ./result_10chains/node401_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_6_1 -p 465 -st topic401_6_0 -pt topic401_6_1 -u 0.003220800579057964 > ./result_10chains/node401_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_7_1 -p 487 -st topic401_7_0 -pt topic401_7_1 -u 0.018738293437189357 > ./result_10chains/node401_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_8_1 -p 589 -st topic401_8_0 -pt topic401_8_1 -u 0.0393114145125556 > ./result_10chains/node401_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_9_1 -p 608 -st topic401_9_0 -pt topic401_9_1 -u 0.008696554177468303 > ./result_10chains/node401_9_1.txt &
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
    "./result_10chains/node401_0_1.txt 90"
    "./result_10chains/node401_1_1.txt 89"
    "./result_10chains/node401_2_1.txt 88"
    "./result_10chains/node401_3_1.txt 87"
    "./result_10chains/node401_4_1.txt 86"
    "./result_10chains/node401_5_1.txt 85"
    "./result_10chains/node401_6_1.txt 84"
    "./result_10chains/node401_7_1.txt 83"
    "./result_10chains/node401_8_1.txt 82"
    "./result_10chains/node401_9_1.txt 81"
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
