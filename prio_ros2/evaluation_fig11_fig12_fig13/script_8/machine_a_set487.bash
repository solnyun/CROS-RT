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
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_2 -p 25 -st topic487_0_1 -pt None -u 0.0031179288749423884 > ./result_8chains/node487_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_2 -p 106 -st topic487_1_1 -pt None -u 0.017457468475463644 > ./result_8chains/node487_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_2 -p 181 -st topic487_2_1 -pt None -u 0.0027998492695432975 > ./result_8chains/node487_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_2 -p 413 -st topic487_3_1 -pt None -u 0.013475510892552556 > ./result_8chains/node487_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_2 -p 579 -st topic487_4_1 -pt None -u 0.013347335772680768 > ./result_8chains/node487_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_2 -p 739 -st topic487_5_1 -pt None -u 0.015573876478387122 > ./result_8chains/node487_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_6_2 -p 815 -st topic487_6_1 -pt None -u 0.0014426895994564815 > ./result_8chains/node487_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_7_2 -p 854 -st topic487_7_1 -pt None -u 0.01580593985624463 > ./result_8chains/node487_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_0 -p 25 -st none -pt topic487_0_0 -u 0.030139784104899425 > ./result_8chains/node487_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_0 -p 106 -st none -pt topic487_1_0 -u 0.005996855117215538 > ./result_8chains/node487_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_0 -p 181 -st none -pt topic487_2_0 -u 0.03500839525970084 > ./result_8chains/node487_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_0 -p 413 -st none -pt topic487_3_0 -u 0.015902510292471195 > ./result_8chains/node487_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_0 -p 579 -st none -pt topic487_4_0 -u 0.008487564256235092 > ./result_8chains/node487_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_0 -p 739 -st none -pt topic487_5_0 -u 0.02531257252116259 > ./result_8chains/node487_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_6_0 -p 815 -st none -pt topic487_6_0 -u 0.012347050772304663 > ./result_8chains/node487_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_7_0 -p 854 -st none -pt topic487_7_0 -u 0.08941532684724116 > ./result_8chains/node487_7_0.txt &
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
    "./result_8chains/node487_0_0.txt 90"
    "./result_8chains/node487_0_2.txt 90"
    "./result_8chains/node487_1_0.txt 89"
    "./result_8chains/node487_1_2.txt 89"
    "./result_8chains/node487_2_0.txt 88"
    "./result_8chains/node487_2_2.txt 88"
    "./result_8chains/node487_3_0.txt 87"
    "./result_8chains/node487_3_2.txt 87"
    "./result_8chains/node487_4_0.txt 86"
    "./result_8chains/node487_4_2.txt 86"
    "./result_8chains/node487_5_0.txt 85"
    "./result_8chains/node487_5_2.txt 85"
    "./result_8chains/node487_6_0.txt 84"
    "./result_8chains/node487_6_2.txt 84"
    "./result_8chains/node487_7_0.txt 83"
    "./result_8chains/node487_7_2.txt 83"
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
