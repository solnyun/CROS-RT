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
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_1 -p 64 -st topic187_0_0 -pt topic187_0_1 -u 0.008681612132056815 > ./result_8chains/node187_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_1 -p 130 -st topic187_1_0 -pt topic187_1_1 -u 0.034514234306112 > ./result_8chains/node187_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_1 -p 170 -st topic187_2_0 -pt topic187_2_1 -u 0.0373590176090382 > ./result_8chains/node187_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_1 -p 414 -st topic187_3_0 -pt topic187_3_1 -u 0.03311274970838368 > ./result_8chains/node187_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_1 -p 579 -st topic187_4_0 -pt topic187_4_1 -u 0.013009385049936428 > ./result_8chains/node187_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_1 -p 718 -st topic187_5_0 -pt topic187_5_1 -u 0.07420902255792791 > ./result_8chains/node187_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_6_1 -p 740 -st topic187_6_0 -pt topic187_6_1 -u 0.043192753709401094 > ./result_8chains/node187_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_7_1 -p 975 -st topic187_7_0 -pt topic187_7_1 -u 0.0038337594454425257 > ./result_8chains/node187_7_1.txt &
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
    "./result_8chains/node187_0_1.txt 90"
    "./result_8chains/node187_1_1.txt 89"
    "./result_8chains/node187_2_1.txt 88"
    "./result_8chains/node187_3_1.txt 87"
    "./result_8chains/node187_4_1.txt 86"
    "./result_8chains/node187_5_1.txt 85"
    "./result_8chains/node187_6_1.txt 84"
    "./result_8chains/node187_7_1.txt 83"
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
