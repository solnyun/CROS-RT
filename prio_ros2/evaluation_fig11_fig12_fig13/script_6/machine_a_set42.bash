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
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_2 -p 46 -st topic42_0_1 -pt None -u 0.008425466411865423 > ./result_6chains/node42_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_2 -p 137 -st topic42_1_1 -pt None -u 0.0016765923241596203 > ./result_6chains/node42_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_2 -p 300 -st topic42_2_1 -pt None -u 0.05018062392329181 > ./result_6chains/node42_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_2 -p 562 -st topic42_3_1 -pt None -u 0.058741785300850446 > ./result_6chains/node42_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_2 -p 808 -st topic42_4_1 -pt None -u 0.020043267375290566 > ./result_6chains/node42_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_2 -p 924 -st topic42_5_1 -pt None -u 0.08572007165932864 > ./result_6chains/node42_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_0_0 -p 46 -st none -pt topic42_0_0 -u 0.01680410335813276 > ./result_6chains/node42_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_1_0 -p 137 -st none -pt topic42_1_0 -u 0.013704236749865428 > ./result_6chains/node42_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_2_0 -p 300 -st none -pt topic42_2_0 -u 0.009637634725480737 > ./result_6chains/node42_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_3_0 -p 562 -st none -pt topic42_3_0 -u 0.03439993260782498 > ./result_6chains/node42_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node42_4_0 -p 808 -st none -pt topic42_4_0 -u 0.012462052233266907 > ./result_6chains/node42_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node42_5_0 -p 924 -st none -pt topic42_5_0 -u 0.007015517261571708 > ./result_6chains/node42_5_0.txt &
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
    "./result_6chains/node42_0_0.txt 90"
    "./result_6chains/node42_0_2.txt 90"
    "./result_6chains/node42_1_0.txt 89"
    "./result_6chains/node42_1_2.txt 89"
    "./result_6chains/node42_2_0.txt 88"
    "./result_6chains/node42_2_2.txt 88"
    "./result_6chains/node42_3_0.txt 87"
    "./result_6chains/node42_3_2.txt 87"
    "./result_6chains/node42_4_0.txt 86"
    "./result_6chains/node42_4_2.txt 86"
    "./result_6chains/node42_5_0.txt 85"
    "./result_6chains/node42_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
