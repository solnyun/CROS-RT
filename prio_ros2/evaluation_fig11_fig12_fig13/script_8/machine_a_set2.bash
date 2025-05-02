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
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_2 -p 184 -st topic2_0_1 -pt None -u 0.0011812429134987479 > ./result_8chains/node2_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_2 -p 311 -st topic2_1_1 -pt None -u 0.006993137174855502 > ./result_8chains/node2_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_2 -p 342 -st topic2_2_1 -pt None -u 0.009697135336726198 > ./result_8chains/node2_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_2 -p 603 -st topic2_3_1 -pt None -u 0.0052523269355555235 > ./result_8chains/node2_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_2 -p 757 -st topic2_4_1 -pt None -u 0.011820067451899119 > ./result_8chains/node2_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_2 -p 883 -st topic2_5_1 -pt None -u 0.000499732564432212 > ./result_8chains/node2_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_6_2 -p 935 -st topic2_6_1 -pt None -u 0.018463111041369752 > ./result_8chains/node2_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_7_2 -p 965 -st topic2_7_1 -pt None -u 0.016248597996713146 > ./result_8chains/node2_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_0 -p 184 -st none -pt topic2_0_0 -u 0.025473529946575868 > ./result_8chains/node2_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_0 -p 311 -st none -pt topic2_1_0 -u 0.14354893559575393 > ./result_8chains/node2_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_0 -p 342 -st none -pt topic2_2_0 -u 0.001237660209647995 > ./result_8chains/node2_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_0 -p 603 -st none -pt topic2_3_0 -u 0.0013877974467661203 > ./result_8chains/node2_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_0 -p 757 -st none -pt topic2_4_0 -u 0.03324476175950336 > ./result_8chains/node2_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_0 -p 883 -st none -pt topic2_5_0 -u 0.029926608592873327 > ./result_8chains/node2_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_6_0 -p 935 -st none -pt topic2_6_0 -u 0.016720807514741115 > ./result_8chains/node2_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_7_0 -p 965 -st none -pt topic2_7_0 -u 0.014772020160141109 > ./result_8chains/node2_7_0.txt &
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
    "./result_8chains/node2_0_0.txt 90"
    "./result_8chains/node2_0_2.txt 90"
    "./result_8chains/node2_1_0.txt 89"
    "./result_8chains/node2_1_2.txt 89"
    "./result_8chains/node2_2_0.txt 88"
    "./result_8chains/node2_2_2.txt 88"
    "./result_8chains/node2_3_0.txt 87"
    "./result_8chains/node2_3_2.txt 87"
    "./result_8chains/node2_4_0.txt 86"
    "./result_8chains/node2_4_2.txt 86"
    "./result_8chains/node2_5_0.txt 85"
    "./result_8chains/node2_5_2.txt 85"
    "./result_8chains/node2_6_0.txt 84"
    "./result_8chains/node2_6_2.txt 84"
    "./result_8chains/node2_7_0.txt 83"
    "./result_8chains/node2_7_2.txt 83"
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
