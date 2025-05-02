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
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_1 -p 27 -st topic463_0_0 -pt topic463_0_1 -u 0.013783757181510314 > ./result_6chains/node463_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_1 -p 64 -st topic463_1_0 -pt topic463_1_1 -u 0.04970705320177016 > ./result_6chains/node463_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_1 -p 228 -st topic463_2_0 -pt topic463_2_1 -u 0.049274039095893174 > ./result_6chains/node463_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_1 -p 750 -st topic463_3_0 -pt topic463_3_1 -u 0.055275262921926666 > ./result_6chains/node463_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_1 -p 805 -st topic463_4_0 -pt topic463_4_1 -u 0.0012951214543109602 > ./result_6chains/node463_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_1 -p 866 -st topic463_5_0 -pt topic463_5_1 -u 0.06554663604846334 > ./result_6chains/node463_5_1.txt &
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
    "./result_6chains/node463_0_1.txt 90"
    "./result_6chains/node463_1_1.txt 89"
    "./result_6chains/node463_2_1.txt 88"
    "./result_6chains/node463_3_1.txt 87"
    "./result_6chains/node463_4_1.txt 86"
    "./result_6chains/node463_5_1.txt 85"
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
