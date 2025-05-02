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
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_1 -p 110 -st topic29_0_0 -pt topic29_0_1 -u 0.029980258864373388 > ./result_8chains/node29_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_1 -p 211 -st topic29_1_0 -pt topic29_1_1 -u 0.033150221752629716 > ./result_8chains/node29_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_1 -p 516 -st topic29_2_0 -pt topic29_2_1 -u 0.03898638148538536 > ./result_8chains/node29_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_1 -p 581 -st topic29_3_0 -pt topic29_3_1 -u 0.000591665976940714 > ./result_8chains/node29_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_1 -p 749 -st topic29_4_0 -pt topic29_4_1 -u 0.02748422598188069 > ./result_8chains/node29_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_1 -p 817 -st topic29_5_0 -pt topic29_5_1 -u 0.001321495064946332 > ./result_8chains/node29_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_6_1 -p 943 -st topic29_6_0 -pt topic29_6_1 -u 0.007312822154840637 > ./result_8chains/node29_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node29_7_1 -p 990 -st topic29_7_0 -pt topic29_7_1 -u 0.0067967028819894346 > ./result_8chains/node29_7_1.txt &
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
    "./result_8chains/node29_0_1.txt 90"
    "./result_8chains/node29_1_1.txt 89"
    "./result_8chains/node29_2_1.txt 88"
    "./result_8chains/node29_3_1.txt 87"
    "./result_8chains/node29_4_1.txt 86"
    "./result_8chains/node29_5_1.txt 85"
    "./result_8chains/node29_6_1.txt 84"
    "./result_8chains/node29_7_1.txt 83"
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
