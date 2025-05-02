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
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_2 -p 50 -st topic257_0_1 -pt None -u 0.02021946638946459 > ./result_6chains/node257_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_2 -p 62 -st topic257_1_1 -pt None -u 0.01003150623073995 > ./result_6chains/node257_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_2 -p 265 -st topic257_2_1 -pt None -u 0.06450267949225835 > ./result_6chains/node257_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_2 -p 515 -st topic257_3_1 -pt None -u 0.06203107057560636 > ./result_6chains/node257_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_2 -p 697 -st topic257_4_1 -pt None -u 0.0508058397363175 > ./result_6chains/node257_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_2 -p 759 -st topic257_5_1 -pt None -u 0.030745786121760727 > ./result_6chains/node257_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_0 -p 50 -st none -pt topic257_0_0 -u 0.004798944344648448 > ./result_6chains/node257_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_0 -p 62 -st none -pt topic257_1_0 -u 0.00943988346589697 > ./result_6chains/node257_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_0 -p 265 -st none -pt topic257_2_0 -u 0.04628157232141483 > ./result_6chains/node257_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_0 -p 515 -st none -pt topic257_3_0 -u 0.04635935286222803 > ./result_6chains/node257_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_0 -p 697 -st none -pt topic257_4_0 -u 0.05003628443283323 > ./result_6chains/node257_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_0 -p 759 -st none -pt topic257_5_0 -u 0.0226705947923109 > ./result_6chains/node257_5_0.txt &
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
    "./result_6chains/node257_0_0.txt 90"
    "./result_6chains/node257_0_2.txt 90"
    "./result_6chains/node257_1_0.txt 89"
    "./result_6chains/node257_1_2.txt 89"
    "./result_6chains/node257_2_0.txt 88"
    "./result_6chains/node257_2_2.txt 88"
    "./result_6chains/node257_3_0.txt 87"
    "./result_6chains/node257_3_2.txt 87"
    "./result_6chains/node257_4_0.txt 86"
    "./result_6chains/node257_4_2.txt 86"
    "./result_6chains/node257_5_0.txt 85"
    "./result_6chains/node257_5_2.txt 85"
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
