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
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_1 -p 83 -st topic99_0_0 -pt topic99_0_1 -u 0.003020135391806622 > ./result_10chains/node99_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_1 -p 353 -st topic99_1_0 -pt topic99_1_1 -u 0.01928431068685954 > ./result_10chains/node99_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_1 -p 499 -st topic99_2_0 -pt topic99_2_1 -u 0.0018765352002593771 > ./result_10chains/node99_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_1 -p 551 -st topic99_3_0 -pt topic99_3_1 -u 0.0023107425516580293 > ./result_10chains/node99_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_1 -p 570 -st topic99_4_0 -pt topic99_4_1 -u 0.0018759269167821224 > ./result_10chains/node99_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_1 -p 751 -st topic99_5_0 -pt topic99_5_1 -u 0.016329432716409686 > ./result_10chains/node99_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_6_1 -p 779 -st topic99_6_0 -pt topic99_6_1 -u 0.006424320085354346 > ./result_10chains/node99_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_7_1 -p 851 -st topic99_7_0 -pt topic99_7_1 -u 0.02216773092888713 > ./result_10chains/node99_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_8_1 -p 953 -st topic99_8_0 -pt topic99_8_1 -u 0.025218398248623514 > ./result_10chains/node99_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_9_1 -p 979 -st topic99_9_0 -pt topic99_9_1 -u 0.007752834629080892 > ./result_10chains/node99_9_1.txt &
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
    "./result_10chains/node99_0_1.txt 90"
    "./result_10chains/node99_1_1.txt 89"
    "./result_10chains/node99_2_1.txt 88"
    "./result_10chains/node99_3_1.txt 87"
    "./result_10chains/node99_4_1.txt 86"
    "./result_10chains/node99_5_1.txt 85"
    "./result_10chains/node99_6_1.txt 84"
    "./result_10chains/node99_7_1.txt 83"
    "./result_10chains/node99_8_1.txt 82"
    "./result_10chains/node99_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
