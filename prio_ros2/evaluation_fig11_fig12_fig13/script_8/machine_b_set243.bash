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
ros2 run evaluation_3_randomdag uunifast_node -n node243_0_1 -p 252 -st topic243_0_0 -pt topic243_0_1 -u 0.014941454336226068 > ./result_8chains/node243_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_1_1 -p 431 -st topic243_1_0 -pt topic243_1_1 -u 0.005193860882194035 > ./result_8chains/node243_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_2_1 -p 447 -st topic243_2_0 -pt topic243_2_1 -u 0.010227351665760775 > ./result_8chains/node243_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_3_1 -p 462 -st topic243_3_0 -pt topic243_3_1 -u 0.010907772231362411 > ./result_8chains/node243_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_4_1 -p 481 -st topic243_4_0 -pt topic243_4_1 -u 0.03214729668686467 > ./result_8chains/node243_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_5_1 -p 522 -st topic243_5_0 -pt topic243_5_1 -u 0.010057108152992655 > ./result_8chains/node243_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_6_1 -p 687 -st topic243_6_0 -pt topic243_6_1 -u 0.024152036369759766 > ./result_8chains/node243_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_7_1 -p 933 -st topic243_7_0 -pt topic243_7_1 -u 0.00927451648194651 > ./result_8chains/node243_7_1.txt &
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
    "./result_8chains/node243_0_1.txt 90"
    "./result_8chains/node243_1_1.txt 89"
    "./result_8chains/node243_2_1.txt 88"
    "./result_8chains/node243_3_1.txt 87"
    "./result_8chains/node243_4_1.txt 86"
    "./result_8chains/node243_5_1.txt 85"
    "./result_8chains/node243_6_1.txt 84"
    "./result_8chains/node243_7_1.txt 83"
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
