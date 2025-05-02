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
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_1 -p 21 -st topic85_0_0 -pt topic85_0_1 -u 0.0019444967285807135 > ./result_8chains/node85_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_1 -p 526 -st topic85_1_0 -pt topic85_1_1 -u 0.024902309704493697 > ./result_8chains/node85_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_1 -p 542 -st topic85_2_0 -pt topic85_2_1 -u 0.027325136372549574 > ./result_8chains/node85_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_1 -p 562 -st topic85_3_0 -pt topic85_3_1 -u 0.0005772287455277358 > ./result_8chains/node85_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_1 -p 635 -st topic85_4_0 -pt topic85_4_1 -u 0.06960924371368044 > ./result_8chains/node85_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_1 -p 695 -st topic85_5_0 -pt topic85_5_1 -u 0.009632451017964075 > ./result_8chains/node85_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_6_1 -p 933 -st topic85_6_0 -pt topic85_6_1 -u 0.00580926264727416 > ./result_8chains/node85_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_7_1 -p 967 -st topic85_7_0 -pt topic85_7_1 -u 0.016147989079558518 > ./result_8chains/node85_7_1.txt &
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
    "./result_8chains/node85_0_1.txt 90"
    "./result_8chains/node85_1_1.txt 89"
    "./result_8chains/node85_2_1.txt 88"
    "./result_8chains/node85_3_1.txt 87"
    "./result_8chains/node85_4_1.txt 86"
    "./result_8chains/node85_5_1.txt 85"
    "./result_8chains/node85_6_1.txt 84"
    "./result_8chains/node85_7_1.txt 83"
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
