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
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_1 -p 51 -st topic414_0_0 -pt topic414_0_1 -u 0.0010868066908963359 > ./result_8chains/node414_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_1 -p 184 -st topic414_1_0 -pt topic414_1_1 -u 0.028512068592032536 > ./result_8chains/node414_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_1 -p 201 -st topic414_2_0 -pt topic414_2_1 -u 0.01773423917437117 > ./result_8chains/node414_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_1 -p 260 -st topic414_3_0 -pt topic414_3_1 -u 0.03811652571079255 > ./result_8chains/node414_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_1 -p 363 -st topic414_4_0 -pt topic414_4_1 -u 0.01281579201398636 > ./result_8chains/node414_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_1 -p 433 -st topic414_5_0 -pt topic414_5_1 -u 0.003988638929580082 > ./result_8chains/node414_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_6_1 -p 575 -st topic414_6_0 -pt topic414_6_1 -u 0.0007083469964903333 > ./result_8chains/node414_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_7_1 -p 755 -st topic414_7_0 -pt topic414_7_1 -u 0.0007653742060768423 > ./result_8chains/node414_7_1.txt &
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
    "./result_8chains/node414_0_1.txt 90"
    "./result_8chains/node414_1_1.txt 89"
    "./result_8chains/node414_2_1.txt 88"
    "./result_8chains/node414_3_1.txt 87"
    "./result_8chains/node414_4_1.txt 86"
    "./result_8chains/node414_5_1.txt 85"
    "./result_8chains/node414_6_1.txt 84"
    "./result_8chains/node414_7_1.txt 83"
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
