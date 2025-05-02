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
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_2 -p 138 -st topic444_0_1 -pt None -u 0.051068886032713534 > ./result_6chains/node444_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_2 -p 246 -st topic444_1_1 -pt None -u 0.015729640921810784 > ./result_6chains/node444_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_2 -p 302 -st topic444_2_1 -pt None -u 0.010633653713344016 > ./result_6chains/node444_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_2 -p 460 -st topic444_3_1 -pt None -u 0.019643683006957624 > ./result_6chains/node444_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_2 -p 607 -st topic444_4_1 -pt None -u 0.008423494563246245 > ./result_6chains/node444_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_2 -p 673 -st topic444_5_1 -pt None -u 0.05452169321980413 > ./result_6chains/node444_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_0 -p 138 -st none -pt topic444_0_0 -u 0.08148607959860976 > ./result_6chains/node444_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_0 -p 246 -st none -pt topic444_1_0 -u 0.019675483608109834 > ./result_6chains/node444_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_0 -p 302 -st none -pt topic444_2_0 -u 0.01138373762077749 > ./result_6chains/node444_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_0 -p 460 -st none -pt topic444_3_0 -u 0.020265356528805845 > ./result_6chains/node444_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_0 -p 607 -st none -pt topic444_4_0 -u 0.019767045157812427 > ./result_6chains/node444_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_0 -p 673 -st none -pt topic444_5_0 -u 0.005705199333838673 > ./result_6chains/node444_5_0.txt &
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
    "./result_6chains/node444_0_0.txt 90"
    "./result_6chains/node444_0_2.txt 90"
    "./result_6chains/node444_1_0.txt 89"
    "./result_6chains/node444_1_2.txt 89"
    "./result_6chains/node444_2_0.txt 88"
    "./result_6chains/node444_2_2.txt 88"
    "./result_6chains/node444_3_0.txt 87"
    "./result_6chains/node444_3_2.txt 87"
    "./result_6chains/node444_4_0.txt 86"
    "./result_6chains/node444_4_2.txt 86"
    "./result_6chains/node444_5_0.txt 85"
    "./result_6chains/node444_5_2.txt 85"
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
