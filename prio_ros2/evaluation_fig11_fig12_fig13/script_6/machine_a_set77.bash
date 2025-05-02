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
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_2 -p 80 -st topic77_0_1 -pt None -u 0.0035634559454994497 > ./result_6chains/node77_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_2 -p 256 -st topic77_1_1 -pt None -u 0.00037633746576565263 > ./result_6chains/node77_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_2 -p 423 -st topic77_2_1 -pt None -u 0.013525603426517901 > ./result_6chains/node77_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_2 -p 595 -st topic77_3_1 -pt None -u 0.010031460776534412 > ./result_6chains/node77_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_2 -p 604 -st topic77_4_1 -pt None -u 0.03093983963976976 > ./result_6chains/node77_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_2 -p 645 -st topic77_5_1 -pt None -u 0.009725200290031181 > ./result_6chains/node77_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_0 -p 80 -st none -pt topic77_0_0 -u 0.02546774760187881 > ./result_6chains/node77_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_0 -p 256 -st none -pt topic77_1_0 -u 0.18422865185062237 > ./result_6chains/node77_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_0 -p 423 -st none -pt topic77_2_0 -u 0.053089342671216566 > ./result_6chains/node77_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_0 -p 595 -st none -pt topic77_3_0 -u 0.008969478642031209 > ./result_6chains/node77_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_0 -p 604 -st none -pt topic77_4_0 -u 0.0058849423078928265 > ./result_6chains/node77_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_0 -p 645 -st none -pt topic77_5_0 -u 0.04865182212648432 > ./result_6chains/node77_5_0.txt &
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
    "./result_6chains/node77_0_0.txt 90"
    "./result_6chains/node77_0_2.txt 90"
    "./result_6chains/node77_1_0.txt 89"
    "./result_6chains/node77_1_2.txt 89"
    "./result_6chains/node77_2_0.txt 88"
    "./result_6chains/node77_2_2.txt 88"
    "./result_6chains/node77_3_0.txt 87"
    "./result_6chains/node77_3_2.txt 87"
    "./result_6chains/node77_4_0.txt 86"
    "./result_6chains/node77_4_2.txt 86"
    "./result_6chains/node77_5_0.txt 85"
    "./result_6chains/node77_5_2.txt 85"
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
