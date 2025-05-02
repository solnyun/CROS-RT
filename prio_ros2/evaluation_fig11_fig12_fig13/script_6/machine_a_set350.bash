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
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_2 -p 363 -st topic350_0_1 -pt None -u 0.01660123306990302 > ./result_6chains/node350_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_2 -p 374 -st topic350_1_1 -pt None -u 0.01383436232870211 > ./result_6chains/node350_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_2 -p 612 -st topic350_2_1 -pt None -u 0.021112053787315843 > ./result_6chains/node350_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_2 -p 658 -st topic350_3_1 -pt None -u 0.018631549640678702 > ./result_6chains/node350_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_2 -p 664 -st topic350_4_1 -pt None -u 0.0333019003246751 > ./result_6chains/node350_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_2 -p 958 -st topic350_5_1 -pt None -u 0.01212645308752174 > ./result_6chains/node350_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_0 -p 363 -st none -pt topic350_0_0 -u 0.0588215800422528 > ./result_6chains/node350_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_0 -p 374 -st none -pt topic350_1_0 -u 0.05188988195828459 > ./result_6chains/node350_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_0 -p 612 -st none -pt topic350_2_0 -u 0.024784671680002923 > ./result_6chains/node350_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_0 -p 658 -st none -pt topic350_3_0 -u 0.021172101335491356 > ./result_6chains/node350_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_0 -p 664 -st none -pt topic350_4_0 -u 0.006363321498761593 > ./result_6chains/node350_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_0 -p 958 -st none -pt topic350_5_0 -u 0.01250562265632469 > ./result_6chains/node350_5_0.txt &
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
    "./result_6chains/node350_0_0.txt 90"
    "./result_6chains/node350_0_2.txt 90"
    "./result_6chains/node350_1_0.txt 89"
    "./result_6chains/node350_1_2.txt 89"
    "./result_6chains/node350_2_0.txt 88"
    "./result_6chains/node350_2_2.txt 88"
    "./result_6chains/node350_3_0.txt 87"
    "./result_6chains/node350_3_2.txt 87"
    "./result_6chains/node350_4_0.txt 86"
    "./result_6chains/node350_4_2.txt 86"
    "./result_6chains/node350_5_0.txt 85"
    "./result_6chains/node350_5_2.txt 85"
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
