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
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_2 -p 298 -st topic262_0_1 -pt None -u 0.008900854847636086 > ./result_4chains/node262_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_2 -p 444 -st topic262_1_1 -pt None -u 0.14517934244275482 > ./result_4chains/node262_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_2 -p 492 -st topic262_2_1 -pt None -u 0.06923167720068915 > ./result_4chains/node262_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_2 -p 529 -st topic262_3_1 -pt None -u 0.008473638830673454 > ./result_4chains/node262_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_0 -p 298 -st none -pt topic262_0_0 -u 0.03158387254781103 > ./result_4chains/node262_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_0 -p 444 -st none -pt topic262_1_0 -u 0.06296358057857487 > ./result_4chains/node262_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_0 -p 492 -st none -pt topic262_2_0 -u 0.04523215309034137 > ./result_4chains/node262_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_0 -p 529 -st none -pt topic262_3_0 -u 0.001920664720680091 > ./result_4chains/node262_3_0.txt &
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
    "./result_4chains/node262_0_0.txt 90"
    "./result_4chains/node262_0_2.txt 90"
    "./result_4chains/node262_1_0.txt 89"
    "./result_4chains/node262_1_2.txt 89"
    "./result_4chains/node262_2_0.txt 88"
    "./result_4chains/node262_2_2.txt 88"
    "./result_4chains/node262_3_0.txt 87"
    "./result_4chains/node262_3_2.txt 87"
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
