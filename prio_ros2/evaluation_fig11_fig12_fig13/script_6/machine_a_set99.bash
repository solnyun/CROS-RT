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
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_2 -p 88 -st topic99_0_1 -pt None -u 0.011983370101728397 > ./result_6chains/node99_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_2 -p 166 -st topic99_1_1 -pt None -u 0.009474937865218025 > ./result_6chains/node99_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_2 -p 171 -st topic99_2_1 -pt None -u 0.009423905413149636 > ./result_6chains/node99_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_2 -p 418 -st topic99_3_1 -pt None -u 0.028305497727191264 > ./result_6chains/node99_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_2 -p 425 -st topic99_4_1 -pt None -u 0.09211287925953296 > ./result_6chains/node99_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_2 -p 932 -st topic99_5_1 -pt None -u 0.02310528539862906 > ./result_6chains/node99_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_0 -p 88 -st none -pt topic99_0_0 -u 0.019564226725274525 > ./result_6chains/node99_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_0 -p 166 -st none -pt topic99_1_0 -u 0.06555844401151417 > ./result_6chains/node99_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_0 -p 171 -st none -pt topic99_2_0 -u 0.04244507031893058 > ./result_6chains/node99_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_0 -p 418 -st none -pt topic99_3_0 -u 0.0562559968483389 > ./result_6chains/node99_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_0 -p 425 -st none -pt topic99_4_0 -u 0.023041108913525815 > ./result_6chains/node99_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_0 -p 932 -st none -pt topic99_5_0 -u 0.04452589717091113 > ./result_6chains/node99_5_0.txt &
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
    "./result_6chains/node99_0_0.txt 90"
    "./result_6chains/node99_0_2.txt 90"
    "./result_6chains/node99_1_0.txt 89"
    "./result_6chains/node99_1_2.txt 89"
    "./result_6chains/node99_2_0.txt 88"
    "./result_6chains/node99_2_2.txt 88"
    "./result_6chains/node99_3_0.txt 87"
    "./result_6chains/node99_3_2.txt 87"
    "./result_6chains/node99_4_0.txt 86"
    "./result_6chains/node99_4_2.txt 86"
    "./result_6chains/node99_5_0.txt 85"
    "./result_6chains/node99_5_2.txt 85"
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
