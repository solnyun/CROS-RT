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
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_2 -p 11 -st topic435_0_1 -pt None -u 0.02292861879188096 > ./result_8chains/node435_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_2 -p 155 -st topic435_1_1 -pt None -u 0.007880594911313099 > ./result_8chains/node435_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_2 -p 182 -st topic435_2_1 -pt None -u 0.010502903053339396 > ./result_8chains/node435_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_2 -p 305 -st topic435_3_1 -pt None -u 0.017562825818334626 > ./result_8chains/node435_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_2 -p 754 -st topic435_4_1 -pt None -u 0.007476732558133553 > ./result_8chains/node435_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_2 -p 861 -st topic435_5_1 -pt None -u 0.009411846336304625 > ./result_8chains/node435_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_6_2 -p 931 -st topic435_6_1 -pt None -u 0.013317861388698435 > ./result_8chains/node435_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_7_2 -p 959 -st topic435_7_1 -pt None -u 0.04850124459689783 > ./result_8chains/node435_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_0 -p 11 -st none -pt topic435_0_0 -u 0.024856171311201714 > ./result_8chains/node435_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_0 -p 155 -st none -pt topic435_1_0 -u 0.0027290162298995724 > ./result_8chains/node435_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_0 -p 182 -st none -pt topic435_2_0 -u 0.009924022782856479 > ./result_8chains/node435_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_0 -p 305 -st none -pt topic435_3_0 -u 0.030928487583288367 > ./result_8chains/node435_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_0 -p 754 -st none -pt topic435_4_0 -u 0.015616448410512851 > ./result_8chains/node435_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_0 -p 861 -st none -pt topic435_5_0 -u 0.005269338668842022 > ./result_8chains/node435_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_6_0 -p 931 -st none -pt topic435_6_0 -u 0.08815262728574111 > ./result_8chains/node435_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_7_0 -p 959 -st none -pt topic435_7_0 -u 0.00989381390815533 > ./result_8chains/node435_7_0.txt &
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
    "./result_8chains/node435_0_0.txt 90"
    "./result_8chains/node435_0_2.txt 90"
    "./result_8chains/node435_1_0.txt 89"
    "./result_8chains/node435_1_2.txt 89"
    "./result_8chains/node435_2_0.txt 88"
    "./result_8chains/node435_2_2.txt 88"
    "./result_8chains/node435_3_0.txt 87"
    "./result_8chains/node435_3_2.txt 87"
    "./result_8chains/node435_4_0.txt 86"
    "./result_8chains/node435_4_2.txt 86"
    "./result_8chains/node435_5_0.txt 85"
    "./result_8chains/node435_5_2.txt 85"
    "./result_8chains/node435_6_0.txt 84"
    "./result_8chains/node435_6_2.txt 84"
    "./result_8chains/node435_7_0.txt 83"
    "./result_8chains/node435_7_2.txt 83"
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
