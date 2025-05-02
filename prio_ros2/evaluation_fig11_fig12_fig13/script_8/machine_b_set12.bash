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
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_1 -p 72 -st topic12_0_0 -pt topic12_0_1 -u 0.016433344470781708 > ./result_8chains/node12_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_1 -p 152 -st topic12_1_0 -pt topic12_1_1 -u 0.046220692253018225 > ./result_8chains/node12_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_1 -p 424 -st topic12_2_0 -pt topic12_2_1 -u 0.040092988949374686 > ./result_8chains/node12_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_1 -p 632 -st topic12_3_0 -pt topic12_3_1 -u 0.01627109536484725 > ./result_8chains/node12_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_1 -p 695 -st topic12_4_0 -pt topic12_4_1 -u 0.02355396083598968 > ./result_8chains/node12_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_1 -p 799 -st topic12_5_0 -pt topic12_5_1 -u 0.08482316853795527 > ./result_8chains/node12_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_6_1 -p 860 -st topic12_6_0 -pt topic12_6_1 -u 0.003164145838939543 > ./result_8chains/node12_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_7_1 -p 877 -st topic12_7_0 -pt topic12_7_1 -u 0.010448074996294118 > ./result_8chains/node12_7_1.txt &
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
    "./result_8chains/node12_0_1.txt 90"
    "./result_8chains/node12_1_1.txt 89"
    "./result_8chains/node12_2_1.txt 88"
    "./result_8chains/node12_3_1.txt 87"
    "./result_8chains/node12_4_1.txt 86"
    "./result_8chains/node12_5_1.txt 85"
    "./result_8chains/node12_6_1.txt 84"
    "./result_8chains/node12_7_1.txt 83"
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
