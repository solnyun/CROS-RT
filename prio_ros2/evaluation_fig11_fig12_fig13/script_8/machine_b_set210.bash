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
ros2 run evaluation_3_randomdag uunifast_node -n node210_0_1 -p 87 -st topic210_0_0 -pt topic210_0_1 -u 0.01881714602257556 > ./result_8chains/node210_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_1_1 -p 117 -st topic210_1_0 -pt topic210_1_1 -u 0.03993375362452384 > ./result_8chains/node210_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_2_1 -p 273 -st topic210_2_0 -pt topic210_2_1 -u 0.020444489823368994 > ./result_8chains/node210_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_3_1 -p 349 -st topic210_3_0 -pt topic210_3_1 -u 0.013864862973513026 > ./result_8chains/node210_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_4_1 -p 411 -st topic210_4_0 -pt topic210_4_1 -u 0.055964890408223195 > ./result_8chains/node210_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_5_1 -p 516 -st topic210_5_0 -pt topic210_5_1 -u 0.018773253046965754 > ./result_8chains/node210_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_6_1 -p 675 -st topic210_6_0 -pt topic210_6_1 -u 0.0006994495193202721 > ./result_8chains/node210_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node210_7_1 -p 926 -st topic210_7_0 -pt topic210_7_1 -u 0.002096553140062892 > ./result_8chains/node210_7_1.txt &
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
    "./result_8chains/node210_0_1.txt 90"
    "./result_8chains/node210_1_1.txt 89"
    "./result_8chains/node210_2_1.txt 88"
    "./result_8chains/node210_3_1.txt 87"
    "./result_8chains/node210_4_1.txt 86"
    "./result_8chains/node210_5_1.txt 85"
    "./result_8chains/node210_6_1.txt 84"
    "./result_8chains/node210_7_1.txt 83"
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
