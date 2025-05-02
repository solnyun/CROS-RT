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
ros2 run evaluation_3_randomdag uunifast_node -n node106_0_1 -p 54 -st topic106_0_0 -pt topic106_0_1 -u 0.018911228638815225 > ./result_8chains/node106_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_1_1 -p 393 -st topic106_1_0 -pt topic106_1_1 -u 0.04695647980762557 > ./result_8chains/node106_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_2_1 -p 493 -st topic106_2_0 -pt topic106_2_1 -u 0.007950582985719712 > ./result_8chains/node106_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_3_1 -p 495 -st topic106_3_0 -pt topic106_3_1 -u 0.038756677254086325 > ./result_8chains/node106_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_4_1 -p 714 -st topic106_4_0 -pt topic106_4_1 -u 0.07191627849341309 > ./result_8chains/node106_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_5_1 -p 857 -st topic106_5_0 -pt topic106_5_1 -u 0.012954612507417404 > ./result_8chains/node106_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_6_1 -p 889 -st topic106_6_0 -pt topic106_6_1 -u 0.0074720250720546125 > ./result_8chains/node106_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_7_1 -p 916 -st topic106_7_0 -pt topic106_7_1 -u 0.009821548141956491 > ./result_8chains/node106_7_1.txt &
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
    "./result_8chains/node106_0_1.txt 90"
    "./result_8chains/node106_1_1.txt 89"
    "./result_8chains/node106_2_1.txt 88"
    "./result_8chains/node106_3_1.txt 87"
    "./result_8chains/node106_4_1.txt 86"
    "./result_8chains/node106_5_1.txt 85"
    "./result_8chains/node106_6_1.txt 84"
    "./result_8chains/node106_7_1.txt 83"
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
