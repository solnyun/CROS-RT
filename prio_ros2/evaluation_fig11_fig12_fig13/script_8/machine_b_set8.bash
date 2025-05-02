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
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_1 -p 61 -st topic8_0_0 -pt topic8_0_1 -u 0.008835271437278913 > ./result_8chains/node8_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_1 -p 457 -st topic8_1_0 -pt topic8_1_1 -u 0.040317364228748154 > ./result_8chains/node8_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_1 -p 683 -st topic8_2_0 -pt topic8_2_1 -u 0.009661706412877447 > ./result_8chains/node8_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_1 -p 764 -st topic8_3_0 -pt topic8_3_1 -u 0.010181563438317276 > ./result_8chains/node8_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_1 -p 852 -st topic8_4_0 -pt topic8_4_1 -u 0.04108672123149537 > ./result_8chains/node8_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_1 -p 864 -st topic8_5_0 -pt topic8_5_1 -u 0.005705916581622755 > ./result_8chains/node8_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_6_1 -p 900 -st topic8_6_0 -pt topic8_6_1 -u 0.021529304702659957 > ./result_8chains/node8_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node8_7_1 -p 961 -st topic8_7_0 -pt topic8_7_1 -u 0.007697020018605394 > ./result_8chains/node8_7_1.txt &
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
    "./result_8chains/node8_0_1.txt 90"
    "./result_8chains/node8_1_1.txt 89"
    "./result_8chains/node8_2_1.txt 88"
    "./result_8chains/node8_3_1.txt 87"
    "./result_8chains/node8_4_1.txt 86"
    "./result_8chains/node8_5_1.txt 85"
    "./result_8chains/node8_6_1.txt 84"
    "./result_8chains/node8_7_1.txt 83"
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
