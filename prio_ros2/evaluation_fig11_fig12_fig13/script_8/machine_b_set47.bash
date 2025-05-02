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
ros2 run evaluation_3_randomdag uunifast_node -n node47_0_1 -p 219 -st topic47_0_0 -pt topic47_0_1 -u 0.005348848048271293 > ./result_8chains/node47_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_1_1 -p 364 -st topic47_1_0 -pt topic47_1_1 -u 0.0024009276304056693 > ./result_8chains/node47_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_2_1 -p 480 -st topic47_2_0 -pt topic47_2_1 -u 0.006409251244824554 > ./result_8chains/node47_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_3_1 -p 494 -st topic47_3_0 -pt topic47_3_1 -u 0.017695867010531496 > ./result_8chains/node47_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_4_1 -p 514 -st topic47_4_0 -pt topic47_4_1 -u 0.014561551135771567 > ./result_8chains/node47_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_5_1 -p 560 -st topic47_5_0 -pt topic47_5_1 -u 0.025479724420437694 > ./result_8chains/node47_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_6_1 -p 690 -st topic47_6_0 -pt topic47_6_1 -u 0.08116247980641036 > ./result_8chains/node47_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node47_7_1 -p 898 -st topic47_7_0 -pt topic47_7_1 -u 0.007278033325035067 > ./result_8chains/node47_7_1.txt &
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
    "./result_8chains/node47_0_1.txt 90"
    "./result_8chains/node47_1_1.txt 89"
    "./result_8chains/node47_2_1.txt 88"
    "./result_8chains/node47_3_1.txt 87"
    "./result_8chains/node47_4_1.txt 86"
    "./result_8chains/node47_5_1.txt 85"
    "./result_8chains/node47_6_1.txt 84"
    "./result_8chains/node47_7_1.txt 83"
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
