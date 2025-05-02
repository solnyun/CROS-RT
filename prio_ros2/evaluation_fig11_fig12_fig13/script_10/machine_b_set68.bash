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
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_1 -p 44 -st topic68_0_0 -pt topic68_0_1 -u 0.0033742242530076516 > ./result_10chains/node68_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_1 -p 109 -st topic68_1_0 -pt topic68_1_1 -u 0.023862923488926713 > ./result_10chains/node68_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_1 -p 270 -st topic68_2_0 -pt topic68_2_1 -u 0.040261451597966846 > ./result_10chains/node68_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_1 -p 431 -st topic68_3_0 -pt topic68_3_1 -u 0.012973712513262653 > ./result_10chains/node68_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_1 -p 434 -st topic68_4_0 -pt topic68_4_1 -u 0.012224390839790211 > ./result_10chains/node68_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_1 -p 490 -st topic68_5_0 -pt topic68_5_1 -u 0.011970832344890853 > ./result_10chains/node68_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_6_1 -p 587 -st topic68_6_0 -pt topic68_6_1 -u 0.01626451050771427 > ./result_10chains/node68_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_7_1 -p 605 -st topic68_7_0 -pt topic68_7_1 -u 0.0011832701117713285 > ./result_10chains/node68_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_8_1 -p 817 -st topic68_8_0 -pt topic68_8_1 -u 0.004306913068376252 > ./result_10chains/node68_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_9_1 -p 847 -st topic68_9_0 -pt topic68_9_1 -u 0.011384919853108313 > ./result_10chains/node68_9_1.txt &
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
    "./result_10chains/node68_0_1.txt 90"
    "./result_10chains/node68_1_1.txt 89"
    "./result_10chains/node68_2_1.txt 88"
    "./result_10chains/node68_3_1.txt 87"
    "./result_10chains/node68_4_1.txt 86"
    "./result_10chains/node68_5_1.txt 85"
    "./result_10chains/node68_6_1.txt 84"
    "./result_10chains/node68_7_1.txt 83"
    "./result_10chains/node68_8_1.txt 82"
    "./result_10chains/node68_9_1.txt 81"
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
