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
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_1 -p 18 -st topic148_0_0 -pt topic148_0_1 -u 0.02801957129466709 > ./result_10chains/node148_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_1 -p 124 -st topic148_1_0 -pt topic148_1_1 -u 0.006140011621110331 > ./result_10chains/node148_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_1 -p 156 -st topic148_2_0 -pt topic148_2_1 -u 0.00037587841322161974 > ./result_10chains/node148_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_1 -p 187 -st topic148_3_0 -pt topic148_3_1 -u 0.018558502637785718 > ./result_10chains/node148_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_1 -p 244 -st topic148_4_0 -pt topic148_4_1 -u 0.02889513642713143 > ./result_10chains/node148_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_1 -p 314 -st topic148_5_0 -pt topic148_5_1 -u 0.007223259563254675 > ./result_10chains/node148_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_6_1 -p 430 -st topic148_6_0 -pt topic148_6_1 -u 0.0003386717192822297 > ./result_10chains/node148_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_7_1 -p 531 -st topic148_7_0 -pt topic148_7_1 -u 0.007307367293058975 > ./result_10chains/node148_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_8_1 -p 802 -st topic148_8_0 -pt topic148_8_1 -u 0.006850438933026656 > ./result_10chains/node148_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_9_1 -p 911 -st topic148_9_0 -pt topic148_9_1 -u 0.04084148534616164 > ./result_10chains/node148_9_1.txt &
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
    "./result_10chains/node148_0_1.txt 90"
    "./result_10chains/node148_1_1.txt 89"
    "./result_10chains/node148_2_1.txt 88"
    "./result_10chains/node148_3_1.txt 87"
    "./result_10chains/node148_4_1.txt 86"
    "./result_10chains/node148_5_1.txt 85"
    "./result_10chains/node148_6_1.txt 84"
    "./result_10chains/node148_7_1.txt 83"
    "./result_10chains/node148_8_1.txt 82"
    "./result_10chains/node148_9_1.txt 81"
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
