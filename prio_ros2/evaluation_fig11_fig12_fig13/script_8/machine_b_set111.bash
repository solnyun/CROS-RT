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
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_1 -p 286 -st topic111_0_0 -pt topic111_0_1 -u 0.1317363832328735 > ./result_8chains/node111_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_1 -p 365 -st topic111_1_0 -pt topic111_1_1 -u 0.06626288148957588 > ./result_8chains/node111_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_1 -p 418 -st topic111_2_0 -pt topic111_2_1 -u 0.009028619116041664 > ./result_8chains/node111_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_1 -p 582 -st topic111_3_0 -pt topic111_3_1 -u 0.01830683130415242 > ./result_8chains/node111_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_1 -p 711 -st topic111_4_0 -pt topic111_4_1 -u 0.005355463658497178 > ./result_8chains/node111_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_1 -p 774 -st topic111_5_0 -pt topic111_5_1 -u 0.018400295491645416 > ./result_8chains/node111_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_6_1 -p 810 -st topic111_6_0 -pt topic111_6_1 -u 0.012831111316598712 > ./result_8chains/node111_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_7_1 -p 966 -st topic111_7_0 -pt topic111_7_1 -u 6.958787017619442e-05 > ./result_8chains/node111_7_1.txt &
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
    "./result_8chains/node111_0_1.txt 90"
    "./result_8chains/node111_1_1.txt 89"
    "./result_8chains/node111_2_1.txt 88"
    "./result_8chains/node111_3_1.txt 87"
    "./result_8chains/node111_4_1.txt 86"
    "./result_8chains/node111_5_1.txt 85"
    "./result_8chains/node111_6_1.txt 84"
    "./result_8chains/node111_7_1.txt 83"
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
