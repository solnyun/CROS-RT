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
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_1 -p 160 -st topic323_0_0 -pt topic323_0_1 -u 0.0331199231490546 > ./result_8chains/node323_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_1 -p 161 -st topic323_1_0 -pt topic323_1_1 -u 0.013942234856052338 > ./result_8chains/node323_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_1 -p 270 -st topic323_2_0 -pt topic323_2_1 -u 0.019621540969066487 > ./result_8chains/node323_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_1 -p 288 -st topic323_3_0 -pt topic323_3_1 -u 0.0018016110794664142 > ./result_8chains/node323_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_1 -p 649 -st topic323_4_0 -pt topic323_4_1 -u 0.015025811733748756 > ./result_8chains/node323_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_1 -p 728 -st topic323_5_0 -pt topic323_5_1 -u 0.035880189096832965 > ./result_8chains/node323_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_6_1 -p 827 -st topic323_6_0 -pt topic323_6_1 -u 0.0050848284173496405 > ./result_8chains/node323_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_7_1 -p 988 -st topic323_7_0 -pt topic323_7_1 -u 0.03165335539645086 > ./result_8chains/node323_7_1.txt &
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
    "./result_8chains/node323_0_1.txt 90"
    "./result_8chains/node323_1_1.txt 89"
    "./result_8chains/node323_2_1.txt 88"
    "./result_8chains/node323_3_1.txt 87"
    "./result_8chains/node323_4_1.txt 86"
    "./result_8chains/node323_5_1.txt 85"
    "./result_8chains/node323_6_1.txt 84"
    "./result_8chains/node323_7_1.txt 83"
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
