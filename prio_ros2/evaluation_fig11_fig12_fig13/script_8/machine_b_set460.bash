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
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_1 -p 89 -st topic460_0_0 -pt topic460_0_1 -u 0.0052610172655482845 > ./result_8chains/node460_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_1 -p 234 -st topic460_1_0 -pt topic460_1_1 -u 0.036398847726253014 > ./result_8chains/node460_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_1 -p 333 -st topic460_2_0 -pt topic460_2_1 -u 0.025629511561641116 > ./result_8chains/node460_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_1 -p 408 -st topic460_3_0 -pt topic460_3_1 -u 0.030187735761407153 > ./result_8chains/node460_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_1 -p 426 -st topic460_4_0 -pt topic460_4_1 -u 0.011485528281278745 > ./result_8chains/node460_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_1 -p 568 -st topic460_5_0 -pt topic460_5_1 -u 0.01494993481336232 > ./result_8chains/node460_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_6_1 -p 662 -st topic460_6_0 -pt topic460_6_1 -u 0.04851847196792376 > ./result_8chains/node460_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_7_1 -p 708 -st topic460_7_0 -pt topic460_7_1 -u 0.04013179721727591 > ./result_8chains/node460_7_1.txt &
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
    "./result_8chains/node460_0_1.txt 90"
    "./result_8chains/node460_1_1.txt 89"
    "./result_8chains/node460_2_1.txt 88"
    "./result_8chains/node460_3_1.txt 87"
    "./result_8chains/node460_4_1.txt 86"
    "./result_8chains/node460_5_1.txt 85"
    "./result_8chains/node460_6_1.txt 84"
    "./result_8chains/node460_7_1.txt 83"
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
