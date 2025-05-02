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
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_2 -p 38 -st topic24_0_1 -pt None -u 0.018342554550112633 > ./result_6chains/node24_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_2 -p 45 -st topic24_1_1 -pt None -u 0.028823979159254776 > ./result_6chains/node24_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_2 -p 152 -st topic24_2_1 -pt None -u 0.016908610058676055 > ./result_6chains/node24_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_2 -p 155 -st topic24_3_1 -pt None -u 0.058716503870879844 > ./result_6chains/node24_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_2 -p 188 -st topic24_4_1 -pt None -u 0.06551611984908082 > ./result_6chains/node24_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_2 -p 968 -st topic24_5_1 -pt None -u 0.011285927919569132 > ./result_6chains/node24_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_0 -p 38 -st none -pt topic24_0_0 -u 0.009280641407157342 > ./result_6chains/node24_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_0 -p 45 -st none -pt topic24_1_0 -u 0.03196434279252175 > ./result_6chains/node24_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_0 -p 152 -st none -pt topic24_2_0 -u 0.04522938901725454 > ./result_6chains/node24_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_0 -p 155 -st none -pt topic24_3_0 -u 0.017645385260202706 > ./result_6chains/node24_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_0 -p 188 -st none -pt topic24_4_0 -u 0.015565848882106215 > ./result_6chains/node24_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_0 -p 968 -st none -pt topic24_5_0 -u 0.011339612915675326 > ./result_6chains/node24_5_0.txt &
sleep 10
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
    "./result_6chains/node24_0_0.txt 90"
    "./result_6chains/node24_0_2.txt 90"
    "./result_6chains/node24_1_0.txt 89"
    "./result_6chains/node24_1_2.txt 89"
    "./result_6chains/node24_2_0.txt 88"
    "./result_6chains/node24_2_2.txt 88"
    "./result_6chains/node24_3_0.txt 87"
    "./result_6chains/node24_3_2.txt 87"
    "./result_6chains/node24_4_0.txt 86"
    "./result_6chains/node24_4_2.txt 86"
    "./result_6chains/node24_5_0.txt 85"
    "./result_6chains/node24_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
