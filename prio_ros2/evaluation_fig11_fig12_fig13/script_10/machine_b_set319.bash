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
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_1 -p 94 -st topic319_0_0 -pt topic319_0_1 -u 0.022249948970988254 > ./result_10chains/node319_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_1 -p 141 -st topic319_1_0 -pt topic319_1_1 -u 0.0023874168486021086 > ./result_10chains/node319_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_1 -p 146 -st topic319_2_0 -pt topic319_2_1 -u 0.00656373376771946 > ./result_10chains/node319_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_1 -p 255 -st topic319_3_0 -pt topic319_3_1 -u 0.013322726468597224 > ./result_10chains/node319_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_1 -p 319 -st topic319_4_0 -pt topic319_4_1 -u 0.009486871719988466 > ./result_10chains/node319_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_1 -p 324 -st topic319_5_0 -pt topic319_5_1 -u 0.06422369349167939 > ./result_10chains/node319_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_6_1 -p 373 -st topic319_6_0 -pt topic319_6_1 -u 0.014645876466458624 > ./result_10chains/node319_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_7_1 -p 879 -st topic319_7_0 -pt topic319_7_1 -u 0.012198331775658974 > ./result_10chains/node319_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_8_1 -p 889 -st topic319_8_0 -pt topic319_8_1 -u 0.003380373106070242 > ./result_10chains/node319_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_9_1 -p 945 -st topic319_9_0 -pt topic319_9_1 -u 0.015545539569098576 > ./result_10chains/node319_9_1.txt &
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
    "./result_10chains/node319_0_1.txt 90"
    "./result_10chains/node319_1_1.txt 89"
    "./result_10chains/node319_2_1.txt 88"
    "./result_10chains/node319_3_1.txt 87"
    "./result_10chains/node319_4_1.txt 86"
    "./result_10chains/node319_5_1.txt 85"
    "./result_10chains/node319_6_1.txt 84"
    "./result_10chains/node319_7_1.txt 83"
    "./result_10chains/node319_8_1.txt 82"
    "./result_10chains/node319_9_1.txt 81"
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
