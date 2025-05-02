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
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_1 -p 23 -st topic49_0_0 -pt topic49_0_1 -u 0.05165827374010695 > ./result_10chains/node49_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_1 -p 356 -st topic49_1_0 -pt topic49_1_1 -u 0.02284871503710406 > ./result_10chains/node49_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_1 -p 368 -st topic49_2_0 -pt topic49_2_1 -u 0.06570987615225304 > ./result_10chains/node49_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_1 -p 451 -st topic49_3_0 -pt topic49_3_1 -u 0.007842209298801861 > ./result_10chains/node49_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_1 -p 453 -st topic49_4_0 -pt topic49_4_1 -u 0.01995152279627907 > ./result_10chains/node49_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_1 -p 721 -st topic49_5_0 -pt topic49_5_1 -u 0.025723908574359577 > ./result_10chains/node49_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_6_1 -p 732 -st topic49_6_0 -pt topic49_6_1 -u 0.02877682332171945 > ./result_10chains/node49_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_7_1 -p 746 -st topic49_7_0 -pt topic49_7_1 -u 0.012497116058547753 > ./result_10chains/node49_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_8_1 -p 944 -st topic49_8_0 -pt topic49_8_1 -u 0.012541177916276215 > ./result_10chains/node49_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node49_9_1 -p 962 -st topic49_9_0 -pt topic49_9_1 -u 0.011229942411012873 > ./result_10chains/node49_9_1.txt &
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
    "./result_10chains/node49_0_1.txt 90"
    "./result_10chains/node49_1_1.txt 89"
    "./result_10chains/node49_2_1.txt 88"
    "./result_10chains/node49_3_1.txt 87"
    "./result_10chains/node49_4_1.txt 86"
    "./result_10chains/node49_5_1.txt 85"
    "./result_10chains/node49_6_1.txt 84"
    "./result_10chains/node49_7_1.txt 83"
    "./result_10chains/node49_8_1.txt 82"
    "./result_10chains/node49_9_1.txt 81"
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
