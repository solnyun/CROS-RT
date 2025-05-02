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
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_2 -p 113 -st topic0_0_1 -pt None -u 0.002880064013775774 > ./result_6chains/node0_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_2 -p 250 -st topic0_1_1 -pt None -u 0.04178068975193047 > ./result_6chains/node0_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_2 -p 492 -st topic0_2_1 -pt None -u 0.001500269229883 > ./result_6chains/node0_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_2 -p 535 -st topic0_3_1 -pt None -u 0.02259001968279914 > ./result_6chains/node0_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_2 -p 794 -st topic0_4_1 -pt None -u 0.05504755223087302 > ./result_6chains/node0_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_2 -p 900 -st topic0_5_1 -pt None -u 0.035137216762761866 > ./result_6chains/node0_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_0 -p 113 -st none -pt topic0_0_0 -u 0.07999121988354779 > ./result_6chains/node0_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_0 -p 250 -st none -pt topic0_1_0 -u 0.10213267842266521 > ./result_6chains/node0_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_0 -p 492 -st none -pt topic0_2_0 -u 0.053751493035355064 > ./result_6chains/node0_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_0 -p 535 -st none -pt topic0_3_0 -u 0.024302972538027046 > ./result_6chains/node0_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_0 -p 794 -st none -pt topic0_4_0 -u 0.0059375388669577756 > ./result_6chains/node0_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_0 -p 900 -st none -pt topic0_5_0 -u 0.0004801032337407099 > ./result_6chains/node0_5_0.txt &
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
    "./result_6chains/node0_0_0.txt 90"
    "./result_6chains/node0_0_2.txt 90"
    "./result_6chains/node0_1_0.txt 89"
    "./result_6chains/node0_1_2.txt 89"
    "./result_6chains/node0_2_0.txt 88"
    "./result_6chains/node0_2_2.txt 88"
    "./result_6chains/node0_3_0.txt 87"
    "./result_6chains/node0_3_2.txt 87"
    "./result_6chains/node0_4_0.txt 86"
    "./result_6chains/node0_4_2.txt 86"
    "./result_6chains/node0_5_0.txt 85"
    "./result_6chains/node0_5_2.txt 85"
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
