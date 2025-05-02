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
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_1 -p 169 -st topic354_0_0 -pt topic354_0_1 -u 0.03130319952288935 > ./result_8chains/node354_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_1 -p 345 -st topic354_1_0 -pt topic354_1_1 -u 0.0056195858054351455 > ./result_8chains/node354_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_1 -p 346 -st topic354_2_0 -pt topic354_2_1 -u 0.018786710971780862 > ./result_8chains/node354_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_1 -p 585 -st topic354_3_0 -pt topic354_3_1 -u 4.824638306666351e-05 > ./result_8chains/node354_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_1 -p 588 -st topic354_4_0 -pt topic354_4_1 -u 0.05538068469102014 > ./result_8chains/node354_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_1 -p 634 -st topic354_5_0 -pt topic354_5_1 -u 0.008667900494956332 > ./result_8chains/node354_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_6_1 -p 928 -st topic354_6_0 -pt topic354_6_1 -u 0.005486707600832294 > ./result_8chains/node354_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_7_1 -p 956 -st topic354_7_0 -pt topic354_7_1 -u 0.01947334315062284 > ./result_8chains/node354_7_1.txt &
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
    "./result_8chains/node354_0_1.txt 90"
    "./result_8chains/node354_1_1.txt 89"
    "./result_8chains/node354_2_1.txt 88"
    "./result_8chains/node354_3_1.txt 87"
    "./result_8chains/node354_4_1.txt 86"
    "./result_8chains/node354_5_1.txt 85"
    "./result_8chains/node354_6_1.txt 84"
    "./result_8chains/node354_7_1.txt 83"
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
