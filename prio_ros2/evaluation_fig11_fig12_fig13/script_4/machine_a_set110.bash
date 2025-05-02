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
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_2 -p 439 -st topic110_0_1 -pt None -u 0.025850412889052377 > ./result_4chains/node110_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_2 -p 448 -st topic110_1_1 -pt None -u 0.029191691722003588 > ./result_4chains/node110_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_2 -p 707 -st topic110_2_1 -pt None -u 0.03692466084212881 > ./result_4chains/node110_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_2 -p 773 -st topic110_3_1 -pt None -u 0.005910122560106267 > ./result_4chains/node110_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_0 -p 439 -st none -pt topic110_0_0 -u 0.10233992471306674 > ./result_4chains/node110_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_0 -p 448 -st none -pt topic110_1_0 -u 0.037026501647832 > ./result_4chains/node110_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_0 -p 707 -st none -pt topic110_2_0 -u 0.037275980805311165 > ./result_4chains/node110_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_0 -p 773 -st none -pt topic110_3_0 -u 0.05445868740745248 > ./result_4chains/node110_3_0.txt &
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
    "./result_4chains/node110_0_0.txt 90"
    "./result_4chains/node110_0_2.txt 90"
    "./result_4chains/node110_1_0.txt 89"
    "./result_4chains/node110_1_2.txt 89"
    "./result_4chains/node110_2_0.txt 88"
    "./result_4chains/node110_2_2.txt 88"
    "./result_4chains/node110_3_0.txt 87"
    "./result_4chains/node110_3_2.txt 87"
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
