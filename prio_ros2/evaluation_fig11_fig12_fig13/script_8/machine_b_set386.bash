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
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_1 -p 32 -st topic386_0_0 -pt topic386_0_1 -u 0.0028070576626166854 > ./result_8chains/node386_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_1 -p 115 -st topic386_1_0 -pt topic386_1_1 -u 0.00851146500011335 > ./result_8chains/node386_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_1 -p 213 -st topic386_2_0 -pt topic386_2_1 -u 0.023202238838881728 > ./result_8chains/node386_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_1 -p 235 -st topic386_3_0 -pt topic386_3_1 -u 0.020341463818816075 > ./result_8chains/node386_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_1 -p 626 -st topic386_4_0 -pt topic386_4_1 -u 0.02447039900544762 > ./result_8chains/node386_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_1 -p 699 -st topic386_5_0 -pt topic386_5_1 -u 0.021257826173282174 > ./result_8chains/node386_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_6_1 -p 806 -st topic386_6_0 -pt topic386_6_1 -u 0.02871126621884501 > ./result_8chains/node386_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_7_1 -p 933 -st topic386_7_0 -pt topic386_7_1 -u 0.01400377301092285 > ./result_8chains/node386_7_1.txt &
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
    "./result_8chains/node386_0_1.txt 90"
    "./result_8chains/node386_1_1.txt 89"
    "./result_8chains/node386_2_1.txt 88"
    "./result_8chains/node386_3_1.txt 87"
    "./result_8chains/node386_4_1.txt 86"
    "./result_8chains/node386_5_1.txt 85"
    "./result_8chains/node386_6_1.txt 84"
    "./result_8chains/node386_7_1.txt 83"
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
