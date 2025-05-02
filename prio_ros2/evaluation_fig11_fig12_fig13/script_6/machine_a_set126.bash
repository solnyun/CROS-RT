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
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_2 -p 201 -st topic126_0_1 -pt None -u 0.013233920965969537 > ./result_6chains/node126_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_2 -p 420 -st topic126_1_1 -pt None -u 0.060081847087333606 > ./result_6chains/node126_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_2 -p 521 -st topic126_2_1 -pt None -u 0.006088920999836683 > ./result_6chains/node126_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_2 -p 583 -st topic126_3_1 -pt None -u 0.014722335258286534 > ./result_6chains/node126_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_2 -p 611 -st topic126_4_1 -pt None -u 0.015691432038902733 > ./result_6chains/node126_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_2 -p 640 -st topic126_5_1 -pt None -u 0.005277945859819454 > ./result_6chains/node126_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_0 -p 201 -st none -pt topic126_0_0 -u 0.02166133606421422 > ./result_6chains/node126_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_0 -p 420 -st none -pt topic126_1_0 -u 0.011097967943188458 > ./result_6chains/node126_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_0 -p 521 -st none -pt topic126_2_0 -u 0.029197309905424462 > ./result_6chains/node126_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_0 -p 583 -st none -pt topic126_3_0 -u 0.002512711811416962 > ./result_6chains/node126_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_0 -p 611 -st none -pt topic126_4_0 -u 0.05616269458556576 > ./result_6chains/node126_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_0 -p 640 -st none -pt topic126_5_0 -u 0.0055856162005591264 > ./result_6chains/node126_5_0.txt &
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
    "./result_6chains/node126_0_0.txt 90"
    "./result_6chains/node126_0_2.txt 90"
    "./result_6chains/node126_1_0.txt 89"
    "./result_6chains/node126_1_2.txt 89"
    "./result_6chains/node126_2_0.txt 88"
    "./result_6chains/node126_2_2.txt 88"
    "./result_6chains/node126_3_0.txt 87"
    "./result_6chains/node126_3_2.txt 87"
    "./result_6chains/node126_4_0.txt 86"
    "./result_6chains/node126_4_2.txt 86"
    "./result_6chains/node126_5_0.txt 85"
    "./result_6chains/node126_5_2.txt 85"
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
