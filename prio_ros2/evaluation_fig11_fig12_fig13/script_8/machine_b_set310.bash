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
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_1 -p 82 -st topic310_0_0 -pt topic310_0_1 -u 0.028738741232065435 > ./result_8chains/node310_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_1 -p 137 -st topic310_1_0 -pt topic310_1_1 -u 0.002484962974864835 > ./result_8chains/node310_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_1 -p 183 -st topic310_2_0 -pt topic310_2_1 -u 0.016172179402177245 > ./result_8chains/node310_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_1 -p 275 -st topic310_3_0 -pt topic310_3_1 -u 0.10664097678159279 > ./result_8chains/node310_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_1 -p 344 -st topic310_4_0 -pt topic310_4_1 -u 0.012845677279113704 > ./result_8chains/node310_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_1 -p 364 -st topic310_5_0 -pt topic310_5_1 -u 0.003940210324520521 > ./result_8chains/node310_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_6_1 -p 527 -st topic310_6_0 -pt topic310_6_1 -u 0.01486872986690059 > ./result_8chains/node310_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_7_1 -p 556 -st topic310_7_0 -pt topic310_7_1 -u 0.021420428346685956 > ./result_8chains/node310_7_1.txt &
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
    "./result_8chains/node310_0_1.txt 90"
    "./result_8chains/node310_1_1.txt 89"
    "./result_8chains/node310_2_1.txt 88"
    "./result_8chains/node310_3_1.txt 87"
    "./result_8chains/node310_4_1.txt 86"
    "./result_8chains/node310_5_1.txt 85"
    "./result_8chains/node310_6_1.txt 84"
    "./result_8chains/node310_7_1.txt 83"
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
