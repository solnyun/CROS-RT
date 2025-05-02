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
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_1 -p 73 -st topic445_0_0 -pt topic445_0_1 -u 0.04102255141078187 > ./result_10chains/node445_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_1 -p 74 -st topic445_1_0 -pt topic445_1_1 -u 0.045098679776624295 > ./result_10chains/node445_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_1 -p 126 -st topic445_2_0 -pt topic445_2_1 -u 0.0031091551600033185 > ./result_10chains/node445_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_1 -p 144 -st topic445_3_0 -pt topic445_3_1 -u 0.004121431704175504 > ./result_10chains/node445_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_1 -p 196 -st topic445_4_0 -pt topic445_4_1 -u 0.0008055092671572783 > ./result_10chains/node445_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_1 -p 427 -st topic445_5_0 -pt topic445_5_1 -u 0.004654320332172446 > ./result_10chains/node445_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_6_1 -p 429 -st topic445_6_0 -pt topic445_6_1 -u 0.004307955631419502 > ./result_10chains/node445_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_7_1 -p 900 -st topic445_7_0 -pt topic445_7_1 -u 0.03904420165277486 > ./result_10chains/node445_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_8_1 -p 956 -st topic445_8_0 -pt topic445_8_1 -u 0.013780146697117635 > ./result_10chains/node445_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_9_1 -p 979 -st topic445_9_0 -pt topic445_9_1 -u 0.04243895744666805 > ./result_10chains/node445_9_1.txt &
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
    "./result_10chains/node445_0_1.txt 90"
    "./result_10chains/node445_1_1.txt 89"
    "./result_10chains/node445_2_1.txt 88"
    "./result_10chains/node445_3_1.txt 87"
    "./result_10chains/node445_4_1.txt 86"
    "./result_10chains/node445_5_1.txt 85"
    "./result_10chains/node445_6_1.txt 84"
    "./result_10chains/node445_7_1.txt 83"
    "./result_10chains/node445_8_1.txt 82"
    "./result_10chains/node445_9_1.txt 81"
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
