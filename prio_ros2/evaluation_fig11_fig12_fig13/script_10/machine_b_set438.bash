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
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_1 -p 295 -st topic438_0_0 -pt topic438_0_1 -u 0.002598716993216621 > ./result_10chains/node438_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_1 -p 360 -st topic438_1_0 -pt topic438_1_1 -u 0.0002525604707007689 > ./result_10chains/node438_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_1 -p 428 -st topic438_2_0 -pt topic438_2_1 -u 0.014061642423129794 > ./result_10chains/node438_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_1 -p 600 -st topic438_3_0 -pt topic438_3_1 -u 0.022324004255653895 > ./result_10chains/node438_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_1 -p 657 -st topic438_4_0 -pt topic438_4_1 -u 0.01825036251542478 > ./result_10chains/node438_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_1 -p 806 -st topic438_5_0 -pt topic438_5_1 -u 0.0008366385574565538 > ./result_10chains/node438_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_6_1 -p 850 -st topic438_6_0 -pt topic438_6_1 -u 0.011569334222751582 > ./result_10chains/node438_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_7_1 -p 905 -st topic438_7_0 -pt topic438_7_1 -u 0.00472222128686553 > ./result_10chains/node438_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_8_1 -p 914 -st topic438_8_0 -pt topic438_8_1 -u 0.013630133633209057 > ./result_10chains/node438_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_9_1 -p 976 -st topic438_9_0 -pt topic438_9_1 -u 0.007057910479828953 > ./result_10chains/node438_9_1.txt &
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
    "./result_10chains/node438_0_1.txt 90"
    "./result_10chains/node438_1_1.txt 89"
    "./result_10chains/node438_2_1.txt 88"
    "./result_10chains/node438_3_1.txt 87"
    "./result_10chains/node438_4_1.txt 86"
    "./result_10chains/node438_5_1.txt 85"
    "./result_10chains/node438_6_1.txt 84"
    "./result_10chains/node438_7_1.txt 83"
    "./result_10chains/node438_8_1.txt 82"
    "./result_10chains/node438_9_1.txt 81"
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
