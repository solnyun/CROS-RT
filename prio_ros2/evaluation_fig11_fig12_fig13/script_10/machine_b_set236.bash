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
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_1 -p 167 -st topic236_0_0 -pt topic236_0_1 -u 0.0048343711289360325 > ./result_10chains/node236_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_1 -p 342 -st topic236_1_0 -pt topic236_1_1 -u 0.004850277225420974 > ./result_10chains/node236_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_1 -p 401 -st topic236_2_0 -pt topic236_2_1 -u 0.0012698779587610454 > ./result_10chains/node236_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_1 -p 486 -st topic236_3_0 -pt topic236_3_1 -u 0.0335684775295817 > ./result_10chains/node236_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_1 -p 496 -st topic236_4_0 -pt topic236_4_1 -u 0.031669313169374935 > ./result_10chains/node236_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_1 -p 521 -st topic236_5_0 -pt topic236_5_1 -u 0.00668746167922063 > ./result_10chains/node236_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_6_1 -p 597 -st topic236_6_0 -pt topic236_6_1 -u 0.003825898722361637 > ./result_10chains/node236_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_7_1 -p 807 -st topic236_7_0 -pt topic236_7_1 -u 0.00744589349173394 > ./result_10chains/node236_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_8_1 -p 898 -st topic236_8_0 -pt topic236_8_1 -u 0.03199346041332586 > ./result_10chains/node236_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_9_1 -p 993 -st topic236_9_0 -pt topic236_9_1 -u 0.01444604765208509 > ./result_10chains/node236_9_1.txt &
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
    "./result_10chains/node236_0_1.txt 90"
    "./result_10chains/node236_1_1.txt 89"
    "./result_10chains/node236_2_1.txt 88"
    "./result_10chains/node236_3_1.txt 87"
    "./result_10chains/node236_4_1.txt 86"
    "./result_10chains/node236_5_1.txt 85"
    "./result_10chains/node236_6_1.txt 84"
    "./result_10chains/node236_7_1.txt 83"
    "./result_10chains/node236_8_1.txt 82"
    "./result_10chains/node236_9_1.txt 81"
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
