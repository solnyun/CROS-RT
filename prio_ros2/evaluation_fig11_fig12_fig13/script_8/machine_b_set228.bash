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
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_1 -p 183 -st topic228_0_0 -pt topic228_0_1 -u 0.047406997823736086 > ./result_8chains/node228_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_1 -p 468 -st topic228_1_0 -pt topic228_1_1 -u 0.029209548121071738 > ./result_8chains/node228_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_1 -p 485 -st topic228_2_0 -pt topic228_2_1 -u 0.09635042939752869 > ./result_8chains/node228_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_1 -p 502 -st topic228_3_0 -pt topic228_3_1 -u 5.8404422501323605e-06 > ./result_8chains/node228_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_1 -p 676 -st topic228_4_0 -pt topic228_4_1 -u 0.04265172752978094 > ./result_8chains/node228_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_1 -p 739 -st topic228_5_0 -pt topic228_5_1 -u 0.008570955611122505 > ./result_8chains/node228_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_6_1 -p 742 -st topic228_6_0 -pt topic228_6_1 -u 0.0029693284019678377 > ./result_8chains/node228_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_7_1 -p 744 -st topic228_7_0 -pt topic228_7_1 -u 0.0017921735834233634 > ./result_8chains/node228_7_1.txt &
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
    "./result_8chains/node228_0_1.txt 90"
    "./result_8chains/node228_1_1.txt 89"
    "./result_8chains/node228_2_1.txt 88"
    "./result_8chains/node228_3_1.txt 87"
    "./result_8chains/node228_4_1.txt 86"
    "./result_8chains/node228_5_1.txt 85"
    "./result_8chains/node228_6_1.txt 84"
    "./result_8chains/node228_7_1.txt 83"
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
