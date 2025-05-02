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
ros2 run evaluation_3_randomdag uunifast_node -n node133_0_1 -p 114 -st topic133_0_0 -pt topic133_0_1 -u 0.009005270176196956 > ./result_10chains/node133_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_1_1 -p 127 -st topic133_1_0 -pt topic133_1_1 -u 0.003492589921320177 > ./result_10chains/node133_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_2_1 -p 335 -st topic133_2_0 -pt topic133_2_1 -u 0.028681094330068102 > ./result_10chains/node133_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_3_1 -p 665 -st topic133_3_0 -pt topic133_3_1 -u 0.017112113024270736 > ./result_10chains/node133_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_4_1 -p 721 -st topic133_4_0 -pt topic133_4_1 -u 0.005383359834961354 > ./result_10chains/node133_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_5_1 -p 744 -st topic133_5_0 -pt topic133_5_1 -u 0.025655722778082174 > ./result_10chains/node133_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_6_1 -p 837 -st topic133_6_0 -pt topic133_6_1 -u 0.005067205027735278 > ./result_10chains/node133_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_7_1 -p 890 -st topic133_7_0 -pt topic133_7_1 -u 0.007750017591687072 > ./result_10chains/node133_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_8_1 -p 939 -st topic133_8_0 -pt topic133_8_1 -u 0.0454526140717406 > ./result_10chains/node133_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_9_1 -p 991 -st topic133_9_0 -pt topic133_9_1 -u 0.017649897984055633 > ./result_10chains/node133_9_1.txt &
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
    "./result_10chains/node133_0_1.txt 90"
    "./result_10chains/node133_1_1.txt 89"
    "./result_10chains/node133_2_1.txt 88"
    "./result_10chains/node133_3_1.txt 87"
    "./result_10chains/node133_4_1.txt 86"
    "./result_10chains/node133_5_1.txt 85"
    "./result_10chains/node133_6_1.txt 84"
    "./result_10chains/node133_7_1.txt 83"
    "./result_10chains/node133_8_1.txt 82"
    "./result_10chains/node133_9_1.txt 81"
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
