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
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_1 -p 89 -st topic369_0_0 -pt topic369_0_1 -u 0.019095141054013998 > ./result_8chains/node369_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_1 -p 221 -st topic369_1_0 -pt topic369_1_1 -u 0.00033418355080466755 > ./result_8chains/node369_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_1 -p 290 -st topic369_2_0 -pt topic369_2_1 -u 0.0007705540002920785 > ./result_8chains/node369_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_1 -p 433 -st topic369_3_0 -pt topic369_3_1 -u 0.03397267989337746 > ./result_8chains/node369_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_1 -p 674 -st topic369_4_0 -pt topic369_4_1 -u 0.030105830372007925 > ./result_8chains/node369_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_1 -p 677 -st topic369_5_0 -pt topic369_5_1 -u 0.00412487011906057 > ./result_8chains/node369_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_6_1 -p 721 -st topic369_6_0 -pt topic369_6_1 -u 0.009672422713395981 > ./result_8chains/node369_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_7_1 -p 832 -st topic369_7_0 -pt topic369_7_1 -u 0.00550040942157597 > ./result_8chains/node369_7_1.txt &
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
    "./result_8chains/node369_0_1.txt 90"
    "./result_8chains/node369_1_1.txt 89"
    "./result_8chains/node369_2_1.txt 88"
    "./result_8chains/node369_3_1.txt 87"
    "./result_8chains/node369_4_1.txt 86"
    "./result_8chains/node369_5_1.txt 85"
    "./result_8chains/node369_6_1.txt 84"
    "./result_8chains/node369_7_1.txt 83"
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
