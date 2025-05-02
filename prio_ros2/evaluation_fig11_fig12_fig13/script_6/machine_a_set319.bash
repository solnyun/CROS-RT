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
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_2 -p 80 -st topic319_0_1 -pt None -u 0.009589617922779847 > ./result_6chains/node319_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_2 -p 244 -st topic319_1_1 -pt None -u 0.0142864577563519 > ./result_6chains/node319_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_2 -p 313 -st topic319_2_1 -pt None -u 0.04764124747523368 > ./result_6chains/node319_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_2 -p 332 -st topic319_3_1 -pt None -u 0.011136632618887893 > ./result_6chains/node319_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_2 -p 373 -st topic319_4_1 -pt None -u 0.008128398217408572 > ./result_6chains/node319_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_2 -p 463 -st topic319_5_1 -pt None -u 0.01088195668592946 > ./result_6chains/node319_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_0 -p 80 -st none -pt topic319_0_0 -u 0.0041116959038839385 > ./result_6chains/node319_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_0 -p 244 -st none -pt topic319_1_0 -u 0.011188312613295115 > ./result_6chains/node319_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_0 -p 313 -st none -pt topic319_2_0 -u 0.01932593619536449 > ./result_6chains/node319_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_0 -p 332 -st none -pt topic319_3_0 -u 0.008175164326753137 > ./result_6chains/node319_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_0 -p 373 -st none -pt topic319_4_0 -u 0.005292475155656479 > ./result_6chains/node319_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_0 -p 463 -st none -pt topic319_5_0 -u 0.1359105576283048 > ./result_6chains/node319_5_0.txt &
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
    "./result_6chains/node319_0_0.txt 90"
    "./result_6chains/node319_0_2.txt 90"
    "./result_6chains/node319_1_0.txt 89"
    "./result_6chains/node319_1_2.txt 89"
    "./result_6chains/node319_2_0.txt 88"
    "./result_6chains/node319_2_2.txt 88"
    "./result_6chains/node319_3_0.txt 87"
    "./result_6chains/node319_3_2.txt 87"
    "./result_6chains/node319_4_0.txt 86"
    "./result_6chains/node319_4_2.txt 86"
    "./result_6chains/node319_5_0.txt 85"
    "./result_6chains/node319_5_2.txt 85"
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
