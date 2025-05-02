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
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_2 -p 418 -st topic291_0_1 -pt None -u 0.018894820825605896 > ./result_4chains/node291_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_2 -p 460 -st topic291_1_1 -pt None -u 0.053685429390018635 > ./result_4chains/node291_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_2 -p 665 -st topic291_2_1 -pt None -u 0.054772502166173326 > ./result_4chains/node291_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_2 -p 799 -st topic291_3_1 -pt None -u 0.03716377692885007 > ./result_4chains/node291_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_0 -p 418 -st none -pt topic291_0_0 -u 0.0100723398475705 > ./result_4chains/node291_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_0 -p 460 -st none -pt topic291_1_0 -u 0.002795534165578928 > ./result_4chains/node291_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_0 -p 665 -st none -pt topic291_2_0 -u 0.11573037526206795 > ./result_4chains/node291_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_0 -p 799 -st none -pt topic291_3_0 -u 0.001399687463869717 > ./result_4chains/node291_3_0.txt &
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
    "./result_4chains/node291_0_0.txt 90"
    "./result_4chains/node291_0_2.txt 90"
    "./result_4chains/node291_1_0.txt 89"
    "./result_4chains/node291_1_2.txt 89"
    "./result_4chains/node291_2_0.txt 88"
    "./result_4chains/node291_2_2.txt 88"
    "./result_4chains/node291_3_0.txt 87"
    "./result_4chains/node291_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
