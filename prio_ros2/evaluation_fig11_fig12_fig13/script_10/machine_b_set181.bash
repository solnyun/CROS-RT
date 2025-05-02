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
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_1 -p 26 -st topic181_0_0 -pt topic181_0_1 -u 0.016331933402925602 > ./result_10chains/node181_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_1 -p 226 -st topic181_1_0 -pt topic181_1_1 -u 0.02878488328048595 > ./result_10chains/node181_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_1 -p 280 -st topic181_2_0 -pt topic181_2_1 -u 0.015653236731398013 > ./result_10chains/node181_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_1 -p 393 -st topic181_3_0 -pt topic181_3_1 -u 0.008432530396802584 > ./result_10chains/node181_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_1 -p 436 -st topic181_4_0 -pt topic181_4_1 -u 0.009845368903222407 > ./result_10chains/node181_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_1 -p 704 -st topic181_5_0 -pt topic181_5_1 -u 0.0013639551333235467 > ./result_10chains/node181_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_6_1 -p 733 -st topic181_6_0 -pt topic181_6_1 -u 0.0239941069773964 > ./result_10chains/node181_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_7_1 -p 861 -st topic181_7_0 -pt topic181_7_1 -u 0.011223673238483084 > ./result_10chains/node181_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_8_1 -p 871 -st topic181_8_0 -pt topic181_8_1 -u 0.01640201365745937 > ./result_10chains/node181_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_9_1 -p 998 -st topic181_9_0 -pt topic181_9_1 -u 0.001444147230217678 > ./result_10chains/node181_9_1.txt &
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
    "./result_10chains/node181_0_1.txt 90"
    "./result_10chains/node181_1_1.txt 89"
    "./result_10chains/node181_2_1.txt 88"
    "./result_10chains/node181_3_1.txt 87"
    "./result_10chains/node181_4_1.txt 86"
    "./result_10chains/node181_5_1.txt 85"
    "./result_10chains/node181_6_1.txt 84"
    "./result_10chains/node181_7_1.txt 83"
    "./result_10chains/node181_8_1.txt 82"
    "./result_10chains/node181_9_1.txt 81"
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
