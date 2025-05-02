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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_2 -p 155 -st topic281_0_1 -pt None -u 0.029650871614720464 > ./result_8chains/node281_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_2 -p 168 -st topic281_1_1 -pt None -u 0.0024020126723623414 > ./result_8chains/node281_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_2 -p 358 -st topic281_2_1 -pt None -u 0.0212421633416896 > ./result_8chains/node281_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_2 -p 502 -st topic281_3_1 -pt None -u 0.013721328252414816 > ./result_8chains/node281_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_2 -p 729 -st topic281_4_1 -pt None -u 0.030834149410620737 > ./result_8chains/node281_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_2 -p 798 -st topic281_5_1 -pt None -u 0.007016128973751368 > ./result_8chains/node281_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_6_2 -p 962 -st topic281_6_1 -pt None -u 0.009923678175464488 > ./result_8chains/node281_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_7_2 -p 987 -st topic281_7_1 -pt None -u 0.03338052707027573 > ./result_8chains/node281_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_0 -p 155 -st none -pt topic281_0_0 -u 0.035478005041207406 > ./result_8chains/node281_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_0 -p 168 -st none -pt topic281_1_0 -u 0.05717987721226031 > ./result_8chains/node281_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_0 -p 358 -st none -pt topic281_2_0 -u 0.018581116420522292 > ./result_8chains/node281_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_0 -p 502 -st none -pt topic281_3_0 -u 0.037517688464134724 > ./result_8chains/node281_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_0 -p 729 -st none -pt topic281_4_0 -u 0.043740009716534245 > ./result_8chains/node281_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_0 -p 798 -st none -pt topic281_5_0 -u 0.014988798069254627 > ./result_8chains/node281_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_6_0 -p 962 -st none -pt topic281_6_0 -u 0.007583334207793432 > ./result_8chains/node281_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_7_0 -p 987 -st none -pt topic281_7_0 -u 0.022330097199262017 > ./result_8chains/node281_7_0.txt &
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
    "./result_8chains/node281_0_0.txt 90"
    "./result_8chains/node281_0_2.txt 90"
    "./result_8chains/node281_1_0.txt 89"
    "./result_8chains/node281_1_2.txt 89"
    "./result_8chains/node281_2_0.txt 88"
    "./result_8chains/node281_2_2.txt 88"
    "./result_8chains/node281_3_0.txt 87"
    "./result_8chains/node281_3_2.txt 87"
    "./result_8chains/node281_4_0.txt 86"
    "./result_8chains/node281_4_2.txt 86"
    "./result_8chains/node281_5_0.txt 85"
    "./result_8chains/node281_5_2.txt 85"
    "./result_8chains/node281_6_0.txt 84"
    "./result_8chains/node281_6_2.txt 84"
    "./result_8chains/node281_7_0.txt 83"
    "./result_8chains/node281_7_2.txt 83"
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
