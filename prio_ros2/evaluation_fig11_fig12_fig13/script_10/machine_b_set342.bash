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
ros2 run evaluation_3_randomdag uunifast_node -n node342_0_1 -p 27 -st topic342_0_0 -pt topic342_0_1 -u 0.024237987482066403 > ./result_10chains/node342_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_1_1 -p 106 -st topic342_1_0 -pt topic342_1_1 -u 0.005237413479221464 > ./result_10chains/node342_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_2_1 -p 341 -st topic342_2_0 -pt topic342_2_1 -u 0.007274843529639474 > ./result_10chains/node342_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_3_1 -p 431 -st topic342_3_0 -pt topic342_3_1 -u 0.004979044858273884 > ./result_10chains/node342_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_4_1 -p 589 -st topic342_4_0 -pt topic342_4_1 -u 0.018667900769930024 > ./result_10chains/node342_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_5_1 -p 682 -st topic342_5_0 -pt topic342_5_1 -u 0.008628096682957304 > ./result_10chains/node342_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_6_1 -p 841 -st topic342_6_0 -pt topic342_6_1 -u 0.014690076173319466 > ./result_10chains/node342_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_7_1 -p 867 -st topic342_7_0 -pt topic342_7_1 -u 0.010595330823121932 > ./result_10chains/node342_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_8_1 -p 960 -st topic342_8_0 -pt topic342_8_1 -u 0.042853359386786555 > ./result_10chains/node342_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_9_1 -p 981 -st topic342_9_0 -pt topic342_9_1 -u 0.004440091697356347 > ./result_10chains/node342_9_1.txt &
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
    "./result_10chains/node342_0_1.txt 90"
    "./result_10chains/node342_1_1.txt 89"
    "./result_10chains/node342_2_1.txt 88"
    "./result_10chains/node342_3_1.txt 87"
    "./result_10chains/node342_4_1.txt 86"
    "./result_10chains/node342_5_1.txt 85"
    "./result_10chains/node342_6_1.txt 84"
    "./result_10chains/node342_7_1.txt 83"
    "./result_10chains/node342_8_1.txt 82"
    "./result_10chains/node342_9_1.txt 81"
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
