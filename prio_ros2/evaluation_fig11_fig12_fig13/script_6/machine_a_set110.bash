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
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_2 -p 197 -st topic110_0_1 -pt None -u 0.004057346035735765 > ./result_6chains/node110_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_2 -p 237 -st topic110_1_1 -pt None -u 0.05947509656074618 > ./result_6chains/node110_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_2 -p 244 -st topic110_2_1 -pt None -u 0.014373399278438836 > ./result_6chains/node110_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_2 -p 642 -st topic110_3_1 -pt None -u 0.05505402826202588 > ./result_6chains/node110_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_2 -p 665 -st topic110_4_1 -pt None -u 0.01919358222384386 > ./result_6chains/node110_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_2 -p 724 -st topic110_5_1 -pt None -u 0.009499246805358142 > ./result_6chains/node110_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_0 -p 197 -st none -pt topic110_0_0 -u 0.05028352440976974 > ./result_6chains/node110_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_0 -p 237 -st none -pt topic110_1_0 -u 0.010042267877817757 > ./result_6chains/node110_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_0 -p 244 -st none -pt topic110_2_0 -u 0.01894048322504155 > ./result_6chains/node110_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_0 -p 642 -st none -pt topic110_3_0 -u 0.0018717393282017825 > ./result_6chains/node110_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_0 -p 665 -st none -pt topic110_4_0 -u 0.03670089515352182 > ./result_6chains/node110_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_0 -p 724 -st none -pt topic110_5_0 -u 0.05182784212341803 > ./result_6chains/node110_5_0.txt &
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
    "./result_6chains/node110_0_0.txt 90"
    "./result_6chains/node110_0_2.txt 90"
    "./result_6chains/node110_1_0.txt 89"
    "./result_6chains/node110_1_2.txt 89"
    "./result_6chains/node110_2_0.txt 88"
    "./result_6chains/node110_2_2.txt 88"
    "./result_6chains/node110_3_0.txt 87"
    "./result_6chains/node110_3_2.txt 87"
    "./result_6chains/node110_4_0.txt 86"
    "./result_6chains/node110_4_2.txt 86"
    "./result_6chains/node110_5_0.txt 85"
    "./result_6chains/node110_5_2.txt 85"
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
