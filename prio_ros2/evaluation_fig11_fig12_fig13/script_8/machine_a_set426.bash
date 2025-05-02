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
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_2 -p 211 -st topic426_0_1 -pt None -u 0.03971386536591859 > ./result_8chains/node426_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_2 -p 423 -st topic426_1_1 -pt None -u 0.006195167164058768 > ./result_8chains/node426_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_2 -p 443 -st topic426_2_1 -pt None -u 0.0014428352979788395 > ./result_8chains/node426_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_2 -p 512 -st topic426_3_1 -pt None -u 0.031221588391060234 > ./result_8chains/node426_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_2 -p 540 -st topic426_4_1 -pt None -u 0.0032965931133472903 > ./result_8chains/node426_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_2 -p 630 -st topic426_5_1 -pt None -u 0.011369001965654824 > ./result_8chains/node426_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_6_2 -p 865 -st topic426_6_1 -pt None -u 0.025322861510749146 > ./result_8chains/node426_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_7_2 -p 885 -st topic426_7_1 -pt None -u 0.00033004192583948764 > ./result_8chains/node426_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_0 -p 211 -st none -pt topic426_0_0 -u 0.08524523702270381 > ./result_8chains/node426_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_0 -p 423 -st none -pt topic426_1_0 -u 0.013169952176869726 > ./result_8chains/node426_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_0 -p 443 -st none -pt topic426_2_0 -u 0.004887277056991157 > ./result_8chains/node426_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_0 -p 512 -st none -pt topic426_3_0 -u 0.009158871037108995 > ./result_8chains/node426_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_0 -p 540 -st none -pt topic426_4_0 -u 0.017701909783516656 > ./result_8chains/node426_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_0 -p 630 -st none -pt topic426_5_0 -u 0.017966323699781267 > ./result_8chains/node426_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_6_0 -p 865 -st none -pt topic426_6_0 -u 0.06795855999889786 > ./result_8chains/node426_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_7_0 -p 885 -st none -pt topic426_7_0 -u 0.007131265368327859 > ./result_8chains/node426_7_0.txt &
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
    "./result_8chains/node426_0_0.txt 90"
    "./result_8chains/node426_0_2.txt 90"
    "./result_8chains/node426_1_0.txt 89"
    "./result_8chains/node426_1_2.txt 89"
    "./result_8chains/node426_2_0.txt 88"
    "./result_8chains/node426_2_2.txt 88"
    "./result_8chains/node426_3_0.txt 87"
    "./result_8chains/node426_3_2.txt 87"
    "./result_8chains/node426_4_0.txt 86"
    "./result_8chains/node426_4_2.txt 86"
    "./result_8chains/node426_5_0.txt 85"
    "./result_8chains/node426_5_2.txt 85"
    "./result_8chains/node426_6_0.txt 84"
    "./result_8chains/node426_6_2.txt 84"
    "./result_8chains/node426_7_0.txt 83"
    "./result_8chains/node426_7_2.txt 83"
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
