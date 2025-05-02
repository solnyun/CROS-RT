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
ros2 run evaluation_3_randomdag uunifast_node -n node275_0_1 -p 39 -st topic275_0_0 -pt topic275_0_1 -u 0.06450022375073972 > ./result_8chains/node275_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_1_1 -p 260 -st topic275_1_0 -pt topic275_1_1 -u 0.027266395781921526 > ./result_8chains/node275_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_2_1 -p 274 -st topic275_2_0 -pt topic275_2_1 -u 0.015513142855408557 > ./result_8chains/node275_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_3_1 -p 641 -st topic275_3_0 -pt topic275_3_1 -u 0.022651045084939925 > ./result_8chains/node275_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_4_1 -p 653 -st topic275_4_0 -pt topic275_4_1 -u 0.007620768527220517 > ./result_8chains/node275_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_5_1 -p 668 -st topic275_5_0 -pt topic275_5_1 -u 0.010731899002054818 > ./result_8chains/node275_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_6_1 -p 759 -st topic275_6_0 -pt topic275_6_1 -u 0.0013413595480868262 > ./result_8chains/node275_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node275_7_1 -p 984 -st topic275_7_0 -pt topic275_7_1 -u 0.009719414370275464 > ./result_8chains/node275_7_1.txt &
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
    "./result_8chains/node275_0_1.txt 90"
    "./result_8chains/node275_1_1.txt 89"
    "./result_8chains/node275_2_1.txt 88"
    "./result_8chains/node275_3_1.txt 87"
    "./result_8chains/node275_4_1.txt 86"
    "./result_8chains/node275_5_1.txt 85"
    "./result_8chains/node275_6_1.txt 84"
    "./result_8chains/node275_7_1.txt 83"
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
