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
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_2 -p 327 -st topic400_0_1 -pt None -u 0.024033376775884296 > ./result_4chains/node400_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_2 -p 417 -st topic400_1_1 -pt None -u 0.015444668289641472 > ./result_4chains/node400_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_2 -p 589 -st topic400_2_1 -pt None -u 0.03031344116796525 > ./result_4chains/node400_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_2 -p 745 -st topic400_3_1 -pt None -u 0.14208496211819507 > ./result_4chains/node400_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_0_0 -p 327 -st none -pt topic400_0_0 -u 0.06368622628381371 > ./result_4chains/node400_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_1_0 -p 417 -st none -pt topic400_1_0 -u 0.07330976578809728 > ./result_4chains/node400_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node400_2_0 -p 589 -st none -pt topic400_2_0 -u 0.008101831030467133 > ./result_4chains/node400_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node400_3_0 -p 745 -st none -pt topic400_3_0 -u 0.049103949866800445 > ./result_4chains/node400_3_0.txt &
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
    "./result_4chains/node400_0_0.txt 90"
    "./result_4chains/node400_0_2.txt 90"
    "./result_4chains/node400_1_0.txt 89"
    "./result_4chains/node400_1_2.txt 89"
    "./result_4chains/node400_2_0.txt 88"
    "./result_4chains/node400_2_2.txt 88"
    "./result_4chains/node400_3_0.txt 87"
    "./result_4chains/node400_3_2.txt 87"
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
