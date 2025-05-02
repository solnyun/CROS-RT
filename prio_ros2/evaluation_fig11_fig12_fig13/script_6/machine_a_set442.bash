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
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_2 -p 285 -st topic442_0_1 -pt None -u 0.0320088120817002 > ./result_6chains/node442_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_2 -p 308 -st topic442_1_1 -pt None -u 0.020970230784678412 > ./result_6chains/node442_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_2 -p 327 -st topic442_2_1 -pt None -u 0.030893060885960832 > ./result_6chains/node442_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_2 -p 376 -st topic442_3_1 -pt None -u 0.05289673746601027 > ./result_6chains/node442_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_2 -p 428 -st topic442_4_1 -pt None -u 0.03727285631946231 > ./result_6chains/node442_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_2 -p 943 -st topic442_5_1 -pt None -u 0.010021240270648837 > ./result_6chains/node442_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_0 -p 285 -st none -pt topic442_0_0 -u 0.05199995514646755 > ./result_6chains/node442_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_0 -p 308 -st none -pt topic442_1_0 -u 0.11838060461215394 > ./result_6chains/node442_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_0 -p 327 -st none -pt topic442_2_0 -u 0.013292987630536407 > ./result_6chains/node442_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_0 -p 376 -st none -pt topic442_3_0 -u 0.035681851120358876 > ./result_6chains/node442_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_0 -p 428 -st none -pt topic442_4_0 -u 0.01050083178203473 > ./result_6chains/node442_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_0 -p 943 -st none -pt topic442_5_0 -u 0.00030349383949590525 > ./result_6chains/node442_5_0.txt &
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
    "./result_6chains/node442_0_0.txt 90"
    "./result_6chains/node442_0_2.txt 90"
    "./result_6chains/node442_1_0.txt 89"
    "./result_6chains/node442_1_2.txt 89"
    "./result_6chains/node442_2_0.txt 88"
    "./result_6chains/node442_2_2.txt 88"
    "./result_6chains/node442_3_0.txt 87"
    "./result_6chains/node442_3_2.txt 87"
    "./result_6chains/node442_4_0.txt 86"
    "./result_6chains/node442_4_2.txt 86"
    "./result_6chains/node442_5_0.txt 85"
    "./result_6chains/node442_5_2.txt 85"
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
