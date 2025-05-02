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
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_2 -p 217 -st topic197_0_1 -pt None -u 0.052782505517395495 > ./result_4chains/node197_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_2 -p 517 -st topic197_1_1 -pt None -u 0.003762162150113102 > ./result_4chains/node197_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_2 -p 653 -st topic197_2_1 -pt None -u 0.10304950593866097 > ./result_4chains/node197_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_2 -p 977 -st topic197_3_1 -pt None -u 0.004468552474506596 > ./result_4chains/node197_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_0 -p 217 -st none -pt topic197_0_0 -u 0.02592651608316132 > ./result_4chains/node197_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_0 -p 517 -st none -pt topic197_1_0 -u 0.029540115015872503 > ./result_4chains/node197_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_0 -p 653 -st none -pt topic197_2_0 -u 0.029440740917505342 > ./result_4chains/node197_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_0 -p 977 -st none -pt topic197_3_0 -u 0.045562474013797406 > ./result_4chains/node197_3_0.txt &
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
    "./result_4chains/node197_0_0.txt 90"
    "./result_4chains/node197_0_2.txt 90"
    "./result_4chains/node197_1_0.txt 89"
    "./result_4chains/node197_1_2.txt 89"
    "./result_4chains/node197_2_0.txt 88"
    "./result_4chains/node197_2_2.txt 88"
    "./result_4chains/node197_3_0.txt 87"
    "./result_4chains/node197_3_2.txt 87"
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
