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
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_1 -p 103 -st topic437_0_0 -pt topic437_0_1 -u 0.007121504953397861 > ./result_8chains/node437_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_1 -p 125 -st topic437_1_0 -pt topic437_1_1 -u 0.001062673988855567 > ./result_8chains/node437_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_1 -p 144 -st topic437_2_0 -pt topic437_2_1 -u 0.0281077021360695 > ./result_8chains/node437_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_1 -p 204 -st topic437_3_0 -pt topic437_3_1 -u 0.003942245736465677 > ./result_8chains/node437_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_1 -p 285 -st topic437_4_0 -pt topic437_4_1 -u 0.0023483999238373132 > ./result_8chains/node437_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_1 -p 363 -st topic437_5_0 -pt topic437_5_1 -u 0.013032773213358995 > ./result_8chains/node437_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_6_1 -p 632 -st topic437_6_0 -pt topic437_6_1 -u 0.003699763733359729 > ./result_8chains/node437_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_7_1 -p 964 -st topic437_7_0 -pt topic437_7_1 -u 0.03141748076617816 > ./result_8chains/node437_7_1.txt &
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
    "./result_8chains/node437_0_1.txt 90"
    "./result_8chains/node437_1_1.txt 89"
    "./result_8chains/node437_2_1.txt 88"
    "./result_8chains/node437_3_1.txt 87"
    "./result_8chains/node437_4_1.txt 86"
    "./result_8chains/node437_5_1.txt 85"
    "./result_8chains/node437_6_1.txt 84"
    "./result_8chains/node437_7_1.txt 83"
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
