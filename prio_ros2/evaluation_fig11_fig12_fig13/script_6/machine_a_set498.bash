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
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_2 -p 15 -st topic498_0_1 -pt None -u 0.012929248794712245 > ./result_6chains/node498_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_2 -p 392 -st topic498_1_1 -pt None -u 0.033189137612379294 > ./result_6chains/node498_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_2 -p 439 -st topic498_2_1 -pt None -u 0.07131601653367906 > ./result_6chains/node498_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_2 -p 764 -st topic498_3_1 -pt None -u 0.05388157551773076 > ./result_6chains/node498_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_2 -p 879 -st topic498_4_1 -pt None -u 0.001955656749274892 > ./result_6chains/node498_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_2 -p 895 -st topic498_5_1 -pt None -u 0.006726459200441161 > ./result_6chains/node498_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_0 -p 15 -st none -pt topic498_0_0 -u 0.004072687913797501 > ./result_6chains/node498_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_0 -p 392 -st none -pt topic498_1_0 -u 0.06343781361683032 > ./result_6chains/node498_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_0 -p 439 -st none -pt topic498_2_0 -u 0.042596925802270647 > ./result_6chains/node498_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_0 -p 764 -st none -pt topic498_3_0 -u 0.005961123516030231 > ./result_6chains/node498_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_0 -p 879 -st none -pt topic498_4_0 -u 0.03162089231874202 > ./result_6chains/node498_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_0 -p 895 -st none -pt topic498_5_0 -u 0.10947800202848779 > ./result_6chains/node498_5_0.txt &
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
    "./result_6chains/node498_0_0.txt 90"
    "./result_6chains/node498_0_2.txt 90"
    "./result_6chains/node498_1_0.txt 89"
    "./result_6chains/node498_1_2.txt 89"
    "./result_6chains/node498_2_0.txt 88"
    "./result_6chains/node498_2_2.txt 88"
    "./result_6chains/node498_3_0.txt 87"
    "./result_6chains/node498_3_2.txt 87"
    "./result_6chains/node498_4_0.txt 86"
    "./result_6chains/node498_4_2.txt 86"
    "./result_6chains/node498_5_0.txt 85"
    "./result_6chains/node498_5_2.txt 85"
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
