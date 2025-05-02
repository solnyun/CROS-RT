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
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_2 -p 132 -st topic472_0_1 -pt None -u 0.043252104340073205 > ./result_6chains/node472_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_2 -p 247 -st topic472_1_1 -pt None -u 0.0013531723340695634 > ./result_6chains/node472_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_2 -p 336 -st topic472_2_1 -pt None -u 0.052089466832596076 > ./result_6chains/node472_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_2 -p 391 -st topic472_3_1 -pt None -u 0.00037703814793632606 > ./result_6chains/node472_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_2 -p 456 -st topic472_4_1 -pt None -u 0.03936640828838098 > ./result_6chains/node472_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_2 -p 751 -st topic472_5_1 -pt None -u 0.010820542673509011 > ./result_6chains/node472_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_0_0 -p 132 -st none -pt topic472_0_0 -u 0.006951400056871504 > ./result_6chains/node472_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_1_0 -p 247 -st none -pt topic472_1_0 -u 0.023606896902955088 > ./result_6chains/node472_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_2_0 -p 336 -st none -pt topic472_2_0 -u 0.052183617930639414 > ./result_6chains/node472_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_3_0 -p 391 -st none -pt topic472_3_0 -u 0.0013867419521354785 > ./result_6chains/node472_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node472_4_0 -p 456 -st none -pt topic472_4_0 -u 0.00542913479429219 > ./result_6chains/node472_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node472_5_0 -p 751 -st none -pt topic472_5_0 -u 0.052567578509697 > ./result_6chains/node472_5_0.txt &
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
    "./result_6chains/node472_0_0.txt 90"
    "./result_6chains/node472_0_2.txt 90"
    "./result_6chains/node472_1_0.txt 89"
    "./result_6chains/node472_1_2.txt 89"
    "./result_6chains/node472_2_0.txt 88"
    "./result_6chains/node472_2_2.txt 88"
    "./result_6chains/node472_3_0.txt 87"
    "./result_6chains/node472_3_2.txt 87"
    "./result_6chains/node472_4_0.txt 86"
    "./result_6chains/node472_4_2.txt 86"
    "./result_6chains/node472_5_0.txt 85"
    "./result_6chains/node472_5_2.txt 85"
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
