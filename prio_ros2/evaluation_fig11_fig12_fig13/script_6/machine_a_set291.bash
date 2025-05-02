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
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_2 -p 136 -st topic291_0_1 -pt None -u 0.021646127345514854 > ./result_6chains/node291_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_2 -p 184 -st topic291_1_1 -pt None -u 0.01354903678194369 > ./result_6chains/node291_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_2 -p 198 -st topic291_2_1 -pt None -u 0.012282566774969222 > ./result_6chains/node291_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_2 -p 208 -st topic291_3_1 -pt None -u 0.020967145932886427 > ./result_6chains/node291_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_2 -p 717 -st topic291_4_1 -pt None -u 0.04409262188858782 > ./result_6chains/node291_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_2 -p 820 -st topic291_5_1 -pt None -u 0.003510916215948827 > ./result_6chains/node291_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_0 -p 136 -st none -pt topic291_0_0 -u 0.017675225854874577 > ./result_6chains/node291_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_0 -p 184 -st none -pt topic291_1_0 -u 0.09000935123827736 > ./result_6chains/node291_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_0 -p 198 -st none -pt topic291_2_0 -u 0.020830184089156323 > ./result_6chains/node291_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_0 -p 208 -st none -pt topic291_3_0 -u 0.02518502044916393 > ./result_6chains/node291_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_0 -p 717 -st none -pt topic291_4_0 -u 0.028219356462980974 > ./result_6chains/node291_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_0 -p 820 -st none -pt topic291_5_0 -u 0.014246872417898356 > ./result_6chains/node291_5_0.txt &
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
    "./result_6chains/node291_0_0.txt 90"
    "./result_6chains/node291_0_2.txt 90"
    "./result_6chains/node291_1_0.txt 89"
    "./result_6chains/node291_1_2.txt 89"
    "./result_6chains/node291_2_0.txt 88"
    "./result_6chains/node291_2_2.txt 88"
    "./result_6chains/node291_3_0.txt 87"
    "./result_6chains/node291_3_2.txt 87"
    "./result_6chains/node291_4_0.txt 86"
    "./result_6chains/node291_4_2.txt 86"
    "./result_6chains/node291_5_0.txt 85"
    "./result_6chains/node291_5_2.txt 85"
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
