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
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_2 -p 67 -st topic408_0_1 -pt None -u 0.007847914014274426 > ./result_6chains/node408_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_2 -p 110 -st topic408_1_1 -pt None -u 0.0037746531356662727 > ./result_6chains/node408_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_2 -p 190 -st topic408_2_1 -pt None -u 0.0014559722578033896 > ./result_6chains/node408_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_2 -p 265 -st topic408_3_1 -pt None -u 0.006784122290803746 > ./result_6chains/node408_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_2 -p 348 -st topic408_4_1 -pt None -u 0.01119937847279718 > ./result_6chains/node408_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_2 -p 906 -st topic408_5_1 -pt None -u 0.008616712711829838 > ./result_6chains/node408_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_0 -p 67 -st none -pt topic408_0_0 -u 0.06878023389372262 > ./result_6chains/node408_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_0 -p 110 -st none -pt topic408_1_0 -u 0.05463435688525009 > ./result_6chains/node408_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_0 -p 190 -st none -pt topic408_2_0 -u 0.043969358717072415 > ./result_6chains/node408_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_0 -p 265 -st none -pt topic408_3_0 -u 0.009042359389230925 > ./result_6chains/node408_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_0 -p 348 -st none -pt topic408_4_0 -u 0.04266933286665567 > ./result_6chains/node408_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_0 -p 906 -st none -pt topic408_5_0 -u 0.02141894155382188 > ./result_6chains/node408_5_0.txt &
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
    "./result_6chains/node408_0_0.txt 90"
    "./result_6chains/node408_0_2.txt 90"
    "./result_6chains/node408_1_0.txt 89"
    "./result_6chains/node408_1_2.txt 89"
    "./result_6chains/node408_2_0.txt 88"
    "./result_6chains/node408_2_2.txt 88"
    "./result_6chains/node408_3_0.txt 87"
    "./result_6chains/node408_3_2.txt 87"
    "./result_6chains/node408_4_0.txt 86"
    "./result_6chains/node408_4_2.txt 86"
    "./result_6chains/node408_5_0.txt 85"
    "./result_6chains/node408_5_2.txt 85"
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
