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
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_2 -p 93 -st topic455_0_1 -pt None -u 0.027678870487497453 > ./result_6chains/node455_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_2 -p 169 -st topic455_1_1 -pt None -u 0.04700566543065621 > ./result_6chains/node455_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_2 -p 215 -st topic455_2_1 -pt None -u 0.012484277805233257 > ./result_6chains/node455_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_2 -p 237 -st topic455_3_1 -pt None -u 0.08184282048575847 > ./result_6chains/node455_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_2 -p 309 -st topic455_4_1 -pt None -u 0.026407709902125095 > ./result_6chains/node455_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_2 -p 997 -st topic455_5_1 -pt None -u 0.022314849424827195 > ./result_6chains/node455_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_0 -p 93 -st none -pt topic455_0_0 -u 0.058213065697933664 > ./result_6chains/node455_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_0 -p 169 -st none -pt topic455_1_0 -u 0.01587204670456449 > ./result_6chains/node455_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_0 -p 215 -st none -pt topic455_2_0 -u 0.0014071322441135958 > ./result_6chains/node455_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_0 -p 237 -st none -pt topic455_3_0 -u 0.02575777455653286 > ./result_6chains/node455_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_0 -p 309 -st none -pt topic455_4_0 -u 0.01201302344939853 > ./result_6chains/node455_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_0 -p 997 -st none -pt topic455_5_0 -u 0.0020041317075154413 > ./result_6chains/node455_5_0.txt &
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
    "./result_6chains/node455_0_0.txt 90"
    "./result_6chains/node455_0_2.txt 90"
    "./result_6chains/node455_1_0.txt 89"
    "./result_6chains/node455_1_2.txt 89"
    "./result_6chains/node455_2_0.txt 88"
    "./result_6chains/node455_2_2.txt 88"
    "./result_6chains/node455_3_0.txt 87"
    "./result_6chains/node455_3_2.txt 87"
    "./result_6chains/node455_4_0.txt 86"
    "./result_6chains/node455_4_2.txt 86"
    "./result_6chains/node455_5_0.txt 85"
    "./result_6chains/node455_5_2.txt 85"
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
