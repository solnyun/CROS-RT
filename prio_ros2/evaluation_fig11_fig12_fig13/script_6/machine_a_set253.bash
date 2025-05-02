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
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_2 -p 141 -st topic253_0_1 -pt None -u 0.00958302707925901 > ./result_6chains/node253_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_2 -p 330 -st topic253_1_1 -pt None -u 0.0006067527368091019 > ./result_6chains/node253_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_2 -p 372 -st topic253_2_1 -pt None -u 0.11877196970017728 > ./result_6chains/node253_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_2 -p 500 -st topic253_3_1 -pt None -u 0.010179750754950201 > ./result_6chains/node253_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_2 -p 550 -st topic253_4_1 -pt None -u 0.037554097388773175 > ./result_6chains/node253_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_2 -p 803 -st topic253_5_1 -pt None -u 0.008134571043814362 > ./result_6chains/node253_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_0 -p 141 -st none -pt topic253_0_0 -u 0.026345562454215765 > ./result_6chains/node253_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_0 -p 330 -st none -pt topic253_1_0 -u 0.04189711114359279 > ./result_6chains/node253_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_0 -p 372 -st none -pt topic253_2_0 -u 0.0006213016116454195 > ./result_6chains/node253_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_0 -p 500 -st none -pt topic253_3_0 -u 0.06123514004608607 > ./result_6chains/node253_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_0 -p 550 -st none -pt topic253_4_0 -u 0.02407983286200832 > ./result_6chains/node253_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_0 -p 803 -st none -pt topic253_5_0 -u 0.0021376148811779044 > ./result_6chains/node253_5_0.txt &
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
    "./result_6chains/node253_0_0.txt 90"
    "./result_6chains/node253_0_2.txt 90"
    "./result_6chains/node253_1_0.txt 89"
    "./result_6chains/node253_1_2.txt 89"
    "./result_6chains/node253_2_0.txt 88"
    "./result_6chains/node253_2_2.txt 88"
    "./result_6chains/node253_3_0.txt 87"
    "./result_6chains/node253_3_2.txt 87"
    "./result_6chains/node253_4_0.txt 86"
    "./result_6chains/node253_4_2.txt 86"
    "./result_6chains/node253_5_0.txt 85"
    "./result_6chains/node253_5_2.txt 85"
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
