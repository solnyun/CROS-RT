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
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_2 -p 69 -st topic175_0_1 -pt None -u 0.00840244349506769 > ./result_8chains/node175_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_2 -p 219 -st topic175_1_1 -pt None -u 0.015092025647659268 > ./result_8chains/node175_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_2 -p 259 -st topic175_2_1 -pt None -u 0.00968704012510524 > ./result_8chains/node175_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_2 -p 590 -st topic175_3_1 -pt None -u 0.015762422587120795 > ./result_8chains/node175_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_2 -p 642 -st topic175_4_1 -pt None -u 0.025872728552563562 > ./result_8chains/node175_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_2 -p 759 -st topic175_5_1 -pt None -u 0.03347419542622587 > ./result_8chains/node175_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_6_2 -p 815 -st topic175_6_1 -pt None -u 0.008684963167779614 > ./result_8chains/node175_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_7_2 -p 902 -st topic175_7_1 -pt None -u 0.03124487107791088 > ./result_8chains/node175_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_0 -p 69 -st none -pt topic175_0_0 -u 0.014876178845145138 > ./result_8chains/node175_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_0 -p 219 -st none -pt topic175_1_0 -u 0.002202462757994461 > ./result_8chains/node175_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_0 -p 259 -st none -pt topic175_2_0 -u 0.015262951771322752 > ./result_8chains/node175_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_0 -p 590 -st none -pt topic175_3_0 -u 0.005097204482457929 > ./result_8chains/node175_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_0 -p 642 -st none -pt topic175_4_0 -u 0.07733042723234446 > ./result_8chains/node175_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_0 -p 759 -st none -pt topic175_5_0 -u 0.0037712941193999705 > ./result_8chains/node175_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_6_0 -p 815 -st none -pt topic175_6_0 -u 0.03758714219903912 > ./result_8chains/node175_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_7_0 -p 902 -st none -pt topic175_7_0 -u 0.05191042822029547 > ./result_8chains/node175_7_0.txt &
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
    "./result_8chains/node175_0_0.txt 90"
    "./result_8chains/node175_0_2.txt 90"
    "./result_8chains/node175_1_0.txt 89"
    "./result_8chains/node175_1_2.txt 89"
    "./result_8chains/node175_2_0.txt 88"
    "./result_8chains/node175_2_2.txt 88"
    "./result_8chains/node175_3_0.txt 87"
    "./result_8chains/node175_3_2.txt 87"
    "./result_8chains/node175_4_0.txt 86"
    "./result_8chains/node175_4_2.txt 86"
    "./result_8chains/node175_5_0.txt 85"
    "./result_8chains/node175_5_2.txt 85"
    "./result_8chains/node175_6_0.txt 84"
    "./result_8chains/node175_6_2.txt 84"
    "./result_8chains/node175_7_0.txt 83"
    "./result_8chains/node175_7_2.txt 83"
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
