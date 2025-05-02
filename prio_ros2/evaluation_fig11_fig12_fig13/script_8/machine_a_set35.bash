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
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_2 -p 28 -st topic35_0_1 -pt None -u 0.0655792752722068 > ./result_8chains/node35_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_2 -p 107 -st topic35_1_1 -pt None -u 0.031765909925267566 > ./result_8chains/node35_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_2 -p 172 -st topic35_2_1 -pt None -u 0.006360220221124813 > ./result_8chains/node35_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_2 -p 200 -st topic35_3_1 -pt None -u 0.0009236461785079308 > ./result_8chains/node35_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_2 -p 246 -st topic35_4_1 -pt None -u 0.017102512307506063 > ./result_8chains/node35_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_2 -p 733 -st topic35_5_1 -pt None -u 0.011715266921278722 > ./result_8chains/node35_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_6_2 -p 737 -st topic35_6_1 -pt None -u 0.007337005848943701 > ./result_8chains/node35_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_7_2 -p 979 -st topic35_7_1 -pt None -u 0.019007865011271524 > ./result_8chains/node35_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_0 -p 28 -st none -pt topic35_0_0 -u 0.01208682233926972 > ./result_8chains/node35_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_0 -p 107 -st none -pt topic35_1_0 -u 0.010452932820264715 > ./result_8chains/node35_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_0 -p 172 -st none -pt topic35_2_0 -u 0.02048943168841727 > ./result_8chains/node35_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_0 -p 200 -st none -pt topic35_3_0 -u 0.00869838880881929 > ./result_8chains/node35_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_0 -p 246 -st none -pt topic35_4_0 -u 0.010644775059087785 > ./result_8chains/node35_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_0 -p 733 -st none -pt topic35_5_0 -u 0.009416346466159048 > ./result_8chains/node35_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_6_0 -p 737 -st none -pt topic35_6_0 -u 0.05300131452701262 > ./result_8chains/node35_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_7_0 -p 979 -st none -pt topic35_7_0 -u 0.08337472722233541 > ./result_8chains/node35_7_0.txt &
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
    "./result_8chains/node35_0_0.txt 90"
    "./result_8chains/node35_0_2.txt 90"
    "./result_8chains/node35_1_0.txt 89"
    "./result_8chains/node35_1_2.txt 89"
    "./result_8chains/node35_2_0.txt 88"
    "./result_8chains/node35_2_2.txt 88"
    "./result_8chains/node35_3_0.txt 87"
    "./result_8chains/node35_3_2.txt 87"
    "./result_8chains/node35_4_0.txt 86"
    "./result_8chains/node35_4_2.txt 86"
    "./result_8chains/node35_5_0.txt 85"
    "./result_8chains/node35_5_2.txt 85"
    "./result_8chains/node35_6_0.txt 84"
    "./result_8chains/node35_6_2.txt 84"
    "./result_8chains/node35_7_0.txt 83"
    "./result_8chains/node35_7_2.txt 83"
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
