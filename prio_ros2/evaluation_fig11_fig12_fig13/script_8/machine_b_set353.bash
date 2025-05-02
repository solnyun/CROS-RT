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
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_1 -p 224 -st topic353_0_0 -pt topic353_0_1 -u 0.04354039016455363 > ./result_8chains/node353_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_1 -p 280 -st topic353_1_0 -pt topic353_1_1 -u 0.04618516862462241 > ./result_8chains/node353_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_1 -p 306 -st topic353_2_0 -pt topic353_2_1 -u 0.022109015967012036 > ./result_8chains/node353_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_1 -p 345 -st topic353_3_0 -pt topic353_3_1 -u 0.038459778972816744 > ./result_8chains/node353_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_1 -p 497 -st topic353_4_0 -pt topic353_4_1 -u 0.014361444827237446 > ./result_8chains/node353_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_1 -p 538 -st topic353_5_0 -pt topic353_5_1 -u 0.0064698497906246905 > ./result_8chains/node353_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_6_1 -p 775 -st topic353_6_0 -pt topic353_6_1 -u 0.00499092941378762 > ./result_8chains/node353_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_7_1 -p 901 -st topic353_7_0 -pt topic353_7_1 -u 0.011244824775406094 > ./result_8chains/node353_7_1.txt &
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
    "./result_8chains/node353_0_1.txt 90"
    "./result_8chains/node353_1_1.txt 89"
    "./result_8chains/node353_2_1.txt 88"
    "./result_8chains/node353_3_1.txt 87"
    "./result_8chains/node353_4_1.txt 86"
    "./result_8chains/node353_5_1.txt 85"
    "./result_8chains/node353_6_1.txt 84"
    "./result_8chains/node353_7_1.txt 83"
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
