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
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_1 -p 151 -st topic453_0_0 -pt topic453_0_1 -u 0.010496659717409151 > ./result_8chains/node453_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_1 -p 259 -st topic453_1_0 -pt topic453_1_1 -u 0.024667079515511392 > ./result_8chains/node453_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_1 -p 439 -st topic453_2_0 -pt topic453_2_1 -u 0.01263648782009058 > ./result_8chains/node453_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_1 -p 702 -st topic453_3_0 -pt topic453_3_1 -u 0.0022556186686292223 > ./result_8chains/node453_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_1 -p 819 -st topic453_4_0 -pt topic453_4_1 -u 0.032903310405255654 > ./result_8chains/node453_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_1 -p 836 -st topic453_5_0 -pt topic453_5_1 -u 0.015116907555432435 > ./result_8chains/node453_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_6_1 -p 950 -st topic453_6_0 -pt topic453_6_1 -u 0.02040380541046124 > ./result_8chains/node453_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_7_1 -p 990 -st topic453_7_0 -pt topic453_7_1 -u 0.005496602478815402 > ./result_8chains/node453_7_1.txt &
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
    "./result_8chains/node453_0_1.txt 90"
    "./result_8chains/node453_1_1.txt 89"
    "./result_8chains/node453_2_1.txt 88"
    "./result_8chains/node453_3_1.txt 87"
    "./result_8chains/node453_4_1.txt 86"
    "./result_8chains/node453_5_1.txt 85"
    "./result_8chains/node453_6_1.txt 84"
    "./result_8chains/node453_7_1.txt 83"
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
