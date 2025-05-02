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
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_1 -p 25 -st topic470_0_0 -pt topic470_0_1 -u 0.01407069099054592 > ./result_8chains/node470_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_1 -p 154 -st topic470_1_0 -pt topic470_1_1 -u 0.02081431825800273 > ./result_8chains/node470_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_1 -p 166 -st topic470_2_0 -pt topic470_2_1 -u 0.03926255659077149 > ./result_8chains/node470_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_1 -p 223 -st topic470_3_0 -pt topic470_3_1 -u 0.028043630535343478 > ./result_8chains/node470_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_1 -p 334 -st topic470_4_0 -pt topic470_4_1 -u 0.011696166304540734 > ./result_8chains/node470_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_1 -p 638 -st topic470_5_0 -pt topic470_5_1 -u 0.0038313433691440635 > ./result_8chains/node470_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_6_1 -p 792 -st topic470_6_0 -pt topic470_6_1 -u 0.0200361097578632 > ./result_8chains/node470_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_7_1 -p 847 -st topic470_7_0 -pt topic470_7_1 -u 0.0007198054741008771 > ./result_8chains/node470_7_1.txt &
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
    "./result_8chains/node470_0_1.txt 90"
    "./result_8chains/node470_1_1.txt 89"
    "./result_8chains/node470_2_1.txt 88"
    "./result_8chains/node470_3_1.txt 87"
    "./result_8chains/node470_4_1.txt 86"
    "./result_8chains/node470_5_1.txt 85"
    "./result_8chains/node470_6_1.txt 84"
    "./result_8chains/node470_7_1.txt 83"
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
