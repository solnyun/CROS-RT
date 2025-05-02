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
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_2 -p 79 -st topic346_0_1 -pt None -u 0.025727782990532022 > ./result_6chains/node346_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_2 -p 184 -st topic346_1_1 -pt None -u 0.000143420438105335 > ./result_6chains/node346_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_2 -p 287 -st topic346_2_1 -pt None -u 0.040446102191468214 > ./result_6chains/node346_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_2 -p 673 -st topic346_3_1 -pt None -u 0.023011219326141585 > ./result_6chains/node346_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_2 -p 696 -st topic346_4_1 -pt None -u 0.02238996559453775 > ./result_6chains/node346_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_2 -p 893 -st topic346_5_1 -pt None -u 0.02235600475443991 > ./result_6chains/node346_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_0 -p 79 -st none -pt topic346_0_0 -u 0.04540499521016195 > ./result_6chains/node346_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_0 -p 184 -st none -pt topic346_1_0 -u 0.012563439474232718 > ./result_6chains/node346_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_0 -p 287 -st none -pt topic346_2_0 -u 0.016092225499243107 > ./result_6chains/node346_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_0 -p 673 -st none -pt topic346_3_0 -u 0.02543915542659264 > ./result_6chains/node346_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_0 -p 696 -st none -pt topic346_4_0 -u 7.820678810083193e-06 > ./result_6chains/node346_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_0 -p 893 -st none -pt topic346_5_0 -u 0.012423414525892046 > ./result_6chains/node346_5_0.txt &
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
    "./result_6chains/node346_0_0.txt 90"
    "./result_6chains/node346_0_2.txt 90"
    "./result_6chains/node346_1_0.txt 89"
    "./result_6chains/node346_1_2.txt 89"
    "./result_6chains/node346_2_0.txt 88"
    "./result_6chains/node346_2_2.txt 88"
    "./result_6chains/node346_3_0.txt 87"
    "./result_6chains/node346_3_2.txt 87"
    "./result_6chains/node346_4_0.txt 86"
    "./result_6chains/node346_4_2.txt 86"
    "./result_6chains/node346_5_0.txt 85"
    "./result_6chains/node346_5_2.txt 85"
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
