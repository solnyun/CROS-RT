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
ros2 run evaluation_3_randomdag uunifast_node -n node87_0_1 -p 105 -st topic87_0_0 -pt topic87_0_1 -u 0.06534570993457217 > ./result_8chains/node87_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_1_1 -p 156 -st topic87_1_0 -pt topic87_1_1 -u 0.0036564184185878257 > ./result_8chains/node87_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_2_1 -p 282 -st topic87_2_0 -pt topic87_2_1 -u 0.03579634275940147 > ./result_8chains/node87_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_3_1 -p 484 -st topic87_3_0 -pt topic87_3_1 -u 5.798908843668293e-06 > ./result_8chains/node87_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_4_1 -p 523 -st topic87_4_0 -pt topic87_4_1 -u 0.018970389611534577 > ./result_8chains/node87_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_5_1 -p 571 -st topic87_5_0 -pt topic87_5_1 -u 0.010343029600735382 > ./result_8chains/node87_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_6_1 -p 593 -st topic87_6_0 -pt topic87_6_1 -u 0.0036737590484756943 > ./result_8chains/node87_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_7_1 -p 971 -st topic87_7_0 -pt topic87_7_1 -u 0.010824600019327911 > ./result_8chains/node87_7_1.txt &
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
    "./result_8chains/node87_0_1.txt 90"
    "./result_8chains/node87_1_1.txt 89"
    "./result_8chains/node87_2_1.txt 88"
    "./result_8chains/node87_3_1.txt 87"
    "./result_8chains/node87_4_1.txt 86"
    "./result_8chains/node87_5_1.txt 85"
    "./result_8chains/node87_6_1.txt 84"
    "./result_8chains/node87_7_1.txt 83"
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
