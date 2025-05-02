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
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_1 -p 73 -st topic147_0_0 -pt topic147_0_1 -u 0.006541960022144688 > ./result_10chains/node147_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_1 -p 125 -st topic147_1_0 -pt topic147_1_1 -u 0.012626077699640581 > ./result_10chains/node147_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_1 -p 156 -st topic147_2_0 -pt topic147_2_1 -u 0.008961018091840411 > ./result_10chains/node147_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_1 -p 283 -st topic147_3_0 -pt topic147_3_1 -u 0.04639201204245366 > ./result_10chains/node147_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_1 -p 394 -st topic147_4_0 -pt topic147_4_1 -u 0.011699229485725743 > ./result_10chains/node147_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_1 -p 598 -st topic147_5_0 -pt topic147_5_1 -u 0.002369684536189326 > ./result_10chains/node147_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_6_1 -p 606 -st topic147_6_0 -pt topic147_6_1 -u 0.00704176698400763 > ./result_10chains/node147_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_7_1 -p 648 -st topic147_7_0 -pt topic147_7_1 -u 0.009984335338720562 > ./result_10chains/node147_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_8_1 -p 866 -st topic147_8_0 -pt topic147_8_1 -u 0.04180555346628588 > ./result_10chains/node147_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_9_1 -p 917 -st topic147_9_0 -pt topic147_9_1 -u 0.012772683557629077 > ./result_10chains/node147_9_1.txt &
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
    "./result_10chains/node147_0_1.txt 90"
    "./result_10chains/node147_1_1.txt 89"
    "./result_10chains/node147_2_1.txt 88"
    "./result_10chains/node147_3_1.txt 87"
    "./result_10chains/node147_4_1.txt 86"
    "./result_10chains/node147_5_1.txt 85"
    "./result_10chains/node147_6_1.txt 84"
    "./result_10chains/node147_7_1.txt 83"
    "./result_10chains/node147_8_1.txt 82"
    "./result_10chains/node147_9_1.txt 81"
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
