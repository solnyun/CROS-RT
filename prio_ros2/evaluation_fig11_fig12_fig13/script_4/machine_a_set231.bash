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
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_2 -p 547 -st topic231_0_1 -pt None -u 0.13191937159522144 > ./result_4chains/node231_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_2 -p 670 -st topic231_1_1 -pt None -u 0.03138304108821566 > ./result_4chains/node231_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_2 -p 728 -st topic231_2_1 -pt None -u 0.03118330300174868 > ./result_4chains/node231_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_2 -p 956 -st topic231_3_1 -pt None -u 0.03160319202696134 > ./result_4chains/node231_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_0_0 -p 547 -st none -pt topic231_0_0 -u 0.10635562829974243 > ./result_4chains/node231_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_1_0 -p 670 -st none -pt topic231_1_0 -u 0.05060423320337995 > ./result_4chains/node231_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node231_2_0 -p 728 -st none -pt topic231_2_0 -u 0.035105884695966816 > ./result_4chains/node231_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node231_3_0 -p 956 -st none -pt topic231_3_0 -u 0.00022592489904706137 > ./result_4chains/node231_3_0.txt &
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
    "./result_4chains/node231_0_0.txt 90"
    "./result_4chains/node231_0_2.txt 90"
    "./result_4chains/node231_1_0.txt 89"
    "./result_4chains/node231_1_2.txt 89"
    "./result_4chains/node231_2_0.txt 88"
    "./result_4chains/node231_2_2.txt 88"
    "./result_4chains/node231_3_0.txt 87"
    "./result_4chains/node231_3_2.txt 87"
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
