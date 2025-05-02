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
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_2 -p 122 -st topic214_0_1 -pt None -u 0.0356408971651162 > ./result_6chains/node214_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_2 -p 362 -st topic214_1_1 -pt None -u 0.01423776927793774 > ./result_6chains/node214_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_2 -p 460 -st topic214_2_1 -pt None -u 0.032694521339927174 > ./result_6chains/node214_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_2 -p 744 -st topic214_3_1 -pt None -u 0.002540771232632022 > ./result_6chains/node214_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_2 -p 899 -st topic214_4_1 -pt None -u 0.027197503966589057 > ./result_6chains/node214_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_2 -p 941 -st topic214_5_1 -pt None -u 0.0011109433905818523 > ./result_6chains/node214_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_0 -p 122 -st none -pt topic214_0_0 -u 0.004659229238572482 > ./result_6chains/node214_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_0 -p 362 -st none -pt topic214_1_0 -u 0.016148710435213265 > ./result_6chains/node214_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_0 -p 460 -st none -pt topic214_2_0 -u 0.007112953262345789 > ./result_6chains/node214_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_0 -p 744 -st none -pt topic214_3_0 -u 0.05129830164864191 > ./result_6chains/node214_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_0 -p 899 -st none -pt topic214_4_0 -u 0.06721408291054097 > ./result_6chains/node214_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_0 -p 941 -st none -pt topic214_5_0 -u 0.014354077404430465 > ./result_6chains/node214_5_0.txt &
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
    "./result_6chains/node214_0_0.txt 90"
    "./result_6chains/node214_0_2.txt 90"
    "./result_6chains/node214_1_0.txt 89"
    "./result_6chains/node214_1_2.txt 89"
    "./result_6chains/node214_2_0.txt 88"
    "./result_6chains/node214_2_2.txt 88"
    "./result_6chains/node214_3_0.txt 87"
    "./result_6chains/node214_3_2.txt 87"
    "./result_6chains/node214_4_0.txt 86"
    "./result_6chains/node214_4_2.txt 86"
    "./result_6chains/node214_5_0.txt 85"
    "./result_6chains/node214_5_2.txt 85"
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
