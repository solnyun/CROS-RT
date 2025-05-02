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
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_2 -p 14 -st topic2_0_1 -pt None -u 0.01905268297632773 > ./result_6chains/node2_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_2 -p 273 -st topic2_1_1 -pt None -u 0.053220920936142724 > ./result_6chains/node2_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_2 -p 547 -st topic2_2_1 -pt None -u 0.0020109083992402577 > ./result_6chains/node2_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_2 -p 643 -st topic2_3_1 -pt None -u 0.010941674540530272 > ./result_6chains/node2_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_2 -p 661 -st topic2_4_1 -pt None -u 0.022826422542473926 > ./result_6chains/node2_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_2 -p 841 -st topic2_5_1 -pt None -u 0.02428811618754344 > ./result_6chains/node2_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_0 -p 14 -st none -pt topic2_0_0 -u 0.03532038445991398 > ./result_6chains/node2_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_0 -p 273 -st none -pt topic2_1_0 -u 0.05605953149746773 > ./result_6chains/node2_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_0 -p 547 -st none -pt topic2_2_0 -u 0.08264612799275778 > ./result_6chains/node2_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_0 -p 643 -st none -pt topic2_3_0 -u 0.020037886874926775 > ./result_6chains/node2_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_0 -p 661 -st none -pt topic2_4_0 -u 0.038196307694043585 > ./result_6chains/node2_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_0 -p 841 -st none -pt topic2_5_0 -u 0.0203439219385929 > ./result_6chains/node2_5_0.txt &
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
    "./result_6chains/node2_0_0.txt 90"
    "./result_6chains/node2_0_2.txt 90"
    "./result_6chains/node2_1_0.txt 89"
    "./result_6chains/node2_1_2.txt 89"
    "./result_6chains/node2_2_0.txt 88"
    "./result_6chains/node2_2_2.txt 88"
    "./result_6chains/node2_3_0.txt 87"
    "./result_6chains/node2_3_2.txt 87"
    "./result_6chains/node2_4_0.txt 86"
    "./result_6chains/node2_4_2.txt 86"
    "./result_6chains/node2_5_0.txt 85"
    "./result_6chains/node2_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
