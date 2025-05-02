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
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_2 -p 173 -st topic144_0_1 -pt None -u 0.0675108554436788 > ./result_6chains/node144_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_2 -p 236 -st topic144_1_1 -pt None -u 0.0074397741773962744 > ./result_6chains/node144_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_2 -p 490 -st topic144_2_1 -pt None -u 0.07349512428346541 > ./result_6chains/node144_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_2 -p 778 -st topic144_3_1 -pt None -u 0.015430921802757291 > ./result_6chains/node144_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_2 -p 901 -st topic144_4_1 -pt None -u 0.0022305711833158215 > ./result_6chains/node144_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_2 -p 959 -st topic144_5_1 -pt None -u 0.02379246522081662 > ./result_6chains/node144_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_0 -p 173 -st none -pt topic144_0_0 -u 0.009775688923877202 > ./result_6chains/node144_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_0 -p 236 -st none -pt topic144_1_0 -u 0.00730379362206679 > ./result_6chains/node144_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_0 -p 490 -st none -pt topic144_2_0 -u 0.019889281995268515 > ./result_6chains/node144_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_0 -p 778 -st none -pt topic144_3_0 -u 0.016262469065432217 > ./result_6chains/node144_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_0 -p 901 -st none -pt topic144_4_0 -u 0.10615038334359818 > ./result_6chains/node144_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_0 -p 959 -st none -pt topic144_5_0 -u 0.01879580340041106 > ./result_6chains/node144_5_0.txt &
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
    "./result_6chains/node144_0_0.txt 90"
    "./result_6chains/node144_0_2.txt 90"
    "./result_6chains/node144_1_0.txt 89"
    "./result_6chains/node144_1_2.txt 89"
    "./result_6chains/node144_2_0.txt 88"
    "./result_6chains/node144_2_2.txt 88"
    "./result_6chains/node144_3_0.txt 87"
    "./result_6chains/node144_3_2.txt 87"
    "./result_6chains/node144_4_0.txt 86"
    "./result_6chains/node144_4_2.txt 86"
    "./result_6chains/node144_5_0.txt 85"
    "./result_6chains/node144_5_2.txt 85"
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
