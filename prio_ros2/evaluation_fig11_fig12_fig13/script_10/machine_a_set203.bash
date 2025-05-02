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
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_2 -p 20 -st topic203_0_1 -pt None -u 0.003936798573918265 > ./result_10chains/node203_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_2 -p 263 -st topic203_1_1 -pt None -u 0.007202912822353413 > ./result_10chains/node203_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_2 -p 525 -st topic203_2_1 -pt None -u 0.005133234232838235 > ./result_10chains/node203_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_2 -p 601 -st topic203_3_1 -pt None -u 0.021623940852462886 > ./result_10chains/node203_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_2 -p 647 -st topic203_4_1 -pt None -u 0.001706570848150818 > ./result_10chains/node203_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_2 -p 648 -st topic203_5_1 -pt None -u 0.009037062841989824 > ./result_10chains/node203_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_6_2 -p 691 -st topic203_6_1 -pt None -u 0.002038455283844026 > ./result_10chains/node203_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_7_2 -p 778 -st topic203_7_1 -pt None -u 0.036771102961218424 > ./result_10chains/node203_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_8_2 -p 894 -st topic203_8_1 -pt None -u 0.01760175089306097 > ./result_10chains/node203_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_9_2 -p 975 -st topic203_9_1 -pt None -u 0.006816252289992372 > ./result_10chains/node203_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_0 -p 20 -st none -pt topic203_0_0 -u 0.01859456022295486 > ./result_10chains/node203_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_0 -p 263 -st none -pt topic203_1_0 -u 0.031225329168184213 > ./result_10chains/node203_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_0 -p 525 -st none -pt topic203_2_0 -u 0.008230627361652032 > ./result_10chains/node203_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_0 -p 601 -st none -pt topic203_3_0 -u 0.009233345687739258 > ./result_10chains/node203_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_0 -p 647 -st none -pt topic203_4_0 -u 0.03677462107668164 > ./result_10chains/node203_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_0 -p 648 -st none -pt topic203_5_0 -u 0.0305487579362414 > ./result_10chains/node203_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_6_0 -p 691 -st none -pt topic203_6_0 -u 0.005178646344509014 > ./result_10chains/node203_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_7_0 -p 778 -st none -pt topic203_7_0 -u 0.029732805152549502 > ./result_10chains/node203_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_8_0 -p 894 -st none -pt topic203_8_0 -u 0.03498247035073024 > ./result_10chains/node203_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_9_0 -p 975 -st none -pt topic203_9_0 -u 0.0034345291466090864 > ./result_10chains/node203_9_0.txt &
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
    "./result_10chains/node203_0_0.txt 90"
    "./result_10chains/node203_0_2.txt 90"
    "./result_10chains/node203_1_0.txt 89"
    "./result_10chains/node203_1_2.txt 89"
    "./result_10chains/node203_2_0.txt 88"
    "./result_10chains/node203_2_2.txt 88"
    "./result_10chains/node203_3_0.txt 87"
    "./result_10chains/node203_3_2.txt 87"
    "./result_10chains/node203_4_0.txt 86"
    "./result_10chains/node203_4_2.txt 86"
    "./result_10chains/node203_5_0.txt 85"
    "./result_10chains/node203_5_2.txt 85"
    "./result_10chains/node203_6_0.txt 84"
    "./result_10chains/node203_6_2.txt 84"
    "./result_10chains/node203_7_0.txt 83"
    "./result_10chains/node203_7_2.txt 83"
    "./result_10chains/node203_8_0.txt 82"
    "./result_10chains/node203_8_2.txt 82"
    "./result_10chains/node203_9_0.txt 81"
    "./result_10chains/node203_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
