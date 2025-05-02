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
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_2 -p 219 -st topic149_0_1 -pt None -u 0.038633211837688475 > ./result_4chains/node149_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_2 -p 228 -st topic149_1_1 -pt None -u 0.12873858138822603 > ./result_4chains/node149_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_2 -p 437 -st topic149_2_1 -pt None -u 0.03762053546209197 > ./result_4chains/node149_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_2 -p 623 -st topic149_3_1 -pt None -u 0.03057268188182475 > ./result_4chains/node149_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_0 -p 219 -st none -pt topic149_0_0 -u 0.005394969082192946 > ./result_4chains/node149_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_0 -p 228 -st none -pt topic149_1_0 -u 0.005172222590329623 > ./result_4chains/node149_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_0 -p 437 -st none -pt topic149_2_0 -u 0.011019145670960656 > ./result_4chains/node149_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_0 -p 623 -st none -pt topic149_3_0 -u 0.024117799254986333 > ./result_4chains/node149_3_0.txt &
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
    "./result_4chains/node149_0_0.txt 90"
    "./result_4chains/node149_0_2.txt 90"
    "./result_4chains/node149_1_0.txt 89"
    "./result_4chains/node149_1_2.txt 89"
    "./result_4chains/node149_2_0.txt 88"
    "./result_4chains/node149_2_2.txt 88"
    "./result_4chains/node149_3_0.txt 87"
    "./result_4chains/node149_3_2.txt 87"
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
