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
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_1 -p 84 -st topic454_0_0 -pt topic454_0_1 -u 0.019182221248990106 > ./result_8chains/node454_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_1 -p 186 -st topic454_1_0 -pt topic454_1_1 -u 0.003103996225005734 > ./result_8chains/node454_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_1 -p 199 -st topic454_2_0 -pt topic454_2_1 -u 0.011997915300805906 > ./result_8chains/node454_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_1 -p 275 -st topic454_3_0 -pt topic454_3_1 -u 0.0016923078743648068 > ./result_8chains/node454_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_1 -p 368 -st topic454_4_0 -pt topic454_4_1 -u 0.004097624825483537 > ./result_8chains/node454_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_1 -p 455 -st topic454_5_0 -pt topic454_5_1 -u 0.01877959675683749 > ./result_8chains/node454_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_6_1 -p 730 -st topic454_6_0 -pt topic454_6_1 -u 0.02352591616603078 > ./result_8chains/node454_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_7_1 -p 772 -st topic454_7_0 -pt topic454_7_1 -u 0.028796629418005173 > ./result_8chains/node454_7_1.txt &
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
    "./result_8chains/node454_0_1.txt 90"
    "./result_8chains/node454_1_1.txt 89"
    "./result_8chains/node454_2_1.txt 88"
    "./result_8chains/node454_3_1.txt 87"
    "./result_8chains/node454_4_1.txt 86"
    "./result_8chains/node454_5_1.txt 85"
    "./result_8chains/node454_6_1.txt 84"
    "./result_8chains/node454_7_1.txt 83"
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
