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
ros2 run evaluation_3_randomdag uunifast_node -n node159_0_2 -p 58 -st topic159_0_1 -pt None -u 0.05387724967747054 > ./result_6chains/node159_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_1_2 -p 174 -st topic159_1_1 -pt None -u 0.01114983138790232 > ./result_6chains/node159_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_2_2 -p 320 -st topic159_2_1 -pt None -u 0.10946389195604325 > ./result_6chains/node159_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_3_2 -p 407 -st topic159_3_1 -pt None -u 0.014361098690886476 > ./result_6chains/node159_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_4_2 -p 451 -st topic159_4_1 -pt None -u 0.01658144856422611 > ./result_6chains/node159_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_5_2 -p 753 -st topic159_5_1 -pt None -u 0.04733199536907244 > ./result_6chains/node159_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_0_0 -p 58 -st none -pt topic159_0_0 -u 0.021903922061008496 > ./result_6chains/node159_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_1_0 -p 174 -st none -pt topic159_1_0 -u 0.005702975153593137 > ./result_6chains/node159_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_2_0 -p 320 -st none -pt topic159_2_0 -u 0.0020952979842199237 > ./result_6chains/node159_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_3_0 -p 407 -st none -pt topic159_3_0 -u 0.06877455662455478 > ./result_6chains/node159_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_4_0 -p 451 -st none -pt topic159_4_0 -u 0.013154713955428707 > ./result_6chains/node159_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_5_0 -p 753 -st none -pt topic159_5_0 -u 0.021509293556222532 > ./result_6chains/node159_5_0.txt &
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
    "./result_6chains/node159_0_0.txt 90"
    "./result_6chains/node159_0_2.txt 90"
    "./result_6chains/node159_1_0.txt 89"
    "./result_6chains/node159_1_2.txt 89"
    "./result_6chains/node159_2_0.txt 88"
    "./result_6chains/node159_2_2.txt 88"
    "./result_6chains/node159_3_0.txt 87"
    "./result_6chains/node159_3_2.txt 87"
    "./result_6chains/node159_4_0.txt 86"
    "./result_6chains/node159_4_2.txt 86"
    "./result_6chains/node159_5_0.txt 85"
    "./result_6chains/node159_5_2.txt 85"
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
