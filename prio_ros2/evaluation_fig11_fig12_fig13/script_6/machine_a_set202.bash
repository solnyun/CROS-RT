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
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_2 -p 282 -st topic202_0_1 -pt None -u 0.09767690810538732 > ./result_6chains/node202_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_2 -p 351 -st topic202_1_1 -pt None -u 0.03830200500837749 > ./result_6chains/node202_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_2 -p 518 -st topic202_2_1 -pt None -u 0.017583763144568776 > ./result_6chains/node202_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_2 -p 654 -st topic202_3_1 -pt None -u 0.0045119239927879085 > ./result_6chains/node202_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_2 -p 816 -st topic202_4_1 -pt None -u 0.007744977345902501 > ./result_6chains/node202_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_2 -p 878 -st topic202_5_1 -pt None -u 0.01992067306764357 > ./result_6chains/node202_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_0 -p 282 -st none -pt topic202_0_0 -u 0.004182035842179965 > ./result_6chains/node202_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_0 -p 351 -st none -pt topic202_1_0 -u 0.015216026627986934 > ./result_6chains/node202_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_0 -p 518 -st none -pt topic202_2_0 -u 0.03518157003796074 > ./result_6chains/node202_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_0 -p 654 -st none -pt topic202_3_0 -u 0.009084865246496737 > ./result_6chains/node202_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_0 -p 816 -st none -pt topic202_4_0 -u 0.018627666382037195 > ./result_6chains/node202_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_0 -p 878 -st none -pt topic202_5_0 -u 0.016144658915212537 > ./result_6chains/node202_5_0.txt &
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
    "./result_6chains/node202_0_0.txt 90"
    "./result_6chains/node202_0_2.txt 90"
    "./result_6chains/node202_1_0.txt 89"
    "./result_6chains/node202_1_2.txt 89"
    "./result_6chains/node202_2_0.txt 88"
    "./result_6chains/node202_2_2.txt 88"
    "./result_6chains/node202_3_0.txt 87"
    "./result_6chains/node202_3_2.txt 87"
    "./result_6chains/node202_4_0.txt 86"
    "./result_6chains/node202_4_2.txt 86"
    "./result_6chains/node202_5_0.txt 85"
    "./result_6chains/node202_5_2.txt 85"
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
