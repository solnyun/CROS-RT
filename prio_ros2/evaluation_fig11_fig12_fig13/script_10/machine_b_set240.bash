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
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_1 -p 57 -st topic240_0_0 -pt topic240_0_1 -u 0.0004778637341566472 > ./result_10chains/node240_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_1 -p 254 -st topic240_1_0 -pt topic240_1_1 -u 9.979579724189724e-05 > ./result_10chains/node240_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_1 -p 290 -st topic240_2_0 -pt topic240_2_1 -u 0.005515909841123934 > ./result_10chains/node240_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_1 -p 324 -st topic240_3_0 -pt topic240_3_1 -u 0.005303352864894251 > ./result_10chains/node240_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_1 -p 364 -st topic240_4_0 -pt topic240_4_1 -u 0.0008822892406144534 > ./result_10chains/node240_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_1 -p 530 -st topic240_5_0 -pt topic240_5_1 -u 0.00585872113940078 > ./result_10chains/node240_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_6_1 -p 551 -st topic240_6_0 -pt topic240_6_1 -u 0.02272248076892458 > ./result_10chains/node240_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_7_1 -p 701 -st topic240_7_0 -pt topic240_7_1 -u 0.10351869274838754 > ./result_10chains/node240_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_8_1 -p 702 -st topic240_8_0 -pt topic240_8_1 -u 0.017145188242957257 > ./result_10chains/node240_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_9_1 -p 731 -st topic240_9_0 -pt topic240_9_1 -u 0.007402146583594272 > ./result_10chains/node240_9_1.txt &
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
    "./result_10chains/node240_0_1.txt 90"
    "./result_10chains/node240_1_1.txt 89"
    "./result_10chains/node240_2_1.txt 88"
    "./result_10chains/node240_3_1.txt 87"
    "./result_10chains/node240_4_1.txt 86"
    "./result_10chains/node240_5_1.txt 85"
    "./result_10chains/node240_6_1.txt 84"
    "./result_10chains/node240_7_1.txt 83"
    "./result_10chains/node240_8_1.txt 82"
    "./result_10chains/node240_9_1.txt 81"
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
