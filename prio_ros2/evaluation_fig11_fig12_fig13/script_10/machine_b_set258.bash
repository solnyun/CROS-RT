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
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_1 -p 190 -st topic258_0_0 -pt topic258_0_1 -u 0.00907224281016622 > ./result_10chains/node258_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_1 -p 266 -st topic258_1_0 -pt topic258_1_1 -u 0.004350081709282694 > ./result_10chains/node258_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_1 -p 353 -st topic258_2_0 -pt topic258_2_1 -u 0.030021357143791283 > ./result_10chains/node258_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_1 -p 444 -st topic258_3_0 -pt topic258_3_1 -u 0.003325023994364462 > ./result_10chains/node258_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_1 -p 560 -st topic258_4_0 -pt topic258_4_1 -u 0.0225731993345179 > ./result_10chains/node258_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_1 -p 763 -st topic258_5_0 -pt topic258_5_1 -u 0.00023100789957952728 > ./result_10chains/node258_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_6_1 -p 811 -st topic258_6_0 -pt topic258_6_1 -u 0.04704130334172879 > ./result_10chains/node258_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_7_1 -p 848 -st topic258_7_0 -pt topic258_7_1 -u 0.020141012451203144 > ./result_10chains/node258_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_8_1 -p 892 -st topic258_8_0 -pt topic258_8_1 -u 0.01873815809691788 > ./result_10chains/node258_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_9_1 -p 901 -st topic258_9_0 -pt topic258_9_1 -u 0.018861684847853236 > ./result_10chains/node258_9_1.txt &
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
    "./result_10chains/node258_0_1.txt 90"
    "./result_10chains/node258_1_1.txt 89"
    "./result_10chains/node258_2_1.txt 88"
    "./result_10chains/node258_3_1.txt 87"
    "./result_10chains/node258_4_1.txt 86"
    "./result_10chains/node258_5_1.txt 85"
    "./result_10chains/node258_6_1.txt 84"
    "./result_10chains/node258_7_1.txt 83"
    "./result_10chains/node258_8_1.txt 82"
    "./result_10chains/node258_9_1.txt 81"
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
