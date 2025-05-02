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
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_1 -p 52 -st topic134_0_0 -pt topic134_0_1 -u 0.012231448137626888 > ./result_8chains/node134_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_1 -p 55 -st topic134_1_0 -pt topic134_1_1 -u 0.01769599270732819 > ./result_8chains/node134_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_1 -p 59 -st topic134_2_0 -pt topic134_2_1 -u 0.06420253277127391 > ./result_8chains/node134_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_1 -p 129 -st topic134_3_0 -pt topic134_3_1 -u 0.03942370151184543 > ./result_8chains/node134_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_1 -p 200 -st topic134_4_0 -pt topic134_4_1 -u 0.02216560431318612 > ./result_8chains/node134_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_1 -p 298 -st topic134_5_0 -pt topic134_5_1 -u 0.0040233602038584615 > ./result_8chains/node134_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_6_1 -p 485 -st topic134_6_0 -pt topic134_6_1 -u 0.032757668872316015 > ./result_8chains/node134_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_7_1 -p 684 -st topic134_7_0 -pt topic134_7_1 -u 0.015039704014514182 > ./result_8chains/node134_7_1.txt &
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
    "./result_8chains/node134_0_1.txt 90"
    "./result_8chains/node134_1_1.txt 89"
    "./result_8chains/node134_2_1.txt 88"
    "./result_8chains/node134_3_1.txt 87"
    "./result_8chains/node134_4_1.txt 86"
    "./result_8chains/node134_5_1.txt 85"
    "./result_8chains/node134_6_1.txt 84"
    "./result_8chains/node134_7_1.txt 83"
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
