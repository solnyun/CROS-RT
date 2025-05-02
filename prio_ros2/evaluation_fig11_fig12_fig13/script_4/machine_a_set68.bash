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
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_2 -p 152 -st topic68_0_1 -pt None -u 0.11049427427352598 > ./result_4chains/node68_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_2 -p 171 -st topic68_1_1 -pt None -u 0.051102873940821275 > ./result_4chains/node68_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_2 -p 296 -st topic68_2_1 -pt None -u 0.0010937665649542322 > ./result_4chains/node68_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_2 -p 746 -st topic68_3_1 -pt None -u 0.06895121590019103 > ./result_4chains/node68_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_0 -p 152 -st none -pt topic68_0_0 -u 0.022732594226298475 > ./result_4chains/node68_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_0 -p 171 -st none -pt topic68_1_0 -u 0.025435436821776458 > ./result_4chains/node68_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_0 -p 296 -st none -pt topic68_2_0 -u 0.12348056410635572 > ./result_4chains/node68_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_0 -p 746 -st none -pt topic68_3_0 -u 0.036333539766284215 > ./result_4chains/node68_3_0.txt &
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
    "./result_4chains/node68_0_0.txt 90"
    "./result_4chains/node68_0_2.txt 90"
    "./result_4chains/node68_1_0.txt 89"
    "./result_4chains/node68_1_2.txt 89"
    "./result_4chains/node68_2_0.txt 88"
    "./result_4chains/node68_2_2.txt 88"
    "./result_4chains/node68_3_0.txt 87"
    "./result_4chains/node68_3_2.txt 87"
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
