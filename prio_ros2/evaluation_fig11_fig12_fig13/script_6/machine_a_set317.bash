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
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_2 -p 152 -st topic317_0_1 -pt None -u 0.053304263245664896 > ./result_6chains/node317_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_2 -p 203 -st topic317_1_1 -pt None -u 0.006882666337411358 > ./result_6chains/node317_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_2 -p 491 -st topic317_2_1 -pt None -u 0.03989526324141138 > ./result_6chains/node317_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_2 -p 615 -st topic317_3_1 -pt None -u 0.057898076045882874 > ./result_6chains/node317_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_2 -p 652 -st topic317_4_1 -pt None -u 0.004153417945079632 > ./result_6chains/node317_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_2 -p 919 -st topic317_5_1 -pt None -u 0.02036884385087678 > ./result_6chains/node317_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_0_0 -p 152 -st none -pt topic317_0_0 -u 0.008062759422707344 > ./result_6chains/node317_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_1_0 -p 203 -st none -pt topic317_1_0 -u 0.026853778794372396 > ./result_6chains/node317_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_2_0 -p 491 -st none -pt topic317_2_0 -u 0.05166291288385788 > ./result_6chains/node317_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_3_0 -p 615 -st none -pt topic317_3_0 -u 0.01982761168290914 > ./result_6chains/node317_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node317_4_0 -p 652 -st none -pt topic317_4_0 -u 0.031316383036063364 > ./result_6chains/node317_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node317_5_0 -p 919 -st none -pt topic317_5_0 -u 0.010214253693345794 > ./result_6chains/node317_5_0.txt &
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
    "./result_6chains/node317_0_0.txt 90"
    "./result_6chains/node317_0_2.txt 90"
    "./result_6chains/node317_1_0.txt 89"
    "./result_6chains/node317_1_2.txt 89"
    "./result_6chains/node317_2_0.txt 88"
    "./result_6chains/node317_2_2.txt 88"
    "./result_6chains/node317_3_0.txt 87"
    "./result_6chains/node317_3_2.txt 87"
    "./result_6chains/node317_4_0.txt 86"
    "./result_6chains/node317_4_2.txt 86"
    "./result_6chains/node317_5_0.txt 85"
    "./result_6chains/node317_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
