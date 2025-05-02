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
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_1 -p 183 -st topic67_0_0 -pt topic67_0_1 -u 0.002413151768004773 > ./result_8chains/node67_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_1 -p 306 -st topic67_1_0 -pt topic67_1_1 -u 0.006528693432617139 > ./result_8chains/node67_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_1 -p 337 -st topic67_2_0 -pt topic67_2_1 -u 0.019836404793844853 > ./result_8chains/node67_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_1 -p 566 -st topic67_3_0 -pt topic67_3_1 -u 0.05339837266808256 > ./result_8chains/node67_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_1 -p 570 -st topic67_4_0 -pt topic67_4_1 -u 0.0018588378134206662 > ./result_8chains/node67_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_1 -p 593 -st topic67_5_0 -pt topic67_5_1 -u 0.034769213055052484 > ./result_8chains/node67_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_6_1 -p 870 -st topic67_6_0 -pt topic67_6_1 -u 2.6198939624078044e-05 > ./result_8chains/node67_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_7_1 -p 975 -st topic67_7_0 -pt topic67_7_1 -u 0.01747096305556845 > ./result_8chains/node67_7_1.txt &
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
    "./result_8chains/node67_0_1.txt 90"
    "./result_8chains/node67_1_1.txt 89"
    "./result_8chains/node67_2_1.txt 88"
    "./result_8chains/node67_3_1.txt 87"
    "./result_8chains/node67_4_1.txt 86"
    "./result_8chains/node67_5_1.txt 85"
    "./result_8chains/node67_6_1.txt 84"
    "./result_8chains/node67_7_1.txt 83"
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
