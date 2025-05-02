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
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_2 -p 177 -st topic413_0_1 -pt None -u 0.01718357879133181 > ./result_6chains/node413_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_2 -p 307 -st topic413_1_1 -pt None -u 0.014459618270076247 > ./result_6chains/node413_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_2 -p 735 -st topic413_2_1 -pt None -u 0.02538064102562554 > ./result_6chains/node413_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_2 -p 756 -st topic413_3_1 -pt None -u 0.04735084520873864 > ./result_6chains/node413_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_2 -p 838 -st topic413_4_1 -pt None -u 0.024361823224043504 > ./result_6chains/node413_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_2 -p 862 -st topic413_5_1 -pt None -u 0.03234620648203018 > ./result_6chains/node413_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_0 -p 177 -st none -pt topic413_0_0 -u 0.037831851738864275 > ./result_6chains/node413_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_0 -p 307 -st none -pt topic413_1_0 -u 0.0020190693292383433 > ./result_6chains/node413_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_0 -p 735 -st none -pt topic413_2_0 -u 0.039454693602943736 > ./result_6chains/node413_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_0 -p 756 -st none -pt topic413_3_0 -u 0.023128070981512316 > ./result_6chains/node413_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_0 -p 838 -st none -pt topic413_4_0 -u 0.001780752054440407 > ./result_6chains/node413_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_0 -p 862 -st none -pt topic413_5_0 -u 0.011296586236401007 > ./result_6chains/node413_5_0.txt &
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
    "./result_6chains/node413_0_0.txt 90"
    "./result_6chains/node413_0_2.txt 90"
    "./result_6chains/node413_1_0.txt 89"
    "./result_6chains/node413_1_2.txt 89"
    "./result_6chains/node413_2_0.txt 88"
    "./result_6chains/node413_2_2.txt 88"
    "./result_6chains/node413_3_0.txt 87"
    "./result_6chains/node413_3_2.txt 87"
    "./result_6chains/node413_4_0.txt 86"
    "./result_6chains/node413_4_2.txt 86"
    "./result_6chains/node413_5_0.txt 85"
    "./result_6chains/node413_5_2.txt 85"
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
