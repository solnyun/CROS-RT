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
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_1 -p 10 -st topic398_0_0 -pt topic398_0_1 -u 0.03914228973328737 > ./result_8chains/node398_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_1 -p 65 -st topic398_1_0 -pt topic398_1_1 -u 0.01626098961924849 > ./result_8chains/node398_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_1 -p 533 -st topic398_2_0 -pt topic398_2_1 -u 0.016624424542381444 > ./result_8chains/node398_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_1 -p 588 -st topic398_3_0 -pt topic398_3_1 -u 0.02196151497099974 > ./result_8chains/node398_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_4_1 -p 629 -st topic398_4_0 -pt topic398_4_1 -u 0.025162348335856205 > ./result_8chains/node398_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_5_1 -p 634 -st topic398_5_0 -pt topic398_5_1 -u 0.010014323957191734 > ./result_8chains/node398_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_6_1 -p 946 -st topic398_6_0 -pt topic398_6_1 -u 0.04211826961375342 > ./result_8chains/node398_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_7_1 -p 957 -st topic398_7_0 -pt topic398_7_1 -u 0.01895344908051613 > ./result_8chains/node398_7_1.txt &
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
    "./result_8chains/node398_0_1.txt 90"
    "./result_8chains/node398_1_1.txt 89"
    "./result_8chains/node398_2_1.txt 88"
    "./result_8chains/node398_3_1.txt 87"
    "./result_8chains/node398_4_1.txt 86"
    "./result_8chains/node398_5_1.txt 85"
    "./result_8chains/node398_6_1.txt 84"
    "./result_8chains/node398_7_1.txt 83"
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
