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
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_1 -p 461 -st topic328_0_0 -pt topic328_0_1 -u 0.026393503831234788 > ./result_8chains/node328_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_1 -p 477 -st topic328_1_0 -pt topic328_1_1 -u 0.011423238606961095 > ./result_8chains/node328_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_1 -p 562 -st topic328_2_0 -pt topic328_2_1 -u 0.011220595850694237 > ./result_8chains/node328_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_1 -p 647 -st topic328_3_0 -pt topic328_3_1 -u 0.040713246825014704 > ./result_8chains/node328_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_1 -p 689 -st topic328_4_0 -pt topic328_4_1 -u 0.02387098671943083 > ./result_8chains/node328_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_1 -p 699 -st topic328_5_0 -pt topic328_5_1 -u 0.04557888014522364 > ./result_8chains/node328_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_6_1 -p 720 -st topic328_6_0 -pt topic328_6_1 -u 0.009191183473262865 > ./result_8chains/node328_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_7_1 -p 949 -st topic328_7_0 -pt topic328_7_1 -u 0.010321970149303472 > ./result_8chains/node328_7_1.txt &
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
    "./result_8chains/node328_0_1.txt 90"
    "./result_8chains/node328_1_1.txt 89"
    "./result_8chains/node328_2_1.txt 88"
    "./result_8chains/node328_3_1.txt 87"
    "./result_8chains/node328_4_1.txt 86"
    "./result_8chains/node328_5_1.txt 85"
    "./result_8chains/node328_6_1.txt 84"
    "./result_8chains/node328_7_1.txt 83"
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
