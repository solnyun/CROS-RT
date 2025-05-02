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
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_2 -p 135 -st topic304_0_1 -pt None -u 0.004761177049569798 > ./result_6chains/node304_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_2 -p 150 -st topic304_1_1 -pt None -u 0.010392590062585916 > ./result_6chains/node304_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_2 -p 157 -st topic304_2_1 -pt None -u 0.007149729305430924 > ./result_6chains/node304_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_2 -p 493 -st topic304_3_1 -pt None -u 0.013988581946055595 > ./result_6chains/node304_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_2 -p 708 -st topic304_4_1 -pt None -u 0.0020301933847537007 > ./result_6chains/node304_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_2 -p 812 -st topic304_5_1 -pt None -u 0.02374194058978946 > ./result_6chains/node304_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_0 -p 135 -st none -pt topic304_0_0 -u 0.012133626977825218 > ./result_6chains/node304_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_0 -p 150 -st none -pt topic304_1_0 -u 0.08957764496578946 > ./result_6chains/node304_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_0 -p 157 -st none -pt topic304_2_0 -u 0.02125817981896766 > ./result_6chains/node304_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_0 -p 493 -st none -pt topic304_3_0 -u 0.008389846887981223 > ./result_6chains/node304_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_0 -p 708 -st none -pt topic304_4_0 -u 0.000709018722670568 > ./result_6chains/node304_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_0 -p 812 -st none -pt topic304_5_0 -u 0.05509118097977523 > ./result_6chains/node304_5_0.txt &
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
    "./result_6chains/node304_0_0.txt 90"
    "./result_6chains/node304_0_2.txt 90"
    "./result_6chains/node304_1_0.txt 89"
    "./result_6chains/node304_1_2.txt 89"
    "./result_6chains/node304_2_0.txt 88"
    "./result_6chains/node304_2_2.txt 88"
    "./result_6chains/node304_3_0.txt 87"
    "./result_6chains/node304_3_2.txt 87"
    "./result_6chains/node304_4_0.txt 86"
    "./result_6chains/node304_4_2.txt 86"
    "./result_6chains/node304_5_0.txt 85"
    "./result_6chains/node304_5_2.txt 85"
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
