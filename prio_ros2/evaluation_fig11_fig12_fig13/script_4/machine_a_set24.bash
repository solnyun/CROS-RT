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
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_2 -p 346 -st topic24_0_1 -pt None -u 0.016285270807861185 > ./result_4chains/node24_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_2 -p 510 -st topic24_1_1 -pt None -u 0.015930102081217007 > ./result_4chains/node24_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_2 -p 601 -st topic24_2_1 -pt None -u 0.010822009255656212 > ./result_4chains/node24_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_2 -p 924 -st topic24_3_1 -pt None -u 0.06120056806780115 > ./result_4chains/node24_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_0 -p 346 -st none -pt topic24_0_0 -u 0.011945146309480459 > ./result_4chains/node24_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_0 -p 510 -st none -pt topic24_1_0 -u 0.13082067699574423 > ./result_4chains/node24_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_0 -p 601 -st none -pt topic24_2_0 -u 0.00809271813083165 > ./result_4chains/node24_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_0 -p 924 -st none -pt topic24_3_0 -u 0.034618651010843965 > ./result_4chains/node24_3_0.txt &
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
    "./result_4chains/node24_0_0.txt 90"
    "./result_4chains/node24_0_2.txt 90"
    "./result_4chains/node24_1_0.txt 89"
    "./result_4chains/node24_1_2.txt 89"
    "./result_4chains/node24_2_0.txt 88"
    "./result_4chains/node24_2_2.txt 88"
    "./result_4chains/node24_3_0.txt 87"
    "./result_4chains/node24_3_2.txt 87"
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
