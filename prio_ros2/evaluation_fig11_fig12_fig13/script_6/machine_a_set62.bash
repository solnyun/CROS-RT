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
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_2 -p 207 -st topic62_0_1 -pt None -u 0.014765898891046125 > ./result_6chains/node62_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_2 -p 527 -st topic62_1_1 -pt None -u 0.022548664849029065 > ./result_6chains/node62_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_2 -p 780 -st topic62_2_1 -pt None -u 0.002129608031418262 > ./result_6chains/node62_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_2 -p 828 -st topic62_3_1 -pt None -u 0.11370353217668479 > ./result_6chains/node62_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_2 -p 856 -st topic62_4_1 -pt None -u 0.02459860480695128 > ./result_6chains/node62_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_2 -p 869 -st topic62_5_1 -pt None -u 0.012460146340600671 > ./result_6chains/node62_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_0 -p 207 -st none -pt topic62_0_0 -u 0.07077583869613568 > ./result_6chains/node62_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_0 -p 527 -st none -pt topic62_1_0 -u 0.009272565091833385 > ./result_6chains/node62_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_0 -p 780 -st none -pt topic62_2_0 -u 0.00742132331615214 > ./result_6chains/node62_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_0 -p 828 -st none -pt topic62_3_0 -u 0.027297866330784154 > ./result_6chains/node62_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_0 -p 856 -st none -pt topic62_4_0 -u 0.004162538221429035 > ./result_6chains/node62_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_0 -p 869 -st none -pt topic62_5_0 -u 0.00807515267014906 > ./result_6chains/node62_5_0.txt &
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
    "./result_6chains/node62_0_0.txt 90"
    "./result_6chains/node62_0_2.txt 90"
    "./result_6chains/node62_1_0.txt 89"
    "./result_6chains/node62_1_2.txt 89"
    "./result_6chains/node62_2_0.txt 88"
    "./result_6chains/node62_2_2.txt 88"
    "./result_6chains/node62_3_0.txt 87"
    "./result_6chains/node62_3_2.txt 87"
    "./result_6chains/node62_4_0.txt 86"
    "./result_6chains/node62_4_2.txt 86"
    "./result_6chains/node62_5_0.txt 85"
    "./result_6chains/node62_5_2.txt 85"
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
