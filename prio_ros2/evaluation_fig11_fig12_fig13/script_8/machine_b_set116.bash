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
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_1 -p 23 -st topic116_0_0 -pt topic116_0_1 -u 0.013882494684622049 > ./result_8chains/node116_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_1 -p 99 -st topic116_1_0 -pt topic116_1_1 -u 0.003280801634734154 > ./result_8chains/node116_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_1 -p 365 -st topic116_2_0 -pt topic116_2_1 -u 0.04859782645784205 > ./result_8chains/node116_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_1 -p 622 -st topic116_3_0 -pt topic116_3_1 -u 0.014027468013672495 > ./result_8chains/node116_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_1 -p 781 -st topic116_4_0 -pt topic116_4_1 -u 0.0019269139087215448 > ./result_8chains/node116_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_1 -p 786 -st topic116_5_0 -pt topic116_5_1 -u 0.020267069156404 > ./result_8chains/node116_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_6_1 -p 862 -st topic116_6_0 -pt topic116_6_1 -u 0.007964466002217507 > ./result_8chains/node116_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_7_1 -p 933 -st topic116_7_0 -pt topic116_7_1 -u 0.02913882275015527 > ./result_8chains/node116_7_1.txt &
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
    "./result_8chains/node116_0_1.txt 90"
    "./result_8chains/node116_1_1.txt 89"
    "./result_8chains/node116_2_1.txt 88"
    "./result_8chains/node116_3_1.txt 87"
    "./result_8chains/node116_4_1.txt 86"
    "./result_8chains/node116_5_1.txt 85"
    "./result_8chains/node116_6_1.txt 84"
    "./result_8chains/node116_7_1.txt 83"
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
