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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_2 -p 88 -st topic412_0_1 -pt None -u 0.012680706594527413 > ./result_6chains/node412_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_2 -p 98 -st topic412_1_1 -pt None -u 0.046584093298278395 > ./result_6chains/node412_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_2 -p 247 -st topic412_2_1 -pt None -u 0.04201664430330951 > ./result_6chains/node412_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_2 -p 311 -st topic412_3_1 -pt None -u 0.0021731856933230043 > ./result_6chains/node412_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_2 -p 538 -st topic412_4_1 -pt None -u 0.009924612118017914 > ./result_6chains/node412_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_2 -p 833 -st topic412_5_1 -pt None -u 0.012135972445446322 > ./result_6chains/node412_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_0 -p 88 -st none -pt topic412_0_0 -u 0.015626760148256147 > ./result_6chains/node412_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_0 -p 98 -st none -pt topic412_1_0 -u 0.05120121963107649 > ./result_6chains/node412_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_0 -p 247 -st none -pt topic412_2_0 -u 0.061694068704453126 > ./result_6chains/node412_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_0 -p 311 -st none -pt topic412_3_0 -u 0.028625475380044105 > ./result_6chains/node412_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_0 -p 538 -st none -pt topic412_4_0 -u 0.01399244348433945 > ./result_6chains/node412_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_0 -p 833 -st none -pt topic412_5_0 -u 0.011489791046218535 > ./result_6chains/node412_5_0.txt &
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
    "./result_6chains/node412_0_0.txt 90"
    "./result_6chains/node412_0_2.txt 90"
    "./result_6chains/node412_1_0.txt 89"
    "./result_6chains/node412_1_2.txt 89"
    "./result_6chains/node412_2_0.txt 88"
    "./result_6chains/node412_2_2.txt 88"
    "./result_6chains/node412_3_0.txt 87"
    "./result_6chains/node412_3_2.txt 87"
    "./result_6chains/node412_4_0.txt 86"
    "./result_6chains/node412_4_2.txt 86"
    "./result_6chains/node412_5_0.txt 85"
    "./result_6chains/node412_5_2.txt 85"
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
