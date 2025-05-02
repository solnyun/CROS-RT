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
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_2 -p 17 -st topic190_0_1 -pt None -u 0.020654546047593925 > ./result_6chains/node190_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_2 -p 99 -st topic190_1_1 -pt None -u 0.055744252381944304 > ./result_6chains/node190_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_2 -p 277 -st topic190_2_1 -pt None -u 0.021004704870071833 > ./result_6chains/node190_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_2 -p 296 -st topic190_3_1 -pt None -u 0.01662910541999149 > ./result_6chains/node190_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_2 -p 448 -st topic190_4_1 -pt None -u 0.005687122284434756 > ./result_6chains/node190_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_2 -p 503 -st topic190_5_1 -pt None -u 0.002300214597299104 > ./result_6chains/node190_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_0 -p 17 -st none -pt topic190_0_0 -u 0.015892166833901378 > ./result_6chains/node190_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_0 -p 99 -st none -pt topic190_1_0 -u 0.016824553589704194 > ./result_6chains/node190_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_0 -p 277 -st none -pt topic190_2_0 -u 0.03064794423993894 > ./result_6chains/node190_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_0 -p 296 -st none -pt topic190_3_0 -u 0.027675377397252926 > ./result_6chains/node190_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_0 -p 448 -st none -pt topic190_4_0 -u 0.012562889449067832 > ./result_6chains/node190_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_0 -p 503 -st none -pt topic190_5_0 -u 0.08233268195672405 > ./result_6chains/node190_5_0.txt &
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
    "./result_6chains/node190_0_0.txt 90"
    "./result_6chains/node190_0_2.txt 90"
    "./result_6chains/node190_1_0.txt 89"
    "./result_6chains/node190_1_2.txt 89"
    "./result_6chains/node190_2_0.txt 88"
    "./result_6chains/node190_2_2.txt 88"
    "./result_6chains/node190_3_0.txt 87"
    "./result_6chains/node190_3_2.txt 87"
    "./result_6chains/node190_4_0.txt 86"
    "./result_6chains/node190_4_2.txt 86"
    "./result_6chains/node190_5_0.txt 85"
    "./result_6chains/node190_5_2.txt 85"
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
