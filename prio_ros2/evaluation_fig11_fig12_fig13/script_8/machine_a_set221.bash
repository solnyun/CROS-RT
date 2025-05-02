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
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_2 -p 36 -st topic221_0_1 -pt None -u 0.04187632598297497 > ./result_8chains/node221_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_2 -p 69 -st topic221_1_1 -pt None -u 0.04900311597682799 > ./result_8chains/node221_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_2 -p 180 -st topic221_2_1 -pt None -u 0.02090663552563679 > ./result_8chains/node221_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_2 -p 212 -st topic221_3_1 -pt None -u 0.005947980858483776 > ./result_8chains/node221_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_2 -p 394 -st topic221_4_1 -pt None -u 0.04439213265209849 > ./result_8chains/node221_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_2 -p 456 -st topic221_5_1 -pt None -u 0.05136824007424218 > ./result_8chains/node221_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_6_2 -p 488 -st topic221_6_1 -pt None -u 0.001251033938123404 > ./result_8chains/node221_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_7_2 -p 686 -st topic221_7_1 -pt None -u 0.002875121962931795 > ./result_8chains/node221_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_0 -p 36 -st none -pt topic221_0_0 -u 0.011224883507343797 > ./result_8chains/node221_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_0 -p 69 -st none -pt topic221_1_0 -u 0.00746413255169498 > ./result_8chains/node221_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_0 -p 180 -st none -pt topic221_2_0 -u 0.016099095254346663 > ./result_8chains/node221_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_0 -p 212 -st none -pt topic221_3_0 -u 0.002585310660577156 > ./result_8chains/node221_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_0 -p 394 -st none -pt topic221_4_0 -u 0.004566591489779143 > ./result_8chains/node221_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_0 -p 456 -st none -pt topic221_5_0 -u 0.0010008184784150165 > ./result_8chains/node221_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_6_0 -p 488 -st none -pt topic221_6_0 -u 0.028757727808555907 > ./result_8chains/node221_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_7_0 -p 686 -st none -pt topic221_7_0 -u 0.03563654824635599 > ./result_8chains/node221_7_0.txt &
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
    "./result_8chains/node221_0_0.txt 90"
    "./result_8chains/node221_0_2.txt 90"
    "./result_8chains/node221_1_0.txt 89"
    "./result_8chains/node221_1_2.txt 89"
    "./result_8chains/node221_2_0.txt 88"
    "./result_8chains/node221_2_2.txt 88"
    "./result_8chains/node221_3_0.txt 87"
    "./result_8chains/node221_3_2.txt 87"
    "./result_8chains/node221_4_0.txt 86"
    "./result_8chains/node221_4_2.txt 86"
    "./result_8chains/node221_5_0.txt 85"
    "./result_8chains/node221_5_2.txt 85"
    "./result_8chains/node221_6_0.txt 84"
    "./result_8chains/node221_6_2.txt 84"
    "./result_8chains/node221_7_0.txt 83"
    "./result_8chains/node221_7_2.txt 83"
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
