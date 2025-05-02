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
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_1 -p 47 -st topic294_0_0 -pt topic294_0_1 -u 0.006940006373994612 > ./result_10chains/node294_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_1 -p 142 -st topic294_1_0 -pt topic294_1_1 -u 0.005278665428951224 > ./result_10chains/node294_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_1 -p 265 -st topic294_2_0 -pt topic294_2_1 -u 0.010201638698260518 > ./result_10chains/node294_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_1 -p 404 -st topic294_3_0 -pt topic294_3_1 -u 0.005252276396258582 > ./result_10chains/node294_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_1 -p 632 -st topic294_4_0 -pt topic294_4_1 -u 0.02707924093734565 > ./result_10chains/node294_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_1 -p 656 -st topic294_5_0 -pt topic294_5_1 -u 0.0017062514445349564 > ./result_10chains/node294_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_6_1 -p 757 -st topic294_6_0 -pt topic294_6_1 -u 0.02253411038179451 > ./result_10chains/node294_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_7_1 -p 780 -st topic294_7_0 -pt topic294_7_1 -u 0.038525725573129735 > ./result_10chains/node294_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_8_1 -p 837 -st topic294_8_0 -pt topic294_8_1 -u 0.013550383004631412 > ./result_10chains/node294_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_9_1 -p 959 -st topic294_9_0 -pt topic294_9_1 -u 0.029094239385082828 > ./result_10chains/node294_9_1.txt &
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
    "./result_10chains/node294_0_1.txt 90"
    "./result_10chains/node294_1_1.txt 89"
    "./result_10chains/node294_2_1.txt 88"
    "./result_10chains/node294_3_1.txt 87"
    "./result_10chains/node294_4_1.txt 86"
    "./result_10chains/node294_5_1.txt 85"
    "./result_10chains/node294_6_1.txt 84"
    "./result_10chains/node294_7_1.txt 83"
    "./result_10chains/node294_8_1.txt 82"
    "./result_10chains/node294_9_1.txt 81"
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
