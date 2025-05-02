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
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_1 -p 33 -st topic314_0_0 -pt topic314_0_1 -u 0.0034453254950159162 > ./result_8chains/node314_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_1 -p 128 -st topic314_1_0 -pt topic314_1_1 -u 0.022278427409267 > ./result_8chains/node314_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_1 -p 257 -st topic314_2_0 -pt topic314_2_1 -u 0.012626696274227689 > ./result_8chains/node314_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_1 -p 578 -st topic314_3_0 -pt topic314_3_1 -u 0.006337701922154715 > ./result_8chains/node314_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_1 -p 662 -st topic314_4_0 -pt topic314_4_1 -u 0.015296241042012548 > ./result_8chains/node314_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_1 -p 775 -st topic314_5_0 -pt topic314_5_1 -u 0.004803697115405792 > ./result_8chains/node314_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_6_1 -p 808 -st topic314_6_0 -pt topic314_6_1 -u 0.06701425294145993 > ./result_8chains/node314_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_7_1 -p 921 -st topic314_7_0 -pt topic314_7_1 -u 0.0027031617844511246 > ./result_8chains/node314_7_1.txt &
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
    "./result_8chains/node314_0_1.txt 90"
    "./result_8chains/node314_1_1.txt 89"
    "./result_8chains/node314_2_1.txt 88"
    "./result_8chains/node314_3_1.txt 87"
    "./result_8chains/node314_4_1.txt 86"
    "./result_8chains/node314_5_1.txt 85"
    "./result_8chains/node314_6_1.txt 84"
    "./result_8chains/node314_7_1.txt 83"
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
