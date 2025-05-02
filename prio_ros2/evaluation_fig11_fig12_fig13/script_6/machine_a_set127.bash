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
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_2 -p 57 -st topic127_0_1 -pt None -u 0.009588846187756128 > ./result_6chains/node127_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_2 -p 68 -st topic127_1_1 -pt None -u 0.02611304447497742 > ./result_6chains/node127_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_2 -p 239 -st topic127_2_1 -pt None -u 0.02672296729367027 > ./result_6chains/node127_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_2 -p 248 -st topic127_3_1 -pt None -u 0.05277391557238148 > ./result_6chains/node127_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_2 -p 537 -st topic127_4_1 -pt None -u 0.027565886154836114 > ./result_6chains/node127_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_2 -p 983 -st topic127_5_1 -pt None -u 0.027396746063793557 > ./result_6chains/node127_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_0 -p 57 -st none -pt topic127_0_0 -u 0.0008305230539749631 > ./result_6chains/node127_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_0 -p 68 -st none -pt topic127_1_0 -u 0.020762496816895515 > ./result_6chains/node127_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_0 -p 239 -st none -pt topic127_2_0 -u 0.1035138460693042 > ./result_6chains/node127_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_0 -p 248 -st none -pt topic127_3_0 -u 0.03977376635957197 > ./result_6chains/node127_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_0 -p 537 -st none -pt topic127_4_0 -u 0.01902565578347068 > ./result_6chains/node127_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_0 -p 983 -st none -pt topic127_5_0 -u 0.002736917053782255 > ./result_6chains/node127_5_0.txt &
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
    "./result_6chains/node127_0_0.txt 90"
    "./result_6chains/node127_0_2.txt 90"
    "./result_6chains/node127_1_0.txt 89"
    "./result_6chains/node127_1_2.txt 89"
    "./result_6chains/node127_2_0.txt 88"
    "./result_6chains/node127_2_2.txt 88"
    "./result_6chains/node127_3_0.txt 87"
    "./result_6chains/node127_3_2.txt 87"
    "./result_6chains/node127_4_0.txt 86"
    "./result_6chains/node127_4_2.txt 86"
    "./result_6chains/node127_5_0.txt 85"
    "./result_6chains/node127_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
