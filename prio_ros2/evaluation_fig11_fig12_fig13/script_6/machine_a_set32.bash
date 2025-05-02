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
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_2 -p 39 -st topic32_0_1 -pt None -u 0.09563330636300627 > ./result_6chains/node32_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_2 -p 275 -st topic32_1_1 -pt None -u 0.006440091778041501 > ./result_6chains/node32_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_2 -p 353 -st topic32_2_1 -pt None -u 0.01463620690907702 > ./result_6chains/node32_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_2 -p 484 -st topic32_3_1 -pt None -u 0.0582082953882998 > ./result_6chains/node32_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_2 -p 560 -st topic32_4_1 -pt None -u 0.02009351875391634 > ./result_6chains/node32_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_2 -p 661 -st topic32_5_1 -pt None -u 0.01198750794500064 > ./result_6chains/node32_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_0 -p 39 -st none -pt topic32_0_0 -u 0.018403038315834563 > ./result_6chains/node32_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_0 -p 275 -st none -pt topic32_1_0 -u 0.035092975138131144 > ./result_6chains/node32_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_0 -p 353 -st none -pt topic32_2_0 -u 0.0038309137376437707 > ./result_6chains/node32_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_0 -p 484 -st none -pt topic32_3_0 -u 0.015599136667304059 > ./result_6chains/node32_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_0 -p 560 -st none -pt topic32_4_0 -u 0.12350123293927984 > ./result_6chains/node32_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_0 -p 661 -st none -pt topic32_5_0 -u 0.008799920035046475 > ./result_6chains/node32_5_0.txt &
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
    "./result_6chains/node32_0_0.txt 90"
    "./result_6chains/node32_0_2.txt 90"
    "./result_6chains/node32_1_0.txt 89"
    "./result_6chains/node32_1_2.txt 89"
    "./result_6chains/node32_2_0.txt 88"
    "./result_6chains/node32_2_2.txt 88"
    "./result_6chains/node32_3_0.txt 87"
    "./result_6chains/node32_3_2.txt 87"
    "./result_6chains/node32_4_0.txt 86"
    "./result_6chains/node32_4_2.txt 86"
    "./result_6chains/node32_5_0.txt 85"
    "./result_6chains/node32_5_2.txt 85"
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
