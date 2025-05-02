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
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_2 -p 198 -st topic450_0_1 -pt None -u 0.1257420860651831 > ./result_4chains/node450_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_2 -p 364 -st topic450_1_1 -pt None -u 0.0007526849561033389 > ./result_4chains/node450_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_2 -p 816 -st topic450_2_1 -pt None -u 0.09834489728394238 > ./result_4chains/node450_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_2 -p 884 -st topic450_3_1 -pt None -u 0.031669228540885525 > ./result_4chains/node450_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_0 -p 198 -st none -pt topic450_0_0 -u 0.05166596822270081 > ./result_4chains/node450_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_0 -p 364 -st none -pt topic450_1_0 -u 0.0698938744395241 > ./result_4chains/node450_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_0 -p 816 -st none -pt topic450_2_0 -u 0.006123501233481765 > ./result_4chains/node450_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_0 -p 884 -st none -pt topic450_3_0 -u 0.02062374241702944 > ./result_4chains/node450_3_0.txt &
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
    "./result_4chains/node450_0_0.txt 90"
    "./result_4chains/node450_0_2.txt 90"
    "./result_4chains/node450_1_0.txt 89"
    "./result_4chains/node450_1_2.txt 89"
    "./result_4chains/node450_2_0.txt 88"
    "./result_4chains/node450_2_2.txt 88"
    "./result_4chains/node450_3_0.txt 87"
    "./result_4chains/node450_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
