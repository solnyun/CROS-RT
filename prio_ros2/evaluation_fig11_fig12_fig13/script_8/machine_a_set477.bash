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
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_2 -p 65 -st topic477_0_1 -pt None -u 0.007810454848185822 > ./result_8chains/node477_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_2 -p 258 -st topic477_1_1 -pt None -u 0.009060149150935115 > ./result_8chains/node477_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_2 -p 330 -st topic477_2_1 -pt None -u 0.04086865748368701 > ./result_8chains/node477_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_2 -p 407 -st topic477_3_1 -pt None -u 0.0016484599200560224 > ./result_8chains/node477_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_2 -p 537 -st topic477_4_1 -pt None -u 0.06569342931367791 > ./result_8chains/node477_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_2 -p 688 -st topic477_5_1 -pt None -u 0.057568572885179525 > ./result_8chains/node477_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_6_2 -p 785 -st topic477_6_1 -pt None -u 0.01665420929940506 > ./result_8chains/node477_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_7_2 -p 821 -st topic477_7_1 -pt None -u 0.024093584484663824 > ./result_8chains/node477_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_0 -p 65 -st none -pt topic477_0_0 -u 0.034917310960111414 > ./result_8chains/node477_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_0 -p 258 -st none -pt topic477_1_0 -u 0.0085806826948579 > ./result_8chains/node477_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_0 -p 330 -st none -pt topic477_2_0 -u 0.010990247787419971 > ./result_8chains/node477_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_0 -p 407 -st none -pt topic477_3_0 -u 0.002784097026854282 > ./result_8chains/node477_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_0 -p 537 -st none -pt topic477_4_0 -u 0.01833270648230706 > ./result_8chains/node477_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_0 -p 688 -st none -pt topic477_5_0 -u 0.02334859038127557 > ./result_8chains/node477_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_6_0 -p 785 -st none -pt topic477_6_0 -u 0.02312359605886575 > ./result_8chains/node477_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_7_0 -p 821 -st none -pt topic477_7_0 -u 0.0076938510559392825 > ./result_8chains/node477_7_0.txt &
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
    "./result_8chains/node477_0_0.txt 90"
    "./result_8chains/node477_0_2.txt 90"
    "./result_8chains/node477_1_0.txt 89"
    "./result_8chains/node477_1_2.txt 89"
    "./result_8chains/node477_2_0.txt 88"
    "./result_8chains/node477_2_2.txt 88"
    "./result_8chains/node477_3_0.txt 87"
    "./result_8chains/node477_3_2.txt 87"
    "./result_8chains/node477_4_0.txt 86"
    "./result_8chains/node477_4_2.txt 86"
    "./result_8chains/node477_5_0.txt 85"
    "./result_8chains/node477_5_2.txt 85"
    "./result_8chains/node477_6_0.txt 84"
    "./result_8chains/node477_6_2.txt 84"
    "./result_8chains/node477_7_0.txt 83"
    "./result_8chains/node477_7_2.txt 83"
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
