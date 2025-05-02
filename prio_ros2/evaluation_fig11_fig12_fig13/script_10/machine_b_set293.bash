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
ros2 run evaluation_3_randomdag uunifast_node -n node293_0_1 -p 147 -st topic293_0_0 -pt topic293_0_1 -u 0.0026162639853889447 > ./result_10chains/node293_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_1_1 -p 235 -st topic293_1_0 -pt topic293_1_1 -u 0.001259431552364021 > ./result_10chains/node293_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_2_1 -p 296 -st topic293_2_0 -pt topic293_2_1 -u 0.021252759549433176 > ./result_10chains/node293_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_3_1 -p 395 -st topic293_3_0 -pt topic293_3_1 -u 0.009408446159185013 > ./result_10chains/node293_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_4_1 -p 413 -st topic293_4_0 -pt topic293_4_1 -u 0.015721327240852456 > ./result_10chains/node293_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_5_1 -p 499 -st topic293_5_0 -pt topic293_5_1 -u 0.015199563373922642 > ./result_10chains/node293_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_6_1 -p 539 -st topic293_6_0 -pt topic293_6_1 -u 0.02656621180912383 > ./result_10chains/node293_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_7_1 -p 580 -st topic293_7_0 -pt topic293_7_1 -u 0.005880738632692589 > ./result_10chains/node293_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_8_1 -p 687 -st topic293_8_0 -pt topic293_8_1 -u 0.00891135641866253 > ./result_10chains/node293_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node293_9_1 -p 847 -st topic293_9_0 -pt topic293_9_1 -u 0.008121691709936457 > ./result_10chains/node293_9_1.txt &
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
    "./result_10chains/node293_0_1.txt 90"
    "./result_10chains/node293_1_1.txt 89"
    "./result_10chains/node293_2_1.txt 88"
    "./result_10chains/node293_3_1.txt 87"
    "./result_10chains/node293_4_1.txt 86"
    "./result_10chains/node293_5_1.txt 85"
    "./result_10chains/node293_6_1.txt 84"
    "./result_10chains/node293_7_1.txt 83"
    "./result_10chains/node293_8_1.txt 82"
    "./result_10chains/node293_9_1.txt 81"
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
