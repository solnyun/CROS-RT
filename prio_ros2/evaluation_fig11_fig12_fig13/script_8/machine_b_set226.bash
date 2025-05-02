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
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_1 -p 50 -st topic226_0_0 -pt topic226_0_1 -u 0.01628017301340201 > ./result_8chains/node226_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_1 -p 185 -st topic226_1_0 -pt topic226_1_1 -u 0.009977187725944026 > ./result_8chains/node226_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_1 -p 452 -st topic226_2_0 -pt topic226_2_1 -u 0.00015314091587204093 > ./result_8chains/node226_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_1 -p 499 -st topic226_3_0 -pt topic226_3_1 -u 0.016917656345566023 > ./result_8chains/node226_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_1 -p 596 -st topic226_4_0 -pt topic226_4_1 -u 0.01869448169592372 > ./result_8chains/node226_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_1 -p 688 -st topic226_5_0 -pt topic226_5_1 -u 0.026862606923236637 > ./result_8chains/node226_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_6_1 -p 710 -st topic226_6_0 -pt topic226_6_1 -u 0.054137808574279994 > ./result_8chains/node226_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_7_1 -p 816 -st topic226_7_0 -pt topic226_7_1 -u 0.007617655555973685 > ./result_8chains/node226_7_1.txt &
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
    "./result_8chains/node226_0_1.txt 90"
    "./result_8chains/node226_1_1.txt 89"
    "./result_8chains/node226_2_1.txt 88"
    "./result_8chains/node226_3_1.txt 87"
    "./result_8chains/node226_4_1.txt 86"
    "./result_8chains/node226_5_1.txt 85"
    "./result_8chains/node226_6_1.txt 84"
    "./result_8chains/node226_7_1.txt 83"
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
