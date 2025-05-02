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
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_1 -p 13 -st topic495_0_0 -pt topic495_0_1 -u 0.006453035080955183 > ./result_10chains/node495_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_1 -p 54 -st topic495_1_0 -pt topic495_1_1 -u 0.01690737958995453 > ./result_10chains/node495_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_1 -p 77 -st topic495_2_0 -pt topic495_2_1 -u 0.006256452909230159 > ./result_10chains/node495_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_1 -p 105 -st topic495_3_0 -pt topic495_3_1 -u 0.008690172772550853 > ./result_10chains/node495_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_1 -p 176 -st topic495_4_0 -pt topic495_4_1 -u 0.041722612900862543 > ./result_10chains/node495_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_1 -p 266 -st topic495_5_0 -pt topic495_5_1 -u 0.025156398998513796 > ./result_10chains/node495_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_6_1 -p 335 -st topic495_6_0 -pt topic495_6_1 -u 0.0025003663150340305 > ./result_10chains/node495_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_7_1 -p 541 -st topic495_7_0 -pt topic495_7_1 -u 0.02006205684378823 > ./result_10chains/node495_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_8_1 -p 799 -st topic495_8_0 -pt topic495_8_1 -u 0.017815896412125977 > ./result_10chains/node495_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_9_1 -p 947 -st topic495_9_0 -pt topic495_9_1 -u 0.00818593877090982 > ./result_10chains/node495_9_1.txt &
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
    "./result_10chains/node495_0_1.txt 90"
    "./result_10chains/node495_1_1.txt 89"
    "./result_10chains/node495_2_1.txt 88"
    "./result_10chains/node495_3_1.txt 87"
    "./result_10chains/node495_4_1.txt 86"
    "./result_10chains/node495_5_1.txt 85"
    "./result_10chains/node495_6_1.txt 84"
    "./result_10chains/node495_7_1.txt 83"
    "./result_10chains/node495_8_1.txt 82"
    "./result_10chains/node495_9_1.txt 81"
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
