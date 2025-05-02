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
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_1 -p 39 -st topic74_0_0 -pt topic74_0_1 -u 0.0015320599873768215 > ./result_10chains/node74_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_1 -p 72 -st topic74_1_0 -pt topic74_1_1 -u 0.05983205552205034 > ./result_10chains/node74_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_1 -p 157 -st topic74_2_0 -pt topic74_2_1 -u 0.018273451555439024 > ./result_10chains/node74_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_1 -p 324 -st topic74_3_0 -pt topic74_3_1 -u 0.0021295064644408224 > ./result_10chains/node74_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_1 -p 533 -st topic74_4_0 -pt topic74_4_1 -u 0.021181455107139147 > ./result_10chains/node74_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_1 -p 651 -st topic74_5_0 -pt topic74_5_1 -u 0.009314308225228746 > ./result_10chains/node74_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_6_1 -p 695 -st topic74_6_0 -pt topic74_6_1 -u 0.005293755282263973 > ./result_10chains/node74_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_7_1 -p 859 -st topic74_7_0 -pt topic74_7_1 -u 0.008835837253141215 > ./result_10chains/node74_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_8_1 -p 867 -st topic74_8_0 -pt topic74_8_1 -u 0.04402309258919594 > ./result_10chains/node74_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_9_1 -p 908 -st topic74_9_0 -pt topic74_9_1 -u 0.01576977614640353 > ./result_10chains/node74_9_1.txt &
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
    "./result_10chains/node74_0_1.txt 90"
    "./result_10chains/node74_1_1.txt 89"
    "./result_10chains/node74_2_1.txt 88"
    "./result_10chains/node74_3_1.txt 87"
    "./result_10chains/node74_4_1.txt 86"
    "./result_10chains/node74_5_1.txt 85"
    "./result_10chains/node74_6_1.txt 84"
    "./result_10chains/node74_7_1.txt 83"
    "./result_10chains/node74_8_1.txt 82"
    "./result_10chains/node74_9_1.txt 81"
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
