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
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_1 -p 34 -st topic264_0_0 -pt topic264_0_1 -u 0.03802134981074645 > ./result_8chains/node264_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_1 -p 150 -st topic264_1_0 -pt topic264_1_1 -u 0.010990946768023535 > ./result_8chains/node264_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_1 -p 363 -st topic264_2_0 -pt topic264_2_1 -u 0.04155138573919198 > ./result_8chains/node264_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_1 -p 498 -st topic264_3_0 -pt topic264_3_1 -u 0.0880430066383793 > ./result_8chains/node264_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_1 -p 506 -st topic264_4_0 -pt topic264_4_1 -u 0.04495591423494369 > ./result_8chains/node264_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_1 -p 587 -st topic264_5_0 -pt topic264_5_1 -u 0.0161415437923922 > ./result_8chains/node264_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_6_1 -p 810 -st topic264_6_0 -pt topic264_6_1 -u 0.0034797179227339103 > ./result_8chains/node264_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_7_1 -p 939 -st topic264_7_0 -pt topic264_7_1 -u 0.008755535137407747 > ./result_8chains/node264_7_1.txt &
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
    "./result_8chains/node264_0_1.txt 90"
    "./result_8chains/node264_1_1.txt 89"
    "./result_8chains/node264_2_1.txt 88"
    "./result_8chains/node264_3_1.txt 87"
    "./result_8chains/node264_4_1.txt 86"
    "./result_8chains/node264_5_1.txt 85"
    "./result_8chains/node264_6_1.txt 84"
    "./result_8chains/node264_7_1.txt 83"
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
