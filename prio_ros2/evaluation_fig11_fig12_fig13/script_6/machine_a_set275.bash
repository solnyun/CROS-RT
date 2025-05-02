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
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_2 -p 301 -st topic275_0_1 -pt None -u 0.019949709315441322 > ./result_6chains/node275_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_2 -p 334 -st topic275_1_1 -pt None -u 0.028403736589597772 > ./result_6chains/node275_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_2 -p 408 -st topic275_2_1 -pt None -u 0.017699002670123476 > ./result_6chains/node275_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_2 -p 524 -st topic275_3_1 -pt None -u 0.03076081544525866 > ./result_6chains/node275_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_2 -p 539 -st topic275_4_1 -pt None -u 0.06856686340528548 > ./result_6chains/node275_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_2 -p 861 -st topic275_5_1 -pt None -u 0.0016104876898094254 > ./result_6chains/node275_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_0 -p 301 -st none -pt topic275_0_0 -u 0.003909301916517172 > ./result_6chains/node275_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_0 -p 334 -st none -pt topic275_1_0 -u 0.031446682052229 > ./result_6chains/node275_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_0 -p 408 -st none -pt topic275_2_0 -u 0.11958880530449029 > ./result_6chains/node275_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_0 -p 524 -st none -pt topic275_3_0 -u 0.0019949231318120153 > ./result_6chains/node275_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_0 -p 539 -st none -pt topic275_4_0 -u 0.015372356149958938 > ./result_6chains/node275_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_0 -p 861 -st none -pt topic275_5_0 -u 0.041187574518747196 > ./result_6chains/node275_5_0.txt &
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
    "./result_6chains/node275_0_0.txt 90"
    "./result_6chains/node275_0_2.txt 90"
    "./result_6chains/node275_1_0.txt 89"
    "./result_6chains/node275_1_2.txt 89"
    "./result_6chains/node275_2_0.txt 88"
    "./result_6chains/node275_2_2.txt 88"
    "./result_6chains/node275_3_0.txt 87"
    "./result_6chains/node275_3_2.txt 87"
    "./result_6chains/node275_4_0.txt 86"
    "./result_6chains/node275_4_2.txt 86"
    "./result_6chains/node275_5_0.txt 85"
    "./result_6chains/node275_5_2.txt 85"
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
