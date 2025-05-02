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
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_1 -p 33 -st topic270_0_0 -pt topic270_0_1 -u 0.008039428243788893 > ./result_8chains/node270_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_1 -p 50 -st topic270_1_0 -pt topic270_1_1 -u 0.004187096625106246 > ./result_8chains/node270_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_1 -p 119 -st topic270_2_0 -pt topic270_2_1 -u 0.016843959151743138 > ./result_8chains/node270_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_1 -p 150 -st topic270_3_0 -pt topic270_3_1 -u 0.04486217657654609 > ./result_8chains/node270_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_1 -p 541 -st topic270_4_0 -pt topic270_4_1 -u 0.008230702606828816 > ./result_8chains/node270_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_1 -p 629 -st topic270_5_0 -pt topic270_5_1 -u 0.01040402139976547 > ./result_8chains/node270_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_6_1 -p 668 -st topic270_6_0 -pt topic270_6_1 -u 0.04164535445944346 > ./result_8chains/node270_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_7_1 -p 820 -st topic270_7_0 -pt topic270_7_1 -u 0.0007511346112164721 > ./result_8chains/node270_7_1.txt &
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
    "./result_8chains/node270_0_1.txt 90"
    "./result_8chains/node270_1_1.txt 89"
    "./result_8chains/node270_2_1.txt 88"
    "./result_8chains/node270_3_1.txt 87"
    "./result_8chains/node270_4_1.txt 86"
    "./result_8chains/node270_5_1.txt 85"
    "./result_8chains/node270_6_1.txt 84"
    "./result_8chains/node270_7_1.txt 83"
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
