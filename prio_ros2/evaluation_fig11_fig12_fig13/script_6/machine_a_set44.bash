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
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_2 -p 67 -st topic44_0_1 -pt None -u 0.031040429701377825 > ./result_6chains/node44_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_2 -p 238 -st topic44_1_1 -pt None -u 0.02828536925708458 > ./result_6chains/node44_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_2 -p 328 -st topic44_2_1 -pt None -u 0.03262230453579812 > ./result_6chains/node44_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_2 -p 355 -st topic44_3_1 -pt None -u 0.04442158316282599 > ./result_6chains/node44_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_2 -p 525 -st topic44_4_1 -pt None -u 0.053757962905095255 > ./result_6chains/node44_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_2 -p 661 -st topic44_5_1 -pt None -u 0.0010017524606668127 > ./result_6chains/node44_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_0 -p 67 -st none -pt topic44_0_0 -u 0.015333806383834248 > ./result_6chains/node44_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_0 -p 238 -st none -pt topic44_1_0 -u 0.04128780667547838 > ./result_6chains/node44_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_0 -p 328 -st none -pt topic44_2_0 -u 0.03520559609182411 > ./result_6chains/node44_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_0 -p 355 -st none -pt topic44_3_0 -u 0.040145056010057856 > ./result_6chains/node44_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_0 -p 525 -st none -pt topic44_4_0 -u 0.0017998189079496685 > ./result_6chains/node44_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_0 -p 661 -st none -pt topic44_5_0 -u 0.0005600598146195887 > ./result_6chains/node44_5_0.txt &
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
    "./result_6chains/node44_0_0.txt 90"
    "./result_6chains/node44_0_2.txt 90"
    "./result_6chains/node44_1_0.txt 89"
    "./result_6chains/node44_1_2.txt 89"
    "./result_6chains/node44_2_0.txt 88"
    "./result_6chains/node44_2_2.txt 88"
    "./result_6chains/node44_3_0.txt 87"
    "./result_6chains/node44_3_2.txt 87"
    "./result_6chains/node44_4_0.txt 86"
    "./result_6chains/node44_4_2.txt 86"
    "./result_6chains/node44_5_0.txt 85"
    "./result_6chains/node44_5_2.txt 85"
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
