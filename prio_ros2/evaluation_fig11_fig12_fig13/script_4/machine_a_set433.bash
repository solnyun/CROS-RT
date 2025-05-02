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
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_2 -p 169 -st topic433_0_1 -pt None -u 0.02341224839301015 > ./result_4chains/node433_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_2 -p 396 -st topic433_1_1 -pt None -u 0.014560272130315854 > ./result_4chains/node433_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_2 -p 587 -st topic433_2_1 -pt None -u 0.009425736164017595 > ./result_4chains/node433_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_2 -p 799 -st topic433_3_1 -pt None -u 0.11152951743341094 > ./result_4chains/node433_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_0 -p 169 -st none -pt topic433_0_0 -u 4.539466420772076e-05 > ./result_4chains/node433_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_0 -p 396 -st none -pt topic433_1_0 -u 0.0537830995958391 > ./result_4chains/node433_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_0 -p 587 -st none -pt topic433_2_0 -u 0.002158326881825323 > ./result_4chains/node433_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_0 -p 799 -st none -pt topic433_3_0 -u 0.14194232578044141 > ./result_4chains/node433_3_0.txt &
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
    "./result_4chains/node433_0_0.txt 90"
    "./result_4chains/node433_0_2.txt 90"
    "./result_4chains/node433_1_0.txt 89"
    "./result_4chains/node433_1_2.txt 89"
    "./result_4chains/node433_2_0.txt 88"
    "./result_4chains/node433_2_2.txt 88"
    "./result_4chains/node433_3_0.txt 87"
    "./result_4chains/node433_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
