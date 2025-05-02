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
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_2 -p 20 -st topic129_0_1 -pt None -u 0.0018102781504373833 > ./result_6chains/node129_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_2 -p 335 -st topic129_1_1 -pt None -u 0.032356558976328775 > ./result_6chains/node129_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_2 -p 392 -st topic129_2_1 -pt None -u 0.0024740209330134655 > ./result_6chains/node129_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_2 -p 519 -st topic129_3_1 -pt None -u 0.018759917281286898 > ./result_6chains/node129_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_2 -p 697 -st topic129_4_1 -pt None -u 0.00978062098493564 > ./result_6chains/node129_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_2 -p 992 -st topic129_5_1 -pt None -u 0.01142664620232787 > ./result_6chains/node129_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_0_0 -p 20 -st none -pt topic129_0_0 -u 0.08780800462638083 > ./result_6chains/node129_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_1_0 -p 335 -st none -pt topic129_1_0 -u 0.04202322729658209 > ./result_6chains/node129_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_2_0 -p 392 -st none -pt topic129_2_0 -u 0.042491097659333704 > ./result_6chains/node129_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_3_0 -p 519 -st none -pt topic129_3_0 -u 0.042234161582812096 > ./result_6chains/node129_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node129_4_0 -p 697 -st none -pt topic129_4_0 -u 0.006778138952324389 > ./result_6chains/node129_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node129_5_0 -p 992 -st none -pt topic129_5_0 -u 0.0047707537145493615 > ./result_6chains/node129_5_0.txt &
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
    "./result_6chains/node129_0_0.txt 90"
    "./result_6chains/node129_0_2.txt 90"
    "./result_6chains/node129_1_0.txt 89"
    "./result_6chains/node129_1_2.txt 89"
    "./result_6chains/node129_2_0.txt 88"
    "./result_6chains/node129_2_2.txt 88"
    "./result_6chains/node129_3_0.txt 87"
    "./result_6chains/node129_3_2.txt 87"
    "./result_6chains/node129_4_0.txt 86"
    "./result_6chains/node129_4_2.txt 86"
    "./result_6chains/node129_5_0.txt 85"
    "./result_6chains/node129_5_2.txt 85"
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
