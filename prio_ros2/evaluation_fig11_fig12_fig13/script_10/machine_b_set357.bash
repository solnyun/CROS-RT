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
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_1 -p 55 -st topic357_0_0 -pt topic357_0_1 -u 0.0046403576891543286 > ./result_10chains/node357_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_1 -p 76 -st topic357_1_0 -pt topic357_1_1 -u 0.07098204971215505 > ./result_10chains/node357_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_1 -p 238 -st topic357_2_0 -pt topic357_2_1 -u 0.019501860197299936 > ./result_10chains/node357_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_1 -p 500 -st topic357_3_0 -pt topic357_3_1 -u 0.01328999694390709 > ./result_10chains/node357_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_1 -p 561 -st topic357_4_0 -pt topic357_4_1 -u 0.052151646489149106 > ./result_10chains/node357_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_1 -p 724 -st topic357_5_0 -pt topic357_5_1 -u 0.008586191853463793 > ./result_10chains/node357_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_6_1 -p 819 -st topic357_6_0 -pt topic357_6_1 -u 0.045579319812640975 > ./result_10chains/node357_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_7_1 -p 829 -st topic357_7_0 -pt topic357_7_1 -u 0.0203612659489692 > ./result_10chains/node357_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_8_1 -p 854 -st topic357_8_0 -pt topic357_8_1 -u 0.008072079101883383 > ./result_10chains/node357_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_9_1 -p 860 -st topic357_9_0 -pt topic357_9_1 -u 0.02612164381045584 > ./result_10chains/node357_9_1.txt &
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
    "./result_10chains/node357_0_1.txt 90"
    "./result_10chains/node357_1_1.txt 89"
    "./result_10chains/node357_2_1.txt 88"
    "./result_10chains/node357_3_1.txt 87"
    "./result_10chains/node357_4_1.txt 86"
    "./result_10chains/node357_5_1.txt 85"
    "./result_10chains/node357_6_1.txt 84"
    "./result_10chains/node357_7_1.txt 83"
    "./result_10chains/node357_8_1.txt 82"
    "./result_10chains/node357_9_1.txt 81"
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
