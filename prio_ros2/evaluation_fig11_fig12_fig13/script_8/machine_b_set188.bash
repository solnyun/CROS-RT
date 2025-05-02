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
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_1 -p 127 -st topic188_0_0 -pt topic188_0_1 -u 0.029311175548335844 > ./result_8chains/node188_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_1 -p 226 -st topic188_1_0 -pt topic188_1_1 -u 0.0059505969552829385 > ./result_8chains/node188_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_1 -p 349 -st topic188_2_0 -pt topic188_2_1 -u 0.00017694152412844888 > ./result_8chains/node188_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_1 -p 367 -st topic188_3_0 -pt topic188_3_1 -u 0.0512489189242436 > ./result_8chains/node188_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_1 -p 422 -st topic188_4_0 -pt topic188_4_1 -u 0.004000377593440185 > ./result_8chains/node188_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_1 -p 613 -st topic188_5_0 -pt topic188_5_1 -u 0.05277773211659553 > ./result_8chains/node188_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_6_1 -p 635 -st topic188_6_0 -pt topic188_6_1 -u 0.02383279178230084 > ./result_8chains/node188_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_7_1 -p 759 -st topic188_7_0 -pt topic188_7_1 -u 0.024526790687201032 > ./result_8chains/node188_7_1.txt &
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
    "./result_8chains/node188_0_1.txt 90"
    "./result_8chains/node188_1_1.txt 89"
    "./result_8chains/node188_2_1.txt 88"
    "./result_8chains/node188_3_1.txt 87"
    "./result_8chains/node188_4_1.txt 86"
    "./result_8chains/node188_5_1.txt 85"
    "./result_8chains/node188_6_1.txt 84"
    "./result_8chains/node188_7_1.txt 83"
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
