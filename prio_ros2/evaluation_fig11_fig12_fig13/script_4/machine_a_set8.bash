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
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_2 -p 392 -st topic8_0_1 -pt None -u 0.004186342634155016 > ./result_4chains/node8_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_2 -p 444 -st topic8_1_1 -pt None -u 0.08463524102299386 > ./result_4chains/node8_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_2 -p 563 -st topic8_2_1 -pt None -u 0.03932067479129123 > ./result_4chains/node8_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_2 -p 632 -st topic8_3_1 -pt None -u 0.00015100251459874048 > ./result_4chains/node8_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_0 -p 392 -st none -pt topic8_0_0 -u 0.0420474506188539 > ./result_4chains/node8_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_0 -p 444 -st none -pt topic8_1_0 -u 0.018248181282250253 > ./result_4chains/node8_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_0 -p 563 -st none -pt topic8_2_0 -u 0.07925619000816256 > ./result_4chains/node8_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_0 -p 632 -st none -pt topic8_3_0 -u 0.014274833025318234 > ./result_4chains/node8_3_0.txt &
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
    "./result_4chains/node8_0_0.txt 90"
    "./result_4chains/node8_0_2.txt 90"
    "./result_4chains/node8_1_0.txt 89"
    "./result_4chains/node8_1_2.txt 89"
    "./result_4chains/node8_2_0.txt 88"
    "./result_4chains/node8_2_2.txt 88"
    "./result_4chains/node8_3_0.txt 87"
    "./result_4chains/node8_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
