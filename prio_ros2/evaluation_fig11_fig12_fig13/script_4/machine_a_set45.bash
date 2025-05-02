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
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_2 -p 88 -st topic45_0_1 -pt None -u 0.013708727829962408 > ./result_4chains/node45_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_2 -p 99 -st topic45_1_1 -pt None -u 0.07626163177300083 > ./result_4chains/node45_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_2 -p 295 -st topic45_2_1 -pt None -u 0.0340586688409788 > ./result_4chains/node45_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_2 -p 630 -st topic45_3_1 -pt None -u 0.025739405567696765 > ./result_4chains/node45_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_0 -p 88 -st none -pt topic45_0_0 -u 0.06874879891125724 > ./result_4chains/node45_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_0 -p 99 -st none -pt topic45_1_0 -u 0.012912654837381077 > ./result_4chains/node45_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_0 -p 295 -st none -pt topic45_2_0 -u 0.08542032976045252 > ./result_4chains/node45_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_0 -p 630 -st none -pt topic45_3_0 -u 0.04710027527925846 > ./result_4chains/node45_3_0.txt &
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
    "./result_4chains/node45_0_0.txt 90"
    "./result_4chains/node45_0_2.txt 90"
    "./result_4chains/node45_1_0.txt 89"
    "./result_4chains/node45_1_2.txt 89"
    "./result_4chains/node45_2_0.txt 88"
    "./result_4chains/node45_2_2.txt 88"
    "./result_4chains/node45_3_0.txt 87"
    "./result_4chains/node45_3_2.txt 87"
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
