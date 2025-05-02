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
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_1 -p 123 -st topic104_0_0 -pt topic104_0_1 -u 0.014923012334350338 > ./result_8chains/node104_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_1 -p 365 -st topic104_1_0 -pt topic104_1_1 -u 0.012002033522380495 > ./result_8chains/node104_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_1 -p 367 -st topic104_2_0 -pt topic104_2_1 -u 0.02773594112391975 > ./result_8chains/node104_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_1 -p 449 -st topic104_3_0 -pt topic104_3_1 -u 0.0016375861001203806 > ./result_8chains/node104_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_1 -p 510 -st topic104_4_0 -pt topic104_4_1 -u 0.004425527594869194 > ./result_8chains/node104_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_1 -p 582 -st topic104_5_0 -pt topic104_5_1 -u 0.02470193298024076 > ./result_8chains/node104_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_6_1 -p 583 -st topic104_6_0 -pt topic104_6_1 -u 0.052607402977977336 > ./result_8chains/node104_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_7_1 -p 710 -st topic104_7_0 -pt topic104_7_1 -u 0.015740656640584008 > ./result_8chains/node104_7_1.txt &
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
    "./result_8chains/node104_0_1.txt 90"
    "./result_8chains/node104_1_1.txt 89"
    "./result_8chains/node104_2_1.txt 88"
    "./result_8chains/node104_3_1.txt 87"
    "./result_8chains/node104_4_1.txt 86"
    "./result_8chains/node104_5_1.txt 85"
    "./result_8chains/node104_6_1.txt 84"
    "./result_8chains/node104_7_1.txt 83"
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
