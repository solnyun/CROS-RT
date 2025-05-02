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
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_1 -p 51 -st topic416_0_0 -pt topic416_0_1 -u 0.094815420551979 > ./result_4chains/node416_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_1 -p 681 -st topic416_1_0 -pt topic416_1_1 -u 0.0071375775766521765 > ./result_4chains/node416_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_1 -p 782 -st topic416_2_0 -pt topic416_2_1 -u 0.017799735200173514 > ./result_4chains/node416_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_1 -p 850 -st topic416_3_0 -pt topic416_3_1 -u 0.0068173977711474786 > ./result_4chains/node416_3_1.txt &
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
    "./result_4chains/node416_0_1.txt 90"
    "./result_4chains/node416_1_1.txt 89"
    "./result_4chains/node416_2_1.txt 88"
    "./result_4chains/node416_3_1.txt 87"
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
