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
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_1 -p 11 -st topic95_0_0 -pt topic95_0_1 -u 0.003596306583776354 > ./result_8chains/node95_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_1 -p 13 -st topic95_1_0 -pt topic95_1_1 -u 0.008865703220007681 > ./result_8chains/node95_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_1 -p 26 -st topic95_2_0 -pt topic95_2_1 -u 0.07315090441044098 > ./result_8chains/node95_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_1 -p 97 -st topic95_3_0 -pt topic95_3_1 -u 0.08237841390190515 > ./result_8chains/node95_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_1 -p 147 -st topic95_4_0 -pt topic95_4_1 -u 0.003955051358421238 > ./result_8chains/node95_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_1 -p 466 -st topic95_5_0 -pt topic95_5_1 -u 0.0002390569512952176 > ./result_8chains/node95_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_6_1 -p 778 -st topic95_6_0 -pt topic95_6_1 -u 0.001632204796420015 > ./result_8chains/node95_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_7_1 -p 908 -st topic95_7_0 -pt topic95_7_1 -u 0.0006514608737687617 > ./result_8chains/node95_7_1.txt &
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
    "./result_8chains/node95_0_1.txt 90"
    "./result_8chains/node95_1_1.txt 89"
    "./result_8chains/node95_2_1.txt 88"
    "./result_8chains/node95_3_1.txt 87"
    "./result_8chains/node95_4_1.txt 86"
    "./result_8chains/node95_5_1.txt 85"
    "./result_8chains/node95_6_1.txt 84"
    "./result_8chains/node95_7_1.txt 83"
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
