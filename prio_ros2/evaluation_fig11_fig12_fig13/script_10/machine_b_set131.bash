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
ros2 run evaluation_3_randomdag uunifast_node -n node131_0_1 -p 87 -st topic131_0_0 -pt topic131_0_1 -u 0.016917949938301258 > ./result_10chains/node131_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_1_1 -p 171 -st topic131_1_0 -pt topic131_1_1 -u 0.05007031895193287 > ./result_10chains/node131_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_2_1 -p 342 -st topic131_2_0 -pt topic131_2_1 -u 0.011552139884457358 > ./result_10chains/node131_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_3_1 -p 364 -st topic131_3_0 -pt topic131_3_1 -u 0.0027504673078432296 > ./result_10chains/node131_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_4_1 -p 388 -st topic131_4_0 -pt topic131_4_1 -u 0.012179067831086188 > ./result_10chains/node131_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_5_1 -p 462 -st topic131_5_0 -pt topic131_5_1 -u 0.03230652933580422 > ./result_10chains/node131_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_6_1 -p 483 -st topic131_6_0 -pt topic131_6_1 -u 0.009342299991523056 > ./result_10chains/node131_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_7_1 -p 607 -st topic131_7_0 -pt topic131_7_1 -u 0.028019787368050678 > ./result_10chains/node131_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_8_1 -p 814 -st topic131_8_0 -pt topic131_8_1 -u 0.012329050682974144 > ./result_10chains/node131_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_9_1 -p 828 -st topic131_9_0 -pt topic131_9_1 -u 0.007039548458494825 > ./result_10chains/node131_9_1.txt &
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
    "./result_10chains/node131_0_1.txt 90"
    "./result_10chains/node131_1_1.txt 89"
    "./result_10chains/node131_2_1.txt 88"
    "./result_10chains/node131_3_1.txt 87"
    "./result_10chains/node131_4_1.txt 86"
    "./result_10chains/node131_5_1.txt 85"
    "./result_10chains/node131_6_1.txt 84"
    "./result_10chains/node131_7_1.txt 83"
    "./result_10chains/node131_8_1.txt 82"
    "./result_10chains/node131_9_1.txt 81"
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
