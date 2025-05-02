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
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_2 -p 18 -st topic200_0_1 -pt None -u 0.0078037112385794805 > ./result_8chains/node200_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_2 -p 31 -st topic200_1_1 -pt None -u 0.008599180199820478 > ./result_8chains/node200_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_2 -p 100 -st topic200_2_1 -pt None -u 0.0014928142622563922 > ./result_8chains/node200_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_2 -p 131 -st topic200_3_1 -pt None -u 0.019764551943107334 > ./result_8chains/node200_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_2 -p 327 -st topic200_4_1 -pt None -u 0.013494655294857882 > ./result_8chains/node200_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_2 -p 366 -st topic200_5_1 -pt None -u 0.003767681794159733 > ./result_8chains/node200_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_6_2 -p 484 -st topic200_6_1 -pt None -u 0.0021722334847766034 > ./result_8chains/node200_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_7_2 -p 953 -st topic200_7_1 -pt None -u 0.0031502145120538023 > ./result_8chains/node200_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_0 -p 18 -st none -pt topic200_0_0 -u 0.04407500123276903 > ./result_8chains/node200_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_0 -p 31 -st none -pt topic200_1_0 -u 0.015049931836462138 > ./result_8chains/node200_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_0 -p 100 -st none -pt topic200_2_0 -u 0.0023106384341960995 > ./result_8chains/node200_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_0 -p 131 -st none -pt topic200_3_0 -u 0.05040756290219389 > ./result_8chains/node200_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_4_0 -p 327 -st none -pt topic200_4_0 -u 0.006653510578935595 > ./result_8chains/node200_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_5_0 -p 366 -st none -pt topic200_5_0 -u 0.017230943614766764 > ./result_8chains/node200_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_6_0 -p 484 -st none -pt topic200_6_0 -u 0.01823692564313481 > ./result_8chains/node200_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_7_0 -p 953 -st none -pt topic200_7_0 -u 0.07086943035394863 > ./result_8chains/node200_7_0.txt &
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
    "./result_8chains/node200_0_0.txt 90"
    "./result_8chains/node200_0_2.txt 90"
    "./result_8chains/node200_1_0.txt 89"
    "./result_8chains/node200_1_2.txt 89"
    "./result_8chains/node200_2_0.txt 88"
    "./result_8chains/node200_2_2.txt 88"
    "./result_8chains/node200_3_0.txt 87"
    "./result_8chains/node200_3_2.txt 87"
    "./result_8chains/node200_4_0.txt 86"
    "./result_8chains/node200_4_2.txt 86"
    "./result_8chains/node200_5_0.txt 85"
    "./result_8chains/node200_5_2.txt 85"
    "./result_8chains/node200_6_0.txt 84"
    "./result_8chains/node200_6_2.txt 84"
    "./result_8chains/node200_7_0.txt 83"
    "./result_8chains/node200_7_2.txt 83"
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
