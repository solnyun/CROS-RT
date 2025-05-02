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
ros2 run evaluation_3_randomdag uunifast_node -n node161_0_1 -p 228 -st topic161_0_0 -pt topic161_0_1 -u 0.06157422817814068 > ./result_8chains/node161_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_1_1 -p 298 -st topic161_1_0 -pt topic161_1_1 -u 0.006720100014535213 > ./result_8chains/node161_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_2_1 -p 675 -st topic161_2_0 -pt topic161_2_1 -u 0.005043604015009806 > ./result_8chains/node161_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_3_1 -p 705 -st topic161_3_0 -pt topic161_3_1 -u 0.007720522296572496 > ./result_8chains/node161_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_4_1 -p 723 -st topic161_4_0 -pt topic161_4_1 -u 0.008897680038384648 > ./result_8chains/node161_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_5_1 -p 852 -st topic161_5_0 -pt topic161_5_1 -u 0.0009342027717519075 > ./result_8chains/node161_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_6_1 -p 926 -st topic161_6_0 -pt topic161_6_1 -u 0.012086908087918125 > ./result_8chains/node161_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node161_7_1 -p 959 -st topic161_7_0 -pt topic161_7_1 -u 0.014571937751263343 > ./result_8chains/node161_7_1.txt &
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
    "./result_8chains/node161_0_1.txt 90"
    "./result_8chains/node161_1_1.txt 89"
    "./result_8chains/node161_2_1.txt 88"
    "./result_8chains/node161_3_1.txt 87"
    "./result_8chains/node161_4_1.txt 86"
    "./result_8chains/node161_5_1.txt 85"
    "./result_8chains/node161_6_1.txt 84"
    "./result_8chains/node161_7_1.txt 83"
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
