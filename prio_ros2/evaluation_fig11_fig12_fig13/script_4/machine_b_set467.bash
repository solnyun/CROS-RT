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
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_1 -p 181 -st topic467_0_0 -pt topic467_0_1 -u 0.07176179051124854 > ./result_4chains/node467_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_1 -p 423 -st topic467_1_0 -pt topic467_1_1 -u 0.08242761621012351 > ./result_4chains/node467_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_1 -p 815 -st topic467_2_0 -pt topic467_2_1 -u 0.05276055138269656 > ./result_4chains/node467_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_1 -p 916 -st topic467_3_0 -pt topic467_3_1 -u 0.0084289726499467 > ./result_4chains/node467_3_1.txt &
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
    "./result_4chains/node467_0_1.txt 90"
    "./result_4chains/node467_1_1.txt 89"
    "./result_4chains/node467_2_1.txt 88"
    "./result_4chains/node467_3_1.txt 87"
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
