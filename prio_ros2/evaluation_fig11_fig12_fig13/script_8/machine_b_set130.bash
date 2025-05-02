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
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_1 -p 30 -st topic130_0_0 -pt topic130_0_1 -u 0.0012736040656582959 > ./result_8chains/node130_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_1 -p 209 -st topic130_1_0 -pt topic130_1_1 -u 0.027838478831045343 > ./result_8chains/node130_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_1 -p 463 -st topic130_2_0 -pt topic130_2_1 -u 0.023447543736342447 > ./result_8chains/node130_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_1 -p 529 -st topic130_3_0 -pt topic130_3_1 -u 0.005496279548443561 > ./result_8chains/node130_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_1 -p 737 -st topic130_4_0 -pt topic130_4_1 -u 0.00047628653699138823 > ./result_8chains/node130_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_1 -p 766 -st topic130_5_0 -pt topic130_5_1 -u 0.0021752846846155305 > ./result_8chains/node130_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_6_1 -p 802 -st topic130_6_0 -pt topic130_6_1 -u 0.03228100206220136 > ./result_8chains/node130_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_7_1 -p 973 -st topic130_7_0 -pt topic130_7_1 -u 0.0044869050920946785 > ./result_8chains/node130_7_1.txt &
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
    "./result_8chains/node130_0_1.txt 90"
    "./result_8chains/node130_1_1.txt 89"
    "./result_8chains/node130_2_1.txt 88"
    "./result_8chains/node130_3_1.txt 87"
    "./result_8chains/node130_4_1.txt 86"
    "./result_8chains/node130_5_1.txt 85"
    "./result_8chains/node130_6_1.txt 84"
    "./result_8chains/node130_7_1.txt 83"
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
