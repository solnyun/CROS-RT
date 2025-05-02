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
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_2 -p 87 -st topic124_0_1 -pt None -u 0.01210605550462196 > ./result_6chains/node124_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_2 -p 118 -st topic124_1_1 -pt None -u 0.005049140365605331 > ./result_6chains/node124_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_2 -p 265 -st topic124_2_1 -pt None -u 0.03790153552085196 > ./result_6chains/node124_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_2 -p 281 -st topic124_3_1 -pt None -u 0.014902507541208115 > ./result_6chains/node124_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_2 -p 729 -st topic124_4_1 -pt None -u 0.009549208120563368 > ./result_6chains/node124_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_2 -p 999 -st topic124_5_1 -pt None -u 0.005485559333238377 > ./result_6chains/node124_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_0 -p 87 -st none -pt topic124_0_0 -u 0.00788063166589642 > ./result_6chains/node124_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_0 -p 118 -st none -pt topic124_1_0 -u 0.048736927190005774 > ./result_6chains/node124_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_0 -p 265 -st none -pt topic124_2_0 -u 0.019066114597186545 > ./result_6chains/node124_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_0 -p 281 -st none -pt topic124_3_0 -u 0.0018327996018377424 > ./result_6chains/node124_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_0 -p 729 -st none -pt topic124_4_0 -u 0.028569204869045406 > ./result_6chains/node124_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_0 -p 999 -st none -pt topic124_5_0 -u 0.09570366616925137 > ./result_6chains/node124_5_0.txt &
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
    "./result_6chains/node124_0_0.txt 90"
    "./result_6chains/node124_0_2.txt 90"
    "./result_6chains/node124_1_0.txt 89"
    "./result_6chains/node124_1_2.txt 89"
    "./result_6chains/node124_2_0.txt 88"
    "./result_6chains/node124_2_2.txt 88"
    "./result_6chains/node124_3_0.txt 87"
    "./result_6chains/node124_3_2.txt 87"
    "./result_6chains/node124_4_0.txt 86"
    "./result_6chains/node124_4_2.txt 86"
    "./result_6chains/node124_5_0.txt 85"
    "./result_6chains/node124_5_2.txt 85"
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
