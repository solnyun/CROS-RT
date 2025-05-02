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
ros2 run evaluation_3_randomdag uunifast_node -n node482_0_1 -p 66 -st topic482_0_0 -pt topic482_0_1 -u 0.013541782350699416 > ./result_8chains/node482_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_1_1 -p 235 -st topic482_1_0 -pt topic482_1_1 -u 0.010219196758288696 > ./result_8chains/node482_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_2_1 -p 434 -st topic482_2_0 -pt topic482_2_1 -u 0.018715418206196488 > ./result_8chains/node482_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_3_1 -p 460 -st topic482_3_0 -pt topic482_3_1 -u 0.010536880110874086 > ./result_8chains/node482_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_4_1 -p 567 -st topic482_4_0 -pt topic482_4_1 -u 0.0036743918787534025 > ./result_8chains/node482_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_5_1 -p 583 -st topic482_5_0 -pt topic482_5_1 -u 0.02584425718559452 > ./result_8chains/node482_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_6_1 -p 649 -st topic482_6_0 -pt topic482_6_1 -u 0.010916181878929607 > ./result_8chains/node482_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_7_1 -p 679 -st topic482_7_0 -pt topic482_7_1 -u 0.02110987133267599 > ./result_8chains/node482_7_1.txt &
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
    "./result_8chains/node482_0_1.txt 90"
    "./result_8chains/node482_1_1.txt 89"
    "./result_8chains/node482_2_1.txt 88"
    "./result_8chains/node482_3_1.txt 87"
    "./result_8chains/node482_4_1.txt 86"
    "./result_8chains/node482_5_1.txt 85"
    "./result_8chains/node482_6_1.txt 84"
    "./result_8chains/node482_7_1.txt 83"
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
