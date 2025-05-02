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
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_2 -p 64 -st topic405_0_1 -pt None -u 0.013384160777697274 > ./result_6chains/node405_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_2 -p 90 -st topic405_1_1 -pt None -u 0.0005137446500865783 > ./result_6chains/node405_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_2 -p 381 -st topic405_2_1 -pt None -u 0.0010521836572983112 > ./result_6chains/node405_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_2 -p 476 -st topic405_3_1 -pt None -u 0.03344775176722814 > ./result_6chains/node405_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_2 -p 687 -st topic405_4_1 -pt None -u 0.021088206187912253 > ./result_6chains/node405_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_2 -p 871 -st topic405_5_1 -pt None -u 0.07531492284207539 > ./result_6chains/node405_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_0_0 -p 64 -st none -pt topic405_0_0 -u 0.0131781256099191 > ./result_6chains/node405_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_1_0 -p 90 -st none -pt topic405_1_0 -u 0.051369637511166466 > ./result_6chains/node405_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_2_0 -p 381 -st none -pt topic405_2_0 -u 0.032495355233886025 > ./result_6chains/node405_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_3_0 -p 476 -st none -pt topic405_3_0 -u 0.037226976049273386 > ./result_6chains/node405_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node405_4_0 -p 687 -st none -pt topic405_4_0 -u 0.0910042426079875 > ./result_6chains/node405_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node405_5_0 -p 871 -st none -pt topic405_5_0 -u 0.0012153739500044974 > ./result_6chains/node405_5_0.txt &
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
    "./result_6chains/node405_0_0.txt 90"
    "./result_6chains/node405_0_2.txt 90"
    "./result_6chains/node405_1_0.txt 89"
    "./result_6chains/node405_1_2.txt 89"
    "./result_6chains/node405_2_0.txt 88"
    "./result_6chains/node405_2_2.txt 88"
    "./result_6chains/node405_3_0.txt 87"
    "./result_6chains/node405_3_2.txt 87"
    "./result_6chains/node405_4_0.txt 86"
    "./result_6chains/node405_4_2.txt 86"
    "./result_6chains/node405_5_0.txt 85"
    "./result_6chains/node405_5_2.txt 85"
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
