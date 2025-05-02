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
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_1 -p 205 -st topic492_0_0 -pt topic492_0_1 -u 0.020482849268132097 > ./result_8chains/node492_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_1 -p 341 -st topic492_1_0 -pt topic492_1_1 -u 0.01786603839156714 > ./result_8chains/node492_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_1 -p 495 -st topic492_2_0 -pt topic492_2_1 -u 0.02377861096961381 > ./result_8chains/node492_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_1 -p 647 -st topic492_3_0 -pt topic492_3_1 -u 0.004174296231220731 > ./result_8chains/node492_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_1 -p 699 -st topic492_4_0 -pt topic492_4_1 -u 0.04223572383898097 > ./result_8chains/node492_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_1 -p 705 -st topic492_5_0 -pt topic492_5_1 -u 0.025711937689268022 > ./result_8chains/node492_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_6_1 -p 710 -st topic492_6_0 -pt topic492_6_1 -u 0.0009700439695750768 > ./result_8chains/node492_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_7_1 -p 743 -st topic492_7_0 -pt topic492_7_1 -u 0.019150171689965058 > ./result_8chains/node492_7_1.txt &
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
    "./result_8chains/node492_0_1.txt 90"
    "./result_8chains/node492_1_1.txt 89"
    "./result_8chains/node492_2_1.txt 88"
    "./result_8chains/node492_3_1.txt 87"
    "./result_8chains/node492_4_1.txt 86"
    "./result_8chains/node492_5_1.txt 85"
    "./result_8chains/node492_6_1.txt 84"
    "./result_8chains/node492_7_1.txt 83"
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
