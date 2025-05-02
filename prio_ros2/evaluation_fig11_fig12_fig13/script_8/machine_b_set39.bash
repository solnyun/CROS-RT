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
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_1 -p 214 -st topic39_0_0 -pt topic39_0_1 -u 0.012273643985553528 > ./result_8chains/node39_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_1 -p 385 -st topic39_1_0 -pt topic39_1_1 -u 0.009360152694794677 > ./result_8chains/node39_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_1 -p 501 -st topic39_2_0 -pt topic39_2_1 -u 0.012696109410337497 > ./result_8chains/node39_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_1 -p 546 -st topic39_3_0 -pt topic39_3_1 -u 0.020154283025215936 > ./result_8chains/node39_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_1 -p 598 -st topic39_4_0 -pt topic39_4_1 -u 0.025811309384746017 > ./result_8chains/node39_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_1 -p 726 -st topic39_5_0 -pt topic39_5_1 -u 0.02659786075347964 > ./result_8chains/node39_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_6_1 -p 871 -st topic39_6_0 -pt topic39_6_1 -u 0.007312119798369529 > ./result_8chains/node39_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node39_7_1 -p 901 -st topic39_7_0 -pt topic39_7_1 -u 0.0010537026112627731 > ./result_8chains/node39_7_1.txt &
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
    "./result_8chains/node39_0_1.txt 90"
    "./result_8chains/node39_1_1.txt 89"
    "./result_8chains/node39_2_1.txt 88"
    "./result_8chains/node39_3_1.txt 87"
    "./result_8chains/node39_4_1.txt 86"
    "./result_8chains/node39_5_1.txt 85"
    "./result_8chains/node39_6_1.txt 84"
    "./result_8chains/node39_7_1.txt 83"
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
