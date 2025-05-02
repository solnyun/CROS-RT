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
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_1 -p 37 -st topic395_0_0 -pt topic395_0_1 -u 0.012044390950010808 > ./result_8chains/node395_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_1 -p 469 -st topic395_1_0 -pt topic395_1_1 -u 0.009277128321771855 > ./result_8chains/node395_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_1 -p 505 -st topic395_2_0 -pt topic395_2_1 -u 0.07291218979282477 > ./result_8chains/node395_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_1 -p 602 -st topic395_3_0 -pt topic395_3_1 -u 0.09070334064524227 > ./result_8chains/node395_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_1 -p 657 -st topic395_4_0 -pt topic395_4_1 -u 0.00021954224587741877 > ./result_8chains/node395_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_1 -p 681 -st topic395_5_0 -pt topic395_5_1 -u 0.0007080011735492719 > ./result_8chains/node395_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_6_1 -p 880 -st topic395_6_0 -pt topic395_6_1 -u 0.057939345737021045 > ./result_8chains/node395_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_7_1 -p 908 -st topic395_7_0 -pt topic395_7_1 -u 0.010686890565563274 > ./result_8chains/node395_7_1.txt &
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
    "./result_8chains/node395_0_1.txt 90"
    "./result_8chains/node395_1_1.txt 89"
    "./result_8chains/node395_2_1.txt 88"
    "./result_8chains/node395_3_1.txt 87"
    "./result_8chains/node395_4_1.txt 86"
    "./result_8chains/node395_5_1.txt 85"
    "./result_8chains/node395_6_1.txt 84"
    "./result_8chains/node395_7_1.txt 83"
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
