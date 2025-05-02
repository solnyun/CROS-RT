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
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_2 -p 102 -st topic451_0_1 -pt None -u 0.0024483711645678086 > ./result_6chains/node451_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_2 -p 240 -st topic451_1_1 -pt None -u 0.0487553235409956 > ./result_6chains/node451_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_2 -p 446 -st topic451_2_1 -pt None -u 0.006903801348852989 > ./result_6chains/node451_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_2 -p 627 -st topic451_3_1 -pt None -u 0.02057585209599344 > ./result_6chains/node451_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_2 -p 709 -st topic451_4_1 -pt None -u 0.020860043900997244 > ./result_6chains/node451_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_2 -p 730 -st topic451_5_1 -pt None -u 0.07178030864097208 > ./result_6chains/node451_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_0 -p 102 -st none -pt topic451_0_0 -u 0.07456594749354761 > ./result_6chains/node451_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_0 -p 240 -st none -pt topic451_1_0 -u 0.004248761099818643 > ./result_6chains/node451_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_0 -p 446 -st none -pt topic451_2_0 -u 0.013102460069549487 > ./result_6chains/node451_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_0 -p 627 -st none -pt topic451_3_0 -u 0.023841932159195556 > ./result_6chains/node451_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_0 -p 709 -st none -pt topic451_4_0 -u 0.000544389432526271 > ./result_6chains/node451_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_0 -p 730 -st none -pt topic451_5_0 -u 0.031161968645940577 > ./result_6chains/node451_5_0.txt &
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
    "./result_6chains/node451_0_0.txt 90"
    "./result_6chains/node451_0_2.txt 90"
    "./result_6chains/node451_1_0.txt 89"
    "./result_6chains/node451_1_2.txt 89"
    "./result_6chains/node451_2_0.txt 88"
    "./result_6chains/node451_2_2.txt 88"
    "./result_6chains/node451_3_0.txt 87"
    "./result_6chains/node451_3_2.txt 87"
    "./result_6chains/node451_4_0.txt 86"
    "./result_6chains/node451_4_2.txt 86"
    "./result_6chains/node451_5_0.txt 85"
    "./result_6chains/node451_5_2.txt 85"
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
