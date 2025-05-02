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
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_1 -p 82 -st topic385_0_0 -pt topic385_0_1 -u 0.002207122671877282 > ./result_10chains/node385_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_1 -p 183 -st topic385_1_0 -pt topic385_1_1 -u 0.0011750370499432616 > ./result_10chains/node385_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_1 -p 256 -st topic385_2_0 -pt topic385_2_1 -u 0.01840219524809067 > ./result_10chains/node385_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_1 -p 580 -st topic385_3_0 -pt topic385_3_1 -u 0.0050132922486395 > ./result_10chains/node385_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_1 -p 744 -st topic385_4_0 -pt topic385_4_1 -u 0.05695557913791713 > ./result_10chains/node385_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_1 -p 751 -st topic385_5_0 -pt topic385_5_1 -u 0.01879215799871914 > ./result_10chains/node385_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_6_1 -p 782 -st topic385_6_0 -pt topic385_6_1 -u 0.029741221464746337 > ./result_10chains/node385_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_7_1 -p 910 -st topic385_7_0 -pt topic385_7_1 -u 0.024518094979730898 > ./result_10chains/node385_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_8_1 -p 974 -st topic385_8_0 -pt topic385_8_1 -u 0.0021897869445748827 > ./result_10chains/node385_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_9_1 -p 999 -st topic385_9_0 -pt topic385_9_1 -u 0.033375222987604994 > ./result_10chains/node385_9_1.txt &
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
    "./result_10chains/node385_0_1.txt 90"
    "./result_10chains/node385_1_1.txt 89"
    "./result_10chains/node385_2_1.txt 88"
    "./result_10chains/node385_3_1.txt 87"
    "./result_10chains/node385_4_1.txt 86"
    "./result_10chains/node385_5_1.txt 85"
    "./result_10chains/node385_6_1.txt 84"
    "./result_10chains/node385_7_1.txt 83"
    "./result_10chains/node385_8_1.txt 82"
    "./result_10chains/node385_9_1.txt 81"
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
