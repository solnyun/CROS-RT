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
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_2 -p 184 -st topic60_0_1 -pt None -u 0.009534154240431192 > ./result_6chains/node60_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_2 -p 318 -st topic60_1_1 -pt None -u 0.004282778194738324 > ./result_6chains/node60_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_2 -p 653 -st topic60_2_1 -pt None -u 0.007508115935678045 > ./result_6chains/node60_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_2 -p 670 -st topic60_3_1 -pt None -u 0.03637084452662523 > ./result_6chains/node60_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_2 -p 744 -st topic60_4_1 -pt None -u 0.053981280005907226 > ./result_6chains/node60_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_2 -p 767 -st topic60_5_1 -pt None -u 0.04356586590088834 > ./result_6chains/node60_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_0 -p 184 -st none -pt topic60_0_0 -u 0.010595324472183865 > ./result_6chains/node60_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_0 -p 318 -st none -pt topic60_1_0 -u 0.058694374457350595 > ./result_6chains/node60_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_0 -p 653 -st none -pt topic60_2_0 -u 0.11887825800090304 > ./result_6chains/node60_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_0 -p 670 -st none -pt topic60_3_0 -u 0.002392888171607266 > ./result_6chains/node60_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_0 -p 744 -st none -pt topic60_4_0 -u 0.016731792085139113 > ./result_6chains/node60_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_0 -p 767 -st none -pt topic60_5_0 -u 0.002821362079368568 > ./result_6chains/node60_5_0.txt &
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
    "./result_6chains/node60_0_0.txt 90"
    "./result_6chains/node60_0_2.txt 90"
    "./result_6chains/node60_1_0.txt 89"
    "./result_6chains/node60_1_2.txt 89"
    "./result_6chains/node60_2_0.txt 88"
    "./result_6chains/node60_2_2.txt 88"
    "./result_6chains/node60_3_0.txt 87"
    "./result_6chains/node60_3_2.txt 87"
    "./result_6chains/node60_4_0.txt 86"
    "./result_6chains/node60_4_2.txt 86"
    "./result_6chains/node60_5_0.txt 85"
    "./result_6chains/node60_5_2.txt 85"
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
