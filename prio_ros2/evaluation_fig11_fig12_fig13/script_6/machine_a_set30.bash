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
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_2 -p 83 -st topic30_0_1 -pt None -u 0.034812044413823795 > ./result_6chains/node30_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_2 -p 84 -st topic30_1_1 -pt None -u 0.0007723609969919054 > ./result_6chains/node30_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_2 -p 314 -st topic30_2_1 -pt None -u 0.033642044170296814 > ./result_6chains/node30_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_2 -p 634 -st topic30_3_1 -pt None -u 0.01881828083070669 > ./result_6chains/node30_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_2 -p 779 -st topic30_4_1 -pt None -u 0.025021753899568455 > ./result_6chains/node30_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_2 -p 868 -st topic30_5_1 -pt None -u 0.032687216485119006 > ./result_6chains/node30_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_0 -p 83 -st none -pt topic30_0_0 -u 0.0024721820237436076 > ./result_6chains/node30_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_0 -p 84 -st none -pt topic30_1_0 -u 0.016225598116616502 > ./result_6chains/node30_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_0 -p 314 -st none -pt topic30_2_0 -u 0.03033357267873782 > ./result_6chains/node30_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_0 -p 634 -st none -pt topic30_3_0 -u 0.03660829505106769 > ./result_6chains/node30_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_0 -p 779 -st none -pt topic30_4_0 -u 0.014291122355309549 > ./result_6chains/node30_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_0 -p 868 -st none -pt topic30_5_0 -u 0.09399523515137996 > ./result_6chains/node30_5_0.txt &
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
    "./result_6chains/node30_0_0.txt 90"
    "./result_6chains/node30_0_2.txt 90"
    "./result_6chains/node30_1_0.txt 89"
    "./result_6chains/node30_1_2.txt 89"
    "./result_6chains/node30_2_0.txt 88"
    "./result_6chains/node30_2_2.txt 88"
    "./result_6chains/node30_3_0.txt 87"
    "./result_6chains/node30_3_2.txt 87"
    "./result_6chains/node30_4_0.txt 86"
    "./result_6chains/node30_4_2.txt 86"
    "./result_6chains/node30_5_0.txt 85"
    "./result_6chains/node30_5_2.txt 85"
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
