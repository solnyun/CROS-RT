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
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_2 -p 62 -st topic22_0_1 -pt None -u 0.027635095640031526 > ./result_8chains/node22_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_2 -p 117 -st topic22_1_1 -pt None -u 0.0067398067252346094 > ./result_8chains/node22_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_2 -p 190 -st topic22_2_1 -pt None -u 0.011915741667268609 > ./result_8chains/node22_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_2 -p 191 -st topic22_3_1 -pt None -u 0.014618849082943475 > ./result_8chains/node22_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_4_2 -p 268 -st topic22_4_1 -pt None -u 0.007942271905142462 > ./result_8chains/node22_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_5_2 -p 537 -st topic22_5_1 -pt None -u 0.006152476846317492 > ./result_8chains/node22_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_6_2 -p 765 -st topic22_6_1 -pt None -u 0.049068883842856015 > ./result_8chains/node22_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_7_2 -p 885 -st topic22_7_1 -pt None -u 0.010616550274149324 > ./result_8chains/node22_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_0 -p 62 -st none -pt topic22_0_0 -u 0.037677349653879255 > ./result_8chains/node22_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_0 -p 117 -st none -pt topic22_1_0 -u 0.020002050410895367 > ./result_8chains/node22_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_0 -p 190 -st none -pt topic22_2_0 -u 0.02848475503651504 > ./result_8chains/node22_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_0 -p 191 -st none -pt topic22_3_0 -u 0.006785846793907091 > ./result_8chains/node22_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_4_0 -p 268 -st none -pt topic22_4_0 -u 0.02221125548357014 > ./result_8chains/node22_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_5_0 -p 537 -st none -pt topic22_5_0 -u 0.03737263891476353 > ./result_8chains/node22_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_6_0 -p 765 -st none -pt topic22_6_0 -u 0.004276374744108677 > ./result_8chains/node22_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_7_0 -p 885 -st none -pt topic22_7_0 -u 0.0008057115088384234 > ./result_8chains/node22_7_0.txt &
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
    "./result_8chains/node22_0_0.txt 90"
    "./result_8chains/node22_0_2.txt 90"
    "./result_8chains/node22_1_0.txt 89"
    "./result_8chains/node22_1_2.txt 89"
    "./result_8chains/node22_2_0.txt 88"
    "./result_8chains/node22_2_2.txt 88"
    "./result_8chains/node22_3_0.txt 87"
    "./result_8chains/node22_3_2.txt 87"
    "./result_8chains/node22_4_0.txt 86"
    "./result_8chains/node22_4_2.txt 86"
    "./result_8chains/node22_5_0.txt 85"
    "./result_8chains/node22_5_2.txt 85"
    "./result_8chains/node22_6_0.txt 84"
    "./result_8chains/node22_6_2.txt 84"
    "./result_8chains/node22_7_0.txt 83"
    "./result_8chains/node22_7_2.txt 83"
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
