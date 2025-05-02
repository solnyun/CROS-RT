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
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_2 -p 87 -st topic451_0_1 -pt None -u 0.012589755977645 > ./result_8chains/node451_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_2 -p 126 -st topic451_1_1 -pt None -u 0.00794264273818679 > ./result_8chains/node451_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_2 -p 236 -st topic451_2_1 -pt None -u 0.0076665394430734946 > ./result_8chains/node451_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_2 -p 260 -st topic451_3_1 -pt None -u 0.0033910203464023736 > ./result_8chains/node451_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_2 -p 364 -st topic451_4_1 -pt None -u 0.006002020304262418 > ./result_8chains/node451_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_2 -p 396 -st topic451_5_1 -pt None -u 0.005053323439624474 > ./result_8chains/node451_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_6_2 -p 478 -st topic451_6_1 -pt None -u 0.004794191806047218 > ./result_8chains/node451_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_7_2 -p 562 -st topic451_7_1 -pt None -u 0.01163955983506815 > ./result_8chains/node451_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_0 -p 87 -st none -pt topic451_0_0 -u 0.008589601170310768 > ./result_8chains/node451_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_0 -p 126 -st none -pt topic451_1_0 -u 0.015898108343163353 > ./result_8chains/node451_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_0 -p 236 -st none -pt topic451_2_0 -u 0.004875515698209765 > ./result_8chains/node451_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_0 -p 260 -st none -pt topic451_3_0 -u 0.00047512265801552545 > ./result_8chains/node451_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_0 -p 364 -st none -pt topic451_4_0 -u 0.01304405863766328 > ./result_8chains/node451_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_0 -p 396 -st none -pt topic451_5_0 -u 0.007641321489848779 > ./result_8chains/node451_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_6_0 -p 478 -st none -pt topic451_6_0 -u 0.009106755649380849 > ./result_8chains/node451_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_7_0 -p 562 -st none -pt topic451_7_0 -u 0.010519327122155503 > ./result_8chains/node451_7_0.txt &
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
    "./result_8chains/node451_0_0.txt 90"
    "./result_8chains/node451_0_2.txt 90"
    "./result_8chains/node451_1_0.txt 89"
    "./result_8chains/node451_1_2.txt 89"
    "./result_8chains/node451_2_0.txt 88"
    "./result_8chains/node451_2_2.txt 88"
    "./result_8chains/node451_3_0.txt 87"
    "./result_8chains/node451_3_2.txt 87"
    "./result_8chains/node451_4_0.txt 86"
    "./result_8chains/node451_4_2.txt 86"
    "./result_8chains/node451_5_0.txt 85"
    "./result_8chains/node451_5_2.txt 85"
    "./result_8chains/node451_6_0.txt 84"
    "./result_8chains/node451_6_2.txt 84"
    "./result_8chains/node451_7_0.txt 83"
    "./result_8chains/node451_7_2.txt 83"
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
