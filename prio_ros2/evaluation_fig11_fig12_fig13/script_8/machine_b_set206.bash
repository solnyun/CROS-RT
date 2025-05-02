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
ros2 run evaluation_3_randomdag uunifast_node -n node206_0_1 -p 248 -st topic206_0_0 -pt topic206_0_1 -u 0.008249029857732793 > ./result_8chains/node206_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_1_1 -p 430 -st topic206_1_0 -pt topic206_1_1 -u 0.012887833187536557 > ./result_8chains/node206_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_2_1 -p 446 -st topic206_2_0 -pt topic206_2_1 -u 0.07863556854731296 > ./result_8chains/node206_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_3_1 -p 484 -st topic206_3_0 -pt topic206_3_1 -u 0.005956758559346742 > ./result_8chains/node206_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_4_1 -p 538 -st topic206_4_0 -pt topic206_4_1 -u 0.004308588740863817 > ./result_8chains/node206_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_5_1 -p 556 -st topic206_5_0 -pt topic206_5_1 -u 0.011508064204853202 > ./result_8chains/node206_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_6_1 -p 627 -st topic206_6_0 -pt topic206_6_1 -u 0.02832323381531647 > ./result_8chains/node206_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_7_1 -p 684 -st topic206_7_0 -pt topic206_7_1 -u 0.004880302324794465 > ./result_8chains/node206_7_1.txt &
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
    "./result_8chains/node206_0_1.txt 90"
    "./result_8chains/node206_1_1.txt 89"
    "./result_8chains/node206_2_1.txt 88"
    "./result_8chains/node206_3_1.txt 87"
    "./result_8chains/node206_4_1.txt 86"
    "./result_8chains/node206_5_1.txt 85"
    "./result_8chains/node206_6_1.txt 84"
    "./result_8chains/node206_7_1.txt 83"
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
