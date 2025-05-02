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
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_2 -p 149 -st topic295_0_1 -pt None -u 0.007573074534626079 > ./result_4chains/node295_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_2 -p 343 -st topic295_1_1 -pt None -u 0.027379432082171806 > ./result_4chains/node295_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_2 -p 426 -st topic295_2_1 -pt None -u 0.01092901015946441 > ./result_4chains/node295_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_2 -p 613 -st topic295_3_1 -pt None -u 0.005530767262033265 > ./result_4chains/node295_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_0 -p 149 -st none -pt topic295_0_0 -u 0.15094217494145834 > ./result_4chains/node295_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_0 -p 343 -st none -pt topic295_1_0 -u 0.04142972608014295 > ./result_4chains/node295_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_0 -p 426 -st none -pt topic295_2_0 -u 0.09811831904581372 > ./result_4chains/node295_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_0 -p 613 -st none -pt topic295_3_0 -u 0.0016236546309615144 > ./result_4chains/node295_3_0.txt &
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
    "./result_4chains/node295_0_0.txt 90"
    "./result_4chains/node295_0_2.txt 90"
    "./result_4chains/node295_1_0.txt 89"
    "./result_4chains/node295_1_2.txt 89"
    "./result_4chains/node295_2_0.txt 88"
    "./result_4chains/node295_2_2.txt 88"
    "./result_4chains/node295_3_0.txt 87"
    "./result_4chains/node295_3_2.txt 87"
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
