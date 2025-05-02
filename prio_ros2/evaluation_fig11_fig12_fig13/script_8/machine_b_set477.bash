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
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_1 -p 65 -st topic477_0_0 -pt topic477_0_1 -u 0.008425045572726941 > ./result_8chains/node477_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_1 -p 258 -st topic477_1_0 -pt topic477_1_1 -u 0.039707646500859006 > ./result_8chains/node477_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_1 -p 330 -st topic477_2_0 -pt topic477_2_1 -u 0.015003939365113239 > ./result_8chains/node477_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_1 -p 407 -st topic477_3_0 -pt topic477_3_1 -u 0.05518704311842937 > ./result_8chains/node477_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_1 -p 537 -st topic477_4_0 -pt topic477_4_1 -u 0.0046396939648152835 > ./result_8chains/node477_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_1 -p 688 -st topic477_5_0 -pt topic477_5_1 -u 0.010644124187596166 > ./result_8chains/node477_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_6_1 -p 785 -st topic477_6_0 -pt topic477_6_1 -u 0.005282800150033663 > ./result_8chains/node477_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_7_1 -p 821 -st topic477_7_0 -pt topic477_7_1 -u 0.007941107307004813 > ./result_8chains/node477_7_1.txt &
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
    "./result_8chains/node477_0_1.txt 90"
    "./result_8chains/node477_1_1.txt 89"
    "./result_8chains/node477_2_1.txt 88"
    "./result_8chains/node477_3_1.txt 87"
    "./result_8chains/node477_4_1.txt 86"
    "./result_8chains/node477_5_1.txt 85"
    "./result_8chains/node477_6_1.txt 84"
    "./result_8chains/node477_7_1.txt 83"
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
