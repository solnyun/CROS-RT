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
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_2 -p 70 -st topic45_0_1 -pt None -u 0.0024060051243586233 > ./result_6chains/node45_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_2 -p 154 -st topic45_1_1 -pt None -u 0.04996944983962931 > ./result_6chains/node45_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_2 -p 159 -st topic45_2_1 -pt None -u 0.011327282050353993 > ./result_6chains/node45_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_2 -p 447 -st topic45_3_1 -pt None -u 0.02311562433329556 > ./result_6chains/node45_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_2 -p 856 -st topic45_4_1 -pt None -u 0.0009138765220278733 > ./result_6chains/node45_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_2 -p 866 -st topic45_5_1 -pt None -u 8.446137850698628e-06 > ./result_6chains/node45_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_0 -p 70 -st none -pt topic45_0_0 -u 0.04038827033197295 > ./result_6chains/node45_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_0 -p 154 -st none -pt topic45_1_0 -u 0.0031974969712530443 > ./result_6chains/node45_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_0 -p 159 -st none -pt topic45_2_0 -u 0.015399837533669025 > ./result_6chains/node45_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_0 -p 447 -st none -pt topic45_3_0 -u 0.09559759312369354 > ./result_6chains/node45_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_0 -p 856 -st none -pt topic45_4_0 -u 0.031516460032565474 > ./result_6chains/node45_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_0 -p 866 -st none -pt topic45_5_0 -u 0.107435093760619 > ./result_6chains/node45_5_0.txt &
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
    "./result_6chains/node45_0_0.txt 90"
    "./result_6chains/node45_0_2.txt 90"
    "./result_6chains/node45_1_0.txt 89"
    "./result_6chains/node45_1_2.txt 89"
    "./result_6chains/node45_2_0.txt 88"
    "./result_6chains/node45_2_2.txt 88"
    "./result_6chains/node45_3_0.txt 87"
    "./result_6chains/node45_3_2.txt 87"
    "./result_6chains/node45_4_0.txt 86"
    "./result_6chains/node45_4_2.txt 86"
    "./result_6chains/node45_5_0.txt 85"
    "./result_6chains/node45_5_2.txt 85"
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
