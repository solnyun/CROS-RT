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
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_2 -p 83 -st topic432_0_1 -pt None -u 0.010232072539960113 > ./result_8chains/node432_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_2 -p 151 -st topic432_1_1 -pt None -u 0.002917451482830735 > ./result_8chains/node432_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_2 -p 388 -st topic432_2_1 -pt None -u 0.006636530738258539 > ./result_8chains/node432_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_2 -p 640 -st topic432_3_1 -pt None -u 0.007520692978211507 > ./result_8chains/node432_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_2 -p 815 -st topic432_4_1 -pt None -u 0.003526229005270609 > ./result_8chains/node432_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_2 -p 818 -st topic432_5_1 -pt None -u 0.04743925017560481 > ./result_8chains/node432_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_6_2 -p 872 -st topic432_6_1 -pt None -u 0.003152918141937397 > ./result_8chains/node432_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_7_2 -p 919 -st topic432_7_1 -pt None -u 0.010599346503624723 > ./result_8chains/node432_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_0 -p 83 -st none -pt topic432_0_0 -u 0.04884022317489689 > ./result_8chains/node432_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_0 -p 151 -st none -pt topic432_1_0 -u 0.00805359622651014 > ./result_8chains/node432_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_0 -p 388 -st none -pt topic432_2_0 -u 0.016915397533074972 > ./result_8chains/node432_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_0 -p 640 -st none -pt topic432_3_0 -u 0.0012252705549216092 > ./result_8chains/node432_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_0 -p 815 -st none -pt topic432_4_0 -u 0.0014162803266464796 > ./result_8chains/node432_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_0 -p 818 -st none -pt topic432_5_0 -u 0.018785941868899175 > ./result_8chains/node432_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_6_0 -p 872 -st none -pt topic432_6_0 -u 0.028095507816826196 > ./result_8chains/node432_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_7_0 -p 919 -st none -pt topic432_7_0 -u 0.04387441406414399 > ./result_8chains/node432_7_0.txt &
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
    "./result_8chains/node432_0_0.txt 90"
    "./result_8chains/node432_0_2.txt 90"
    "./result_8chains/node432_1_0.txt 89"
    "./result_8chains/node432_1_2.txt 89"
    "./result_8chains/node432_2_0.txt 88"
    "./result_8chains/node432_2_2.txt 88"
    "./result_8chains/node432_3_0.txt 87"
    "./result_8chains/node432_3_2.txt 87"
    "./result_8chains/node432_4_0.txt 86"
    "./result_8chains/node432_4_2.txt 86"
    "./result_8chains/node432_5_0.txt 85"
    "./result_8chains/node432_5_2.txt 85"
    "./result_8chains/node432_6_0.txt 84"
    "./result_8chains/node432_6_2.txt 84"
    "./result_8chains/node432_7_0.txt 83"
    "./result_8chains/node432_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
