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
ros2 run evaluation_3_randomdag uunifast_node -n node223_0_2 -p 17 -st topic223_0_1 -pt None -u 0.01815491404179692 > ./result_6chains/node223_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_1_2 -p 22 -st topic223_1_1 -pt None -u 0.05985654294997411 > ./result_6chains/node223_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_2_2 -p 55 -st topic223_2_1 -pt None -u 0.006555096475191258 > ./result_6chains/node223_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_3_2 -p 164 -st topic223_3_1 -pt None -u 0.04193155842835458 > ./result_6chains/node223_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_4_2 -p 292 -st topic223_4_1 -pt None -u 0.0005970610153576417 > ./result_6chains/node223_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_5_2 -p 821 -st topic223_5_1 -pt None -u 0.004277779434568609 > ./result_6chains/node223_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_0_0 -p 17 -st none -pt topic223_0_0 -u 0.01157602091577925 > ./result_6chains/node223_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_1_0 -p 22 -st none -pt topic223_1_0 -u 0.0175664335632551 > ./result_6chains/node223_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_2_0 -p 55 -st none -pt topic223_2_0 -u 0.003098194936150045 > ./result_6chains/node223_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_3_0 -p 164 -st none -pt topic223_3_0 -u 0.0035392518084897406 > ./result_6chains/node223_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_4_0 -p 292 -st none -pt topic223_4_0 -u 0.07193426726396702 > ./result_6chains/node223_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node223_5_0 -p 821 -st none -pt topic223_5_0 -u 0.02220771991928329 > ./result_6chains/node223_5_0.txt &
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
    "./result_6chains/node223_0_0.txt 90"
    "./result_6chains/node223_0_2.txt 90"
    "./result_6chains/node223_1_0.txt 89"
    "./result_6chains/node223_1_2.txt 89"
    "./result_6chains/node223_2_0.txt 88"
    "./result_6chains/node223_2_2.txt 88"
    "./result_6chains/node223_3_0.txt 87"
    "./result_6chains/node223_3_2.txt 87"
    "./result_6chains/node223_4_0.txt 86"
    "./result_6chains/node223_4_2.txt 86"
    "./result_6chains/node223_5_0.txt 85"
    "./result_6chains/node223_5_2.txt 85"
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
