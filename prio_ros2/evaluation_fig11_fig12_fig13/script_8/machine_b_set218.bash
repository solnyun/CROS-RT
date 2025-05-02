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
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_1 -p 103 -st topic218_0_0 -pt topic218_0_1 -u 0.0016006077794866735 > ./result_8chains/node218_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_1 -p 408 -st topic218_1_0 -pt topic218_1_1 -u 0.031458799232604806 > ./result_8chains/node218_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_1 -p 470 -st topic218_2_0 -pt topic218_2_1 -u 0.003233855717455214 > ./result_8chains/node218_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_1 -p 652 -st topic218_3_0 -pt topic218_3_1 -u 0.02891498769881956 > ./result_8chains/node218_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_1 -p 671 -st topic218_4_0 -pt topic218_4_1 -u 0.0040026346681468206 > ./result_8chains/node218_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_1 -p 709 -st topic218_5_0 -pt topic218_5_1 -u 0.019157575803746274 > ./result_8chains/node218_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_6_1 -p 841 -st topic218_6_0 -pt topic218_6_1 -u 0.007180258802985118 > ./result_8chains/node218_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_7_1 -p 874 -st topic218_7_0 -pt topic218_7_1 -u 0.06365431538569333 > ./result_8chains/node218_7_1.txt &
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
    "./result_8chains/node218_0_1.txt 90"
    "./result_8chains/node218_1_1.txt 89"
    "./result_8chains/node218_2_1.txt 88"
    "./result_8chains/node218_3_1.txt 87"
    "./result_8chains/node218_4_1.txt 86"
    "./result_8chains/node218_5_1.txt 85"
    "./result_8chains/node218_6_1.txt 84"
    "./result_8chains/node218_7_1.txt 83"
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
