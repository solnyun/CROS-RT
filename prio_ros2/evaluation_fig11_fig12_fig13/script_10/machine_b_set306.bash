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
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_1 -p 74 -st topic306_0_0 -pt topic306_0_1 -u 0.0037750826074733346 > ./result_10chains/node306_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_1 -p 182 -st topic306_1_0 -pt topic306_1_1 -u 0.03152340151818955 > ./result_10chains/node306_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_1 -p 196 -st topic306_2_0 -pt topic306_2_1 -u 0.011406196667079815 > ./result_10chains/node306_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_1 -p 323 -st topic306_3_0 -pt topic306_3_1 -u 0.0019161016030664335 > ./result_10chains/node306_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_1 -p 424 -st topic306_4_0 -pt topic306_4_1 -u 0.030537231241812013 > ./result_10chains/node306_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_1 -p 478 -st topic306_5_0 -pt topic306_5_1 -u 0.003597020563683939 > ./result_10chains/node306_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_6_1 -p 486 -st topic306_6_0 -pt topic306_6_1 -u 0.026105614035278002 > ./result_10chains/node306_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_7_1 -p 724 -st topic306_7_0 -pt topic306_7_1 -u 0.0037788529304173257 > ./result_10chains/node306_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_8_1 -p 843 -st topic306_8_0 -pt topic306_8_1 -u 0.05625148938685275 > ./result_10chains/node306_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_9_1 -p 908 -st topic306_9_0 -pt topic306_9_1 -u 0.001533985238450268 > ./result_10chains/node306_9_1.txt &
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
    "./result_10chains/node306_0_1.txt 90"
    "./result_10chains/node306_1_1.txt 89"
    "./result_10chains/node306_2_1.txt 88"
    "./result_10chains/node306_3_1.txt 87"
    "./result_10chains/node306_4_1.txt 86"
    "./result_10chains/node306_5_1.txt 85"
    "./result_10chains/node306_6_1.txt 84"
    "./result_10chains/node306_7_1.txt 83"
    "./result_10chains/node306_8_1.txt 82"
    "./result_10chains/node306_9_1.txt 81"
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
