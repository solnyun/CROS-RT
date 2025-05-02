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
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_2 -p 23 -st topic145_0_1 -pt None -u 0.008035483403521115 > ./result_6chains/node145_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_2 -p 53 -st topic145_1_1 -pt None -u 0.10411601726594638 > ./result_6chains/node145_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_2 -p 153 -st topic145_2_1 -pt None -u 0.011864209072043552 > ./result_6chains/node145_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_2 -p 371 -st topic145_3_1 -pt None -u 0.016150076682065972 > ./result_6chains/node145_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_2 -p 374 -st topic145_4_1 -pt None -u 0.05536627512357858 > ./result_6chains/node145_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_2 -p 421 -st topic145_5_1 -pt None -u 0.013128006022910563 > ./result_6chains/node145_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_0 -p 23 -st none -pt topic145_0_0 -u 0.008017772438652038 > ./result_6chains/node145_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_0 -p 53 -st none -pt topic145_1_0 -u 0.07431122751401775 > ./result_6chains/node145_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_0 -p 153 -st none -pt topic145_2_0 -u 0.043111968332738615 > ./result_6chains/node145_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_0 -p 371 -st none -pt topic145_3_0 -u 0.044411210643937105 > ./result_6chains/node145_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_0 -p 374 -st none -pt topic145_4_0 -u 0.005707036475124452 > ./result_6chains/node145_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_0 -p 421 -st none -pt topic145_5_0 -u 0.011428760141778897 > ./result_6chains/node145_5_0.txt &
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
    "./result_6chains/node145_0_0.txt 90"
    "./result_6chains/node145_0_2.txt 90"
    "./result_6chains/node145_1_0.txt 89"
    "./result_6chains/node145_1_2.txt 89"
    "./result_6chains/node145_2_0.txt 88"
    "./result_6chains/node145_2_2.txt 88"
    "./result_6chains/node145_3_0.txt 87"
    "./result_6chains/node145_3_2.txt 87"
    "./result_6chains/node145_4_0.txt 86"
    "./result_6chains/node145_4_2.txt 86"
    "./result_6chains/node145_5_0.txt 85"
    "./result_6chains/node145_5_2.txt 85"
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
