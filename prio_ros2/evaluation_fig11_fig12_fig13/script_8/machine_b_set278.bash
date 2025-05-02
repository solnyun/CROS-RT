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
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_1 -p 106 -st topic278_0_0 -pt topic278_0_1 -u 0.04344869380357835 > ./result_8chains/node278_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_1 -p 291 -st topic278_1_0 -pt topic278_1_1 -u 0.010393598509751745 > ./result_8chains/node278_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_1 -p 326 -st topic278_2_0 -pt topic278_2_1 -u 0.00952967864781512 > ./result_8chains/node278_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_1 -p 405 -st topic278_3_0 -pt topic278_3_1 -u 0.00918639042363023 > ./result_8chains/node278_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_1 -p 512 -st topic278_4_0 -pt topic278_4_1 -u 0.013132862656174832 > ./result_8chains/node278_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_1 -p 595 -st topic278_5_0 -pt topic278_5_1 -u 0.003069171212286337 > ./result_8chains/node278_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_6_1 -p 971 -st topic278_6_0 -pt topic278_6_1 -u 0.005644279325189433 > ./result_8chains/node278_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_7_1 -p 999 -st topic278_7_0 -pt topic278_7_1 -u 0.011121910925957178 > ./result_8chains/node278_7_1.txt &
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
    "./result_8chains/node278_0_1.txt 90"
    "./result_8chains/node278_1_1.txt 89"
    "./result_8chains/node278_2_1.txt 88"
    "./result_8chains/node278_3_1.txt 87"
    "./result_8chains/node278_4_1.txt 86"
    "./result_8chains/node278_5_1.txt 85"
    "./result_8chains/node278_6_1.txt 84"
    "./result_8chains/node278_7_1.txt 83"
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
