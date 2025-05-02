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
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_2 -p 363 -st topic488_0_1 -pt None -u 0.04211352374455768 > ./result_8chains/node488_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_2 -p 480 -st topic488_1_1 -pt None -u 0.007345419790904195 > ./result_8chains/node488_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_2 -p 552 -st topic488_2_1 -pt None -u 0.016863837105274893 > ./result_8chains/node488_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_2 -p 554 -st topic488_3_1 -pt None -u 0.012528916714115657 > ./result_8chains/node488_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_2 -p 798 -st topic488_4_1 -pt None -u 0.013502273074317103 > ./result_8chains/node488_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_2 -p 857 -st topic488_5_1 -pt None -u 0.027440950195855435 > ./result_8chains/node488_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_6_2 -p 919 -st topic488_6_1 -pt None -u 0.0055219952824815816 > ./result_8chains/node488_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_7_2 -p 946 -st topic488_7_1 -pt None -u 0.001254076628412978 > ./result_8chains/node488_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_0 -p 363 -st none -pt topic488_0_0 -u 0.03501806003382829 > ./result_8chains/node488_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_0 -p 480 -st none -pt topic488_1_0 -u 0.07730009788521897 > ./result_8chains/node488_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_0 -p 552 -st none -pt topic488_2_0 -u 0.001364969825423612 > ./result_8chains/node488_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_0 -p 554 -st none -pt topic488_3_0 -u 0.016911903886408897 > ./result_8chains/node488_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_0 -p 798 -st none -pt topic488_4_0 -u 0.022300420398716936 > ./result_8chains/node488_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_0 -p 857 -st none -pt topic488_5_0 -u 0.0026361008481699255 > ./result_8chains/node488_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_6_0 -p 919 -st none -pt topic488_6_0 -u 0.015325246599825315 > ./result_8chains/node488_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_7_0 -p 946 -st none -pt topic488_7_0 -u 0.014141802438539788 > ./result_8chains/node488_7_0.txt &
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
    "./result_8chains/node488_0_0.txt 90"
    "./result_8chains/node488_0_2.txt 90"
    "./result_8chains/node488_1_0.txt 89"
    "./result_8chains/node488_1_2.txt 89"
    "./result_8chains/node488_2_0.txt 88"
    "./result_8chains/node488_2_2.txt 88"
    "./result_8chains/node488_3_0.txt 87"
    "./result_8chains/node488_3_2.txt 87"
    "./result_8chains/node488_4_0.txt 86"
    "./result_8chains/node488_4_2.txt 86"
    "./result_8chains/node488_5_0.txt 85"
    "./result_8chains/node488_5_2.txt 85"
    "./result_8chains/node488_6_0.txt 84"
    "./result_8chains/node488_6_2.txt 84"
    "./result_8chains/node488_7_0.txt 83"
    "./result_8chains/node488_7_2.txt 83"
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
