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
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_2 -p 173 -st topic471_0_1 -pt None -u 0.06151266874114181 > ./result_4chains/node471_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_2 -p 223 -st topic471_1_1 -pt None -u 0.01286559002905574 > ./result_4chains/node471_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_2 -p 602 -st topic471_2_1 -pt None -u 0.05927791562951093 > ./result_4chains/node471_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_2 -p 846 -st topic471_3_1 -pt None -u 0.11430114922245013 > ./result_4chains/node471_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_0 -p 173 -st none -pt topic471_0_0 -u 0.023306420905287617 > ./result_4chains/node471_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_0 -p 223 -st none -pt topic471_1_0 -u 0.024756610808200907 > ./result_4chains/node471_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_0 -p 602 -st none -pt topic471_2_0 -u 0.07310303033048449 > ./result_4chains/node471_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_0 -p 846 -st none -pt topic471_3_0 -u 0.012363792665807144 > ./result_4chains/node471_3_0.txt &
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
    "./result_4chains/node471_0_0.txt 90"
    "./result_4chains/node471_0_2.txt 90"
    "./result_4chains/node471_1_0.txt 89"
    "./result_4chains/node471_1_2.txt 89"
    "./result_4chains/node471_2_0.txt 88"
    "./result_4chains/node471_2_2.txt 88"
    "./result_4chains/node471_3_0.txt 87"
    "./result_4chains/node471_3_2.txt 87"
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
