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
ros2 run evaluation_3_randomdag uunifast_node -n node443_0_2 -p 84 -st topic443_0_1 -pt None -u 0.00787380482051625 > ./result_6chains/node443_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_1_2 -p 117 -st topic443_1_1 -pt None -u 0.0014922270981244101 > ./result_6chains/node443_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_2_2 -p 149 -st topic443_2_1 -pt None -u 0.0510985933894762 > ./result_6chains/node443_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_3_2 -p 170 -st topic443_3_1 -pt None -u 0.04129970114061016 > ./result_6chains/node443_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_4_2 -p 759 -st topic443_4_1 -pt None -u 0.025532042942658803 > ./result_6chains/node443_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_5_2 -p 876 -st topic443_5_1 -pt None -u 0.012798948547632154 > ./result_6chains/node443_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_0_0 -p 84 -st none -pt topic443_0_0 -u 0.0076442592591559055 > ./result_6chains/node443_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_1_0 -p 117 -st none -pt topic443_1_0 -u 0.005973559701758613 > ./result_6chains/node443_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_2_0 -p 149 -st none -pt topic443_2_0 -u 0.06068390162110382 > ./result_6chains/node443_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_3_0 -p 170 -st none -pt topic443_3_0 -u 0.017583695389512766 > ./result_6chains/node443_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_4_0 -p 759 -st none -pt topic443_4_0 -u 0.021764791489242485 > ./result_6chains/node443_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_5_0 -p 876 -st none -pt topic443_5_0 -u 0.06817190817338295 > ./result_6chains/node443_5_0.txt &
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
    "./result_6chains/node443_0_0.txt 90"
    "./result_6chains/node443_0_2.txt 90"
    "./result_6chains/node443_1_0.txt 89"
    "./result_6chains/node443_1_2.txt 89"
    "./result_6chains/node443_2_0.txt 88"
    "./result_6chains/node443_2_2.txt 88"
    "./result_6chains/node443_3_0.txt 87"
    "./result_6chains/node443_3_2.txt 87"
    "./result_6chains/node443_4_0.txt 86"
    "./result_6chains/node443_4_2.txt 86"
    "./result_6chains/node443_5_0.txt 85"
    "./result_6chains/node443_5_2.txt 85"
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
