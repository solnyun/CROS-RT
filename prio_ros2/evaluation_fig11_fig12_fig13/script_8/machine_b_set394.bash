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
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_1 -p 160 -st topic394_0_0 -pt topic394_0_1 -u 0.019461659409188647 > ./result_8chains/node394_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_1 -p 304 -st topic394_1_0 -pt topic394_1_1 -u 0.014056422913565236 > ./result_8chains/node394_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_1 -p 432 -st topic394_2_0 -pt topic394_2_1 -u 0.012850159881180101 > ./result_8chains/node394_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_1 -p 604 -st topic394_3_0 -pt topic394_3_1 -u 0.02704419908282435 > ./result_8chains/node394_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_1 -p 678 -st topic394_4_0 -pt topic394_4_1 -u 0.00293448459537321 > ./result_8chains/node394_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_1 -p 763 -st topic394_5_0 -pt topic394_5_1 -u 0.08212960455696428 > ./result_8chains/node394_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_6_1 -p 772 -st topic394_6_0 -pt topic394_6_1 -u 0.026350829241123107 > ./result_8chains/node394_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_7_1 -p 881 -st topic394_7_0 -pt topic394_7_1 -u 0.0019222816880584731 > ./result_8chains/node394_7_1.txt &
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
    "./result_8chains/node394_0_1.txt 90"
    "./result_8chains/node394_1_1.txt 89"
    "./result_8chains/node394_2_1.txt 88"
    "./result_8chains/node394_3_1.txt 87"
    "./result_8chains/node394_4_1.txt 86"
    "./result_8chains/node394_5_1.txt 85"
    "./result_8chains/node394_6_1.txt 84"
    "./result_8chains/node394_7_1.txt 83"
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
