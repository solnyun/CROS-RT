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
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_1 -p 250 -st topic384_0_0 -pt topic384_0_1 -u 0.01153881063947837 > ./result_8chains/node384_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_1 -p 368 -st topic384_1_0 -pt topic384_1_1 -u 0.012792381675708842 > ./result_8chains/node384_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_1 -p 490 -st topic384_2_0 -pt topic384_2_1 -u 0.03945418286661995 > ./result_8chains/node384_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_1 -p 603 -st topic384_3_0 -pt topic384_3_1 -u 0.0046496840456922706 > ./result_8chains/node384_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_1 -p 638 -st topic384_4_0 -pt topic384_4_1 -u 0.008788934601013487 > ./result_8chains/node384_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_1 -p 680 -st topic384_5_0 -pt topic384_5_1 -u 0.0054369561627514995 > ./result_8chains/node384_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_6_1 -p 728 -st topic384_6_0 -pt topic384_6_1 -u 0.08081827187013281 > ./result_8chains/node384_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_7_1 -p 941 -st topic384_7_0 -pt topic384_7_1 -u 0.00107850987448302 > ./result_8chains/node384_7_1.txt &
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
    "./result_8chains/node384_0_1.txt 90"
    "./result_8chains/node384_1_1.txt 89"
    "./result_8chains/node384_2_1.txt 88"
    "./result_8chains/node384_3_1.txt 87"
    "./result_8chains/node384_4_1.txt 86"
    "./result_8chains/node384_5_1.txt 85"
    "./result_8chains/node384_6_1.txt 84"
    "./result_8chains/node384_7_1.txt 83"
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
