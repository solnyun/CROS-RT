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
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_1 -p 16 -st topic304_0_0 -pt topic304_0_1 -u 0.010110105151671878 > ./result_8chains/node304_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_1 -p 83 -st topic304_1_0 -pt topic304_1_1 -u 0.009383863171929352 > ./result_8chains/node304_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_1 -p 162 -st topic304_2_0 -pt topic304_2_1 -u 0.0011591243941114215 > ./result_8chains/node304_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_1 -p 303 -st topic304_3_0 -pt topic304_3_1 -u 0.014856907236375727 > ./result_8chains/node304_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_1 -p 397 -st topic304_4_0 -pt topic304_4_1 -u 0.009139170607471714 > ./result_8chains/node304_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_1 -p 514 -st topic304_5_0 -pt topic304_5_1 -u 0.0671155979573806 > ./result_8chains/node304_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_6_1 -p 524 -st topic304_6_0 -pt topic304_6_1 -u 0.018171567347168148 > ./result_8chains/node304_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_7_1 -p 728 -st topic304_7_0 -pt topic304_7_1 -u 0.011052133099728797 > ./result_8chains/node304_7_1.txt &
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
    "./result_8chains/node304_0_1.txt 90"
    "./result_8chains/node304_1_1.txt 89"
    "./result_8chains/node304_2_1.txt 88"
    "./result_8chains/node304_3_1.txt 87"
    "./result_8chains/node304_4_1.txt 86"
    "./result_8chains/node304_5_1.txt 85"
    "./result_8chains/node304_6_1.txt 84"
    "./result_8chains/node304_7_1.txt 83"
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
