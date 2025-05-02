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
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_2 -p 119 -st topic430_0_1 -pt None -u 0.0394131118162423 > ./result_4chains/node430_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_2 -p 666 -st topic430_1_1 -pt None -u 0.051710149895302704 > ./result_4chains/node430_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_2 -p 860 -st topic430_2_1 -pt None -u 0.08235875803205706 > ./result_4chains/node430_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_2 -p 878 -st topic430_3_1 -pt None -u 0.06454936395207946 > ./result_4chains/node430_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_0_0 -p 119 -st none -pt topic430_0_0 -u 0.012116806869444607 > ./result_4chains/node430_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_1_0 -p 666 -st none -pt topic430_1_0 -u 0.04516696802109332 > ./result_4chains/node430_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node430_2_0 -p 860 -st none -pt topic430_2_0 -u 0.03737714888348248 > ./result_4chains/node430_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node430_3_0 -p 878 -st none -pt topic430_3_0 -u 0.026036946770161745 > ./result_4chains/node430_3_0.txt &
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
    "./result_4chains/node430_0_0.txt 90"
    "./result_4chains/node430_0_2.txt 90"
    "./result_4chains/node430_1_0.txt 89"
    "./result_4chains/node430_1_2.txt 89"
    "./result_4chains/node430_2_0.txt 88"
    "./result_4chains/node430_2_2.txt 88"
    "./result_4chains/node430_3_0.txt 87"
    "./result_4chains/node430_3_2.txt 87"
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
