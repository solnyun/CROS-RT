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
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_2 -p 16 -st topic111_0_1 -pt None -u 0.029021247132145767 > ./result_6chains/node111_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_2 -p 245 -st topic111_1_1 -pt None -u 0.0033441304967969376 > ./result_6chains/node111_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_2 -p 491 -st topic111_2_1 -pt None -u 0.03179869284069703 > ./result_6chains/node111_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_2 -p 507 -st topic111_3_1 -pt None -u 0.016080955180251766 > ./result_6chains/node111_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_2 -p 734 -st topic111_4_1 -pt None -u 0.19891031132899817 > ./result_6chains/node111_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_2 -p 943 -st topic111_5_1 -pt None -u 0.020551792038451717 > ./result_6chains/node111_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_0 -p 16 -st none -pt topic111_0_0 -u 0.003974390796878446 > ./result_6chains/node111_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_0 -p 245 -st none -pt topic111_1_0 -u 0.0616322241847575 > ./result_6chains/node111_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_0 -p 491 -st none -pt topic111_2_0 -u 0.0035669257785452824 > ./result_6chains/node111_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_0 -p 507 -st none -pt topic111_3_0 -u 0.03862688913232565 > ./result_6chains/node111_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_0 -p 734 -st none -pt topic111_4_0 -u 0.007881820944775908 > ./result_6chains/node111_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_0 -p 943 -st none -pt topic111_5_0 -u 0.0030868021722647715 > ./result_6chains/node111_5_0.txt &
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
    "./result_6chains/node111_0_0.txt 90"
    "./result_6chains/node111_0_2.txt 90"
    "./result_6chains/node111_1_0.txt 89"
    "./result_6chains/node111_1_2.txt 89"
    "./result_6chains/node111_2_0.txt 88"
    "./result_6chains/node111_2_2.txt 88"
    "./result_6chains/node111_3_0.txt 87"
    "./result_6chains/node111_3_2.txt 87"
    "./result_6chains/node111_4_0.txt 86"
    "./result_6chains/node111_4_2.txt 86"
    "./result_6chains/node111_5_0.txt 85"
    "./result_6chains/node111_5_2.txt 85"
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
