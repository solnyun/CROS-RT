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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_1 -p 29 -st topic281_0_0 -pt topic281_0_1 -u 0.018900266392598175 > ./result_10chains/node281_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_1 -p 82 -st topic281_1_0 -pt topic281_1_1 -u 0.003128821701182616 > ./result_10chains/node281_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_1 -p 147 -st topic281_2_0 -pt topic281_2_1 -u 0.00951485665170182 > ./result_10chains/node281_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_1 -p 233 -st topic281_3_0 -pt topic281_3_1 -u 0.0012430782380470906 > ./result_10chains/node281_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_1 -p 251 -st topic281_4_0 -pt topic281_4_1 -u 0.0008793067077633165 > ./result_10chains/node281_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_1 -p 448 -st topic281_5_0 -pt topic281_5_1 -u 0.002398958086323011 > ./result_10chains/node281_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_6_1 -p 454 -st topic281_6_0 -pt topic281_6_1 -u 0.019801921815083695 > ./result_10chains/node281_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_7_1 -p 585 -st topic281_7_0 -pt topic281_7_1 -u 0.020327625498087587 > ./result_10chains/node281_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_8_1 -p 913 -st topic281_8_0 -pt topic281_8_1 -u 0.011672780125598109 > ./result_10chains/node281_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_9_1 -p 927 -st topic281_9_0 -pt topic281_9_1 -u 0.012364643377668471 > ./result_10chains/node281_9_1.txt &
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
    "./result_10chains/node281_0_1.txt 90"
    "./result_10chains/node281_1_1.txt 89"
    "./result_10chains/node281_2_1.txt 88"
    "./result_10chains/node281_3_1.txt 87"
    "./result_10chains/node281_4_1.txt 86"
    "./result_10chains/node281_5_1.txt 85"
    "./result_10chains/node281_6_1.txt 84"
    "./result_10chains/node281_7_1.txt 83"
    "./result_10chains/node281_8_1.txt 82"
    "./result_10chains/node281_9_1.txt 81"
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
