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
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_1 -p 205 -st topic81_0_0 -pt topic81_0_1 -u 0.00887428049750183 > ./result_8chains/node81_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_1 -p 207 -st topic81_1_0 -pt topic81_1_1 -u 0.01399322381498963 > ./result_8chains/node81_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_1 -p 352 -st topic81_2_0 -pt topic81_2_1 -u 0.013433645850540188 > ./result_8chains/node81_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_1 -p 501 -st topic81_3_0 -pt topic81_3_1 -u 0.002229402422495752 > ./result_8chains/node81_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_1 -p 816 -st topic81_4_0 -pt topic81_4_1 -u 0.007201704937208259 > ./result_8chains/node81_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_1 -p 861 -st topic81_5_0 -pt topic81_5_1 -u 0.014257228629376728 > ./result_8chains/node81_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_6_1 -p 867 -st topic81_6_0 -pt topic81_6_1 -u 0.0035161544645666842 > ./result_8chains/node81_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_7_1 -p 988 -st topic81_7_0 -pt topic81_7_1 -u 0.04310774659032976 > ./result_8chains/node81_7_1.txt &
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
    "./result_8chains/node81_0_1.txt 90"
    "./result_8chains/node81_1_1.txt 89"
    "./result_8chains/node81_2_1.txt 88"
    "./result_8chains/node81_3_1.txt 87"
    "./result_8chains/node81_4_1.txt 86"
    "./result_8chains/node81_5_1.txt 85"
    "./result_8chains/node81_6_1.txt 84"
    "./result_8chains/node81_7_1.txt 83"
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
