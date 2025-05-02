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
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_2 -p 148 -st topic237_0_1 -pt None -u 0.021730947803648926 > ./result_6chains/node237_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_2 -p 323 -st topic237_1_1 -pt None -u 0.011745472944034108 > ./result_6chains/node237_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_2 -p 575 -st topic237_2_1 -pt None -u 0.021005618131003212 > ./result_6chains/node237_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_2 -p 630 -st topic237_3_1 -pt None -u 0.0033454562334274407 > ./result_6chains/node237_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_2 -p 631 -st topic237_4_1 -pt None -u 0.08602870431684673 > ./result_6chains/node237_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_2 -p 673 -st topic237_5_1 -pt None -u 0.020564303476344803 > ./result_6chains/node237_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_0_0 -p 148 -st none -pt topic237_0_0 -u 0.06492829676077733 > ./result_6chains/node237_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_1_0 -p 323 -st none -pt topic237_1_0 -u 0.0004705978179879722 > ./result_6chains/node237_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_2_0 -p 575 -st none -pt topic237_2_0 -u 0.032923214726671035 > ./result_6chains/node237_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_3_0 -p 630 -st none -pt topic237_3_0 -u 0.06060727026360768 > ./result_6chains/node237_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node237_4_0 -p 631 -st none -pt topic237_4_0 -u 0.015663420021965274 > ./result_6chains/node237_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node237_5_0 -p 673 -st none -pt topic237_5_0 -u 0.052372988518538506 > ./result_6chains/node237_5_0.txt &
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
    "./result_6chains/node237_0_0.txt 90"
    "./result_6chains/node237_0_2.txt 90"
    "./result_6chains/node237_1_0.txt 89"
    "./result_6chains/node237_1_2.txt 89"
    "./result_6chains/node237_2_0.txt 88"
    "./result_6chains/node237_2_2.txt 88"
    "./result_6chains/node237_3_0.txt 87"
    "./result_6chains/node237_3_2.txt 87"
    "./result_6chains/node237_4_0.txt 86"
    "./result_6chains/node237_4_2.txt 86"
    "./result_6chains/node237_5_0.txt 85"
    "./result_6chains/node237_5_2.txt 85"
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
