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
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_2 -p 330 -st topic101_0_1 -pt None -u 0.005323400238668563 > ./result_6chains/node101_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_2 -p 376 -st topic101_1_1 -pt None -u 0.00620970035552465 > ./result_6chains/node101_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_2 -p 804 -st topic101_2_1 -pt None -u 0.004073435312622664 > ./result_6chains/node101_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_2 -p 824 -st topic101_3_1 -pt None -u 0.011246680624485583 > ./result_6chains/node101_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_2 -p 902 -st topic101_4_1 -pt None -u 0.02929393472066666 > ./result_6chains/node101_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_2 -p 940 -st topic101_5_1 -pt None -u 0.014189946469264966 > ./result_6chains/node101_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_0 -p 330 -st none -pt topic101_0_0 -u 0.002798891264227832 > ./result_6chains/node101_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_0 -p 376 -st none -pt topic101_1_0 -u 0.03300916319110431 > ./result_6chains/node101_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_0 -p 804 -st none -pt topic101_2_0 -u 0.0226670483737757 > ./result_6chains/node101_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_0 -p 824 -st none -pt topic101_3_0 -u 0.0864676965081147 > ./result_6chains/node101_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_0 -p 902 -st none -pt topic101_4_0 -u 0.0020620898058828496 > ./result_6chains/node101_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_0 -p 940 -st none -pt topic101_5_0 -u 0.01952778409756009 > ./result_6chains/node101_5_0.txt &
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
    "./result_6chains/node101_0_0.txt 90"
    "./result_6chains/node101_0_2.txt 90"
    "./result_6chains/node101_1_0.txt 89"
    "./result_6chains/node101_1_2.txt 89"
    "./result_6chains/node101_2_0.txt 88"
    "./result_6chains/node101_2_2.txt 88"
    "./result_6chains/node101_3_0.txt 87"
    "./result_6chains/node101_3_2.txt 87"
    "./result_6chains/node101_4_0.txt 86"
    "./result_6chains/node101_4_2.txt 86"
    "./result_6chains/node101_5_0.txt 85"
    "./result_6chains/node101_5_2.txt 85"
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
