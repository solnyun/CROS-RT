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
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_2 -p 44 -st topic29_0_1 -pt None -u 0.05966918253469783 > ./result_4chains/node29_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_2 -p 296 -st topic29_1_1 -pt None -u 0.0093672894178497 > ./result_4chains/node29_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_2 -p 658 -st topic29_2_1 -pt None -u 0.0053643042284658715 > ./result_4chains/node29_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_2 -p 693 -st topic29_3_1 -pt None -u 0.0032026661930736494 > ./result_4chains/node29_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_0 -p 44 -st none -pt topic29_0_0 -u 0.043648181291880694 > ./result_4chains/node29_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_0 -p 296 -st none -pt topic29_1_0 -u 0.021033083001135544 > ./result_4chains/node29_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_0 -p 658 -st none -pt topic29_2_0 -u 0.0648451211806407 > ./result_4chains/node29_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_0 -p 693 -st none -pt topic29_3_0 -u 0.04359500788862782 > ./result_4chains/node29_3_0.txt &
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
    "./result_4chains/node29_0_0.txt 90"
    "./result_4chains/node29_0_2.txt 90"
    "./result_4chains/node29_1_0.txt 89"
    "./result_4chains/node29_1_2.txt 89"
    "./result_4chains/node29_2_0.txt 88"
    "./result_4chains/node29_2_2.txt 88"
    "./result_4chains/node29_3_0.txt 87"
    "./result_4chains/node29_3_2.txt 87"
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
