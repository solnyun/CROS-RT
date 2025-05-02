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
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_1 -p 109 -st topic232_0_0 -pt topic232_0_1 -u 0.038921272308596655 > ./result_10chains/node232_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_1 -p 228 -st topic232_1_0 -pt topic232_1_1 -u 0.006793376561201603 > ./result_10chains/node232_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_1 -p 385 -st topic232_2_0 -pt topic232_2_1 -u 0.002905559219286147 > ./result_10chains/node232_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_1 -p 692 -st topic232_3_0 -pt topic232_3_1 -u 0.00723500366555635 > ./result_10chains/node232_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_1 -p 759 -st topic232_4_0 -pt topic232_4_1 -u 0.0027978708447658207 > ./result_10chains/node232_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_1 -p 786 -st topic232_5_0 -pt topic232_5_1 -u 0.01852859265049478 > ./result_10chains/node232_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_6_1 -p 807 -st topic232_6_0 -pt topic232_6_1 -u 0.0003703333956711352 > ./result_10chains/node232_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_7_1 -p 812 -st topic232_7_0 -pt topic232_7_1 -u 0.014794207961424638 > ./result_10chains/node232_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_8_1 -p 867 -st topic232_8_0 -pt topic232_8_1 -u 0.02483520062264566 > ./result_10chains/node232_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_9_1 -p 896 -st topic232_9_0 -pt topic232_9_1 -u 0.014882577031480777 > ./result_10chains/node232_9_1.txt &
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
    "./result_10chains/node232_0_1.txt 90"
    "./result_10chains/node232_1_1.txt 89"
    "./result_10chains/node232_2_1.txt 88"
    "./result_10chains/node232_3_1.txt 87"
    "./result_10chains/node232_4_1.txt 86"
    "./result_10chains/node232_5_1.txt 85"
    "./result_10chains/node232_6_1.txt 84"
    "./result_10chains/node232_7_1.txt 83"
    "./result_10chains/node232_8_1.txt 82"
    "./result_10chains/node232_9_1.txt 81"
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
