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
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_2 -p 208 -st topic1_0_1 -pt None -u 0.028409860543249843 > ./result_8chains/node1_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_2 -p 369 -st topic1_1_1 -pt None -u 0.04923186871873986 > ./result_8chains/node1_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_2 -p 388 -st topic1_2_1 -pt None -u 0.03225950268741351 > ./result_8chains/node1_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_2 -p 427 -st topic1_3_1 -pt None -u 0.029110415615981655 > ./result_8chains/node1_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_2 -p 579 -st topic1_4_1 -pt None -u 0.02145095568373634 > ./result_8chains/node1_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_2 -p 712 -st topic1_5_1 -pt None -u 0.024943647143108538 > ./result_8chains/node1_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_6_2 -p 834 -st topic1_6_1 -pt None -u 0.03226089537425197 > ./result_8chains/node1_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_7_2 -p 841 -st topic1_7_1 -pt None -u 0.022004648151361134 > ./result_8chains/node1_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_0 -p 208 -st none -pt topic1_0_0 -u 0.022803024623829826 > ./result_8chains/node1_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_0 -p 369 -st none -pt topic1_1_0 -u 0.0037226584461031997 > ./result_8chains/node1_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_0 -p 388 -st none -pt topic1_2_0 -u 0.016881918204188662 > ./result_8chains/node1_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_0 -p 427 -st none -pt topic1_3_0 -u 0.009137738835934328 > ./result_8chains/node1_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_0 -p 579 -st none -pt topic1_4_0 -u 0.024373873575332994 > ./result_8chains/node1_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_0 -p 712 -st none -pt topic1_5_0 -u 0.016338753904601544 > ./result_8chains/node1_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_6_0 -p 834 -st none -pt topic1_6_0 -u 0.014536072495846902 > ./result_8chains/node1_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_7_0 -p 841 -st none -pt topic1_7_0 -u 0.0129499631147891 > ./result_8chains/node1_7_0.txt &
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
    "./result_8chains/node1_0_0.txt 90"
    "./result_8chains/node1_0_2.txt 90"
    "./result_8chains/node1_1_0.txt 89"
    "./result_8chains/node1_1_2.txt 89"
    "./result_8chains/node1_2_0.txt 88"
    "./result_8chains/node1_2_2.txt 88"
    "./result_8chains/node1_3_0.txt 87"
    "./result_8chains/node1_3_2.txt 87"
    "./result_8chains/node1_4_0.txt 86"
    "./result_8chains/node1_4_2.txt 86"
    "./result_8chains/node1_5_0.txt 85"
    "./result_8chains/node1_5_2.txt 85"
    "./result_8chains/node1_6_0.txt 84"
    "./result_8chains/node1_6_2.txt 84"
    "./result_8chains/node1_7_0.txt 83"
    "./result_8chains/node1_7_2.txt 83"
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
