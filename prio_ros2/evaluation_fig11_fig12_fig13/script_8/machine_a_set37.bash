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
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_2 -p 74 -st topic37_0_1 -pt None -u 0.03359746901553651 > ./result_8chains/node37_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_2 -p 350 -st topic37_1_1 -pt None -u 0.002749985059074367 > ./result_8chains/node37_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_2 -p 461 -st topic37_2_1 -pt None -u 0.0015536086279677175 > ./result_8chains/node37_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_2 -p 758 -st topic37_3_1 -pt None -u 0.01492127815490063 > ./result_8chains/node37_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_2 -p 828 -st topic37_4_1 -pt None -u 0.02068269172645748 > ./result_8chains/node37_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_2 -p 835 -st topic37_5_1 -pt None -u 0.0011800725886311758 > ./result_8chains/node37_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_6_2 -p 948 -st topic37_6_1 -pt None -u 0.0075101054498805525 > ./result_8chains/node37_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_7_2 -p 991 -st topic37_7_1 -pt None -u 0.04874688680063284 > ./result_8chains/node37_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_0 -p 74 -st none -pt topic37_0_0 -u 0.04403306505618604 > ./result_8chains/node37_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_0 -p 350 -st none -pt topic37_1_0 -u 0.06691112046277237 > ./result_8chains/node37_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_0 -p 461 -st none -pt topic37_2_0 -u 0.02699615951931822 > ./result_8chains/node37_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_0 -p 758 -st none -pt topic37_3_0 -u 0.006171032611863303 > ./result_8chains/node37_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_0 -p 828 -st none -pt topic37_4_0 -u 0.0021616508554039293 > ./result_8chains/node37_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_0 -p 835 -st none -pt topic37_5_0 -u 0.03466581264982174 > ./result_8chains/node37_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_6_0 -p 948 -st none -pt topic37_6_0 -u 0.014639752637504638 > ./result_8chains/node37_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_7_0 -p 991 -st none -pt topic37_7_0 -u 0.019978822134489038 > ./result_8chains/node37_7_0.txt &
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
    "./result_8chains/node37_0_0.txt 90"
    "./result_8chains/node37_0_2.txt 90"
    "./result_8chains/node37_1_0.txt 89"
    "./result_8chains/node37_1_2.txt 89"
    "./result_8chains/node37_2_0.txt 88"
    "./result_8chains/node37_2_2.txt 88"
    "./result_8chains/node37_3_0.txt 87"
    "./result_8chains/node37_3_2.txt 87"
    "./result_8chains/node37_4_0.txt 86"
    "./result_8chains/node37_4_2.txt 86"
    "./result_8chains/node37_5_0.txt 85"
    "./result_8chains/node37_5_2.txt 85"
    "./result_8chains/node37_6_0.txt 84"
    "./result_8chains/node37_6_2.txt 84"
    "./result_8chains/node37_7_0.txt 83"
    "./result_8chains/node37_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
