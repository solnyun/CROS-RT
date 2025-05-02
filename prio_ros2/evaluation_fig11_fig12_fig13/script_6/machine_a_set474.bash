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
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_2 -p 148 -st topic474_0_1 -pt None -u 0.007484355839981249 > ./result_6chains/node474_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_2 -p 232 -st topic474_1_1 -pt None -u 0.009320744325604535 > ./result_6chains/node474_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_2 -p 421 -st topic474_2_1 -pt None -u 0.0018861053890953938 > ./result_6chains/node474_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_2 -p 437 -st topic474_3_1 -pt None -u 0.02484226444400134 > ./result_6chains/node474_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_2 -p 748 -st topic474_4_1 -pt None -u 0.04676274406288433 > ./result_6chains/node474_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_2 -p 954 -st topic474_5_1 -pt None -u 0.022744362198834633 > ./result_6chains/node474_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_0 -p 148 -st none -pt topic474_0_0 -u 0.019607627107225023 > ./result_6chains/node474_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_0 -p 232 -st none -pt topic474_1_0 -u 0.013603047056183704 > ./result_6chains/node474_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_0 -p 421 -st none -pt topic474_2_0 -u 0.032120481053027006 > ./result_6chains/node474_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_0 -p 437 -st none -pt topic474_3_0 -u 0.0007247952989422601 > ./result_6chains/node474_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_0 -p 748 -st none -pt topic474_4_0 -u 0.003590085330632875 > ./result_6chains/node474_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_0 -p 954 -st none -pt topic474_5_0 -u 0.013727906618164074 > ./result_6chains/node474_5_0.txt &
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
    "./result_6chains/node474_0_0.txt 90"
    "./result_6chains/node474_0_2.txt 90"
    "./result_6chains/node474_1_0.txt 89"
    "./result_6chains/node474_1_2.txt 89"
    "./result_6chains/node474_2_0.txt 88"
    "./result_6chains/node474_2_2.txt 88"
    "./result_6chains/node474_3_0.txt 87"
    "./result_6chains/node474_3_2.txt 87"
    "./result_6chains/node474_4_0.txt 86"
    "./result_6chains/node474_4_2.txt 86"
    "./result_6chains/node474_5_0.txt 85"
    "./result_6chains/node474_5_2.txt 85"
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
