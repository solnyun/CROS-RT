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
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_2 -p 189 -st topic353_0_1 -pt None -u 0.0448753513895806 > ./result_6chains/node353_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_2 -p 569 -st topic353_1_1 -pt None -u 0.000697160522125706 > ./result_6chains/node353_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_2 -p 622 -st topic353_2_1 -pt None -u 0.0065031918484353 > ./result_6chains/node353_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_2 -p 691 -st topic353_3_1 -pt None -u 0.006960271490026648 > ./result_6chains/node353_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_2 -p 821 -st topic353_4_1 -pt None -u 0.015446876165926507 > ./result_6chains/node353_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_2 -p 854 -st topic353_5_1 -pt None -u 0.03164131518733925 > ./result_6chains/node353_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_0 -p 189 -st none -pt topic353_0_0 -u 0.034973854510422286 > ./result_6chains/node353_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_0 -p 569 -st none -pt topic353_1_0 -u 0.019338714678711788 > ./result_6chains/node353_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_0 -p 622 -st none -pt topic353_2_0 -u 0.07108203891285533 > ./result_6chains/node353_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_0 -p 691 -st none -pt topic353_3_0 -u 0.008721794092209897 > ./result_6chains/node353_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_0 -p 821 -st none -pt topic353_4_0 -u 0.009398894000041721 > ./result_6chains/node353_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_0 -p 854 -st none -pt topic353_5_0 -u 0.01602898430956553 > ./result_6chains/node353_5_0.txt &
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
    "./result_6chains/node353_0_0.txt 90"
    "./result_6chains/node353_0_2.txt 90"
    "./result_6chains/node353_1_0.txt 89"
    "./result_6chains/node353_1_2.txt 89"
    "./result_6chains/node353_2_0.txt 88"
    "./result_6chains/node353_2_2.txt 88"
    "./result_6chains/node353_3_0.txt 87"
    "./result_6chains/node353_3_2.txt 87"
    "./result_6chains/node353_4_0.txt 86"
    "./result_6chains/node353_4_2.txt 86"
    "./result_6chains/node353_5_0.txt 85"
    "./result_6chains/node353_5_2.txt 85"
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
