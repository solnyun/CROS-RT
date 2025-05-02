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
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_2 -p 52 -st topic462_0_1 -pt None -u 0.008791070701034798 > ./result_6chains/node462_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_2 -p 79 -st topic462_1_1 -pt None -u 0.0025347777767837365 > ./result_6chains/node462_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_2 -p 114 -st topic462_2_1 -pt None -u 0.015067085087904775 > ./result_6chains/node462_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_2 -p 380 -st topic462_3_1 -pt None -u 0.0011364415740670875 > ./result_6chains/node462_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_2 -p 407 -st topic462_4_1 -pt None -u 0.00013064011863359037 > ./result_6chains/node462_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_2 -p 981 -st topic462_5_1 -pt None -u 0.16306473096337679 > ./result_6chains/node462_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_0 -p 52 -st none -pt topic462_0_0 -u 0.004810778363989854 > ./result_6chains/node462_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_0 -p 79 -st none -pt topic462_1_0 -u 0.018838895311850845 > ./result_6chains/node462_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_0 -p 114 -st none -pt topic462_2_0 -u 0.017622475220946787 > ./result_6chains/node462_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_0 -p 380 -st none -pt topic462_3_0 -u 0.002172649412523653 > ./result_6chains/node462_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_0 -p 407 -st none -pt topic462_4_0 -u 0.018895818859269414 > ./result_6chains/node462_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_0 -p 981 -st none -pt topic462_5_0 -u 0.0037739004270251897 > ./result_6chains/node462_5_0.txt &
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
    "./result_6chains/node462_0_0.txt 90"
    "./result_6chains/node462_0_2.txt 90"
    "./result_6chains/node462_1_0.txt 89"
    "./result_6chains/node462_1_2.txt 89"
    "./result_6chains/node462_2_0.txt 88"
    "./result_6chains/node462_2_2.txt 88"
    "./result_6chains/node462_3_0.txt 87"
    "./result_6chains/node462_3_2.txt 87"
    "./result_6chains/node462_4_0.txt 86"
    "./result_6chains/node462_4_2.txt 86"
    "./result_6chains/node462_5_0.txt 85"
    "./result_6chains/node462_5_2.txt 85"
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
