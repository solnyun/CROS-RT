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
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_1 -p 96 -st topic65_0_0 -pt topic65_0_1 -u 0.0025805538412178586 > ./result_8chains/node65_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_1 -p 173 -st topic65_1_0 -pt topic65_1_1 -u 0.003920849897669776 > ./result_8chains/node65_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_1 -p 325 -st topic65_2_0 -pt topic65_2_1 -u 0.020099919322386417 > ./result_8chains/node65_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_1 -p 331 -st topic65_3_0 -pt topic65_3_1 -u 0.011979962290188384 > ./result_8chains/node65_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_1 -p 479 -st topic65_4_0 -pt topic65_4_1 -u 0.006805833756067636 > ./result_8chains/node65_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_1 -p 620 -st topic65_5_0 -pt topic65_5_1 -u 0.024426926401077187 > ./result_8chains/node65_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_6_1 -p 853 -st topic65_6_0 -pt topic65_6_1 -u 0.0052269229966603326 > ./result_8chains/node65_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_7_1 -p 942 -st topic65_7_0 -pt topic65_7_1 -u 0.030400663410108296 > ./result_8chains/node65_7_1.txt &
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
    "./result_8chains/node65_0_1.txt 90"
    "./result_8chains/node65_1_1.txt 89"
    "./result_8chains/node65_2_1.txt 88"
    "./result_8chains/node65_3_1.txt 87"
    "./result_8chains/node65_4_1.txt 86"
    "./result_8chains/node65_5_1.txt 85"
    "./result_8chains/node65_6_1.txt 84"
    "./result_8chains/node65_7_1.txt 83"
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
