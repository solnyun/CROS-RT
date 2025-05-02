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
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_1 -p 14 -st topic335_0_0 -pt topic335_0_1 -u 0.011391740868071876 > ./result_8chains/node335_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_1 -p 241 -st topic335_1_0 -pt topic335_1_1 -u 0.026965179555825558 > ./result_8chains/node335_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_1 -p 299 -st topic335_2_0 -pt topic335_2_1 -u 0.002605802762691567 > ./result_8chains/node335_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_1 -p 392 -st topic335_3_0 -pt topic335_3_1 -u 0.010871780506473416 > ./result_8chains/node335_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_1 -p 877 -st topic335_4_0 -pt topic335_4_1 -u 0.0396271391649953 > ./result_8chains/node335_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_1 -p 897 -st topic335_5_0 -pt topic335_5_1 -u 0.01722271096967759 > ./result_8chains/node335_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_6_1 -p 905 -st topic335_6_0 -pt topic335_6_1 -u 0.009158155111015406 > ./result_8chains/node335_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_7_1 -p 955 -st topic335_7_0 -pt topic335_7_1 -u 0.02546026124882761 > ./result_8chains/node335_7_1.txt &
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
    "./result_8chains/node335_0_1.txt 90"
    "./result_8chains/node335_1_1.txt 89"
    "./result_8chains/node335_2_1.txt 88"
    "./result_8chains/node335_3_1.txt 87"
    "./result_8chains/node335_4_1.txt 86"
    "./result_8chains/node335_5_1.txt 85"
    "./result_8chains/node335_6_1.txt 84"
    "./result_8chains/node335_7_1.txt 83"
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
