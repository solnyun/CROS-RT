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
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_1 -p 57 -st topic449_0_0 -pt topic449_0_1 -u 0.054831345115377905 > ./result_8chains/node449_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_1 -p 391 -st topic449_1_0 -pt topic449_1_1 -u 0.007868427079398832 > ./result_8chains/node449_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_1 -p 464 -st topic449_2_0 -pt topic449_2_1 -u 0.05380121845814534 > ./result_8chains/node449_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_1 -p 646 -st topic449_3_0 -pt topic449_3_1 -u 0.00015861708833686539 > ./result_8chains/node449_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_1 -p 692 -st topic449_4_0 -pt topic449_4_1 -u 0.022465233878534496 > ./result_8chains/node449_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_1 -p 837 -st topic449_5_0 -pt topic449_5_1 -u 0.0015221022129789097 > ./result_8chains/node449_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_6_1 -p 978 -st topic449_6_0 -pt topic449_6_1 -u 0.04186135924253155 > ./result_8chains/node449_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_7_1 -p 998 -st topic449_7_0 -pt topic449_7_1 -u 0.025321685287633244 > ./result_8chains/node449_7_1.txt &
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
    "./result_8chains/node449_0_1.txt 90"
    "./result_8chains/node449_1_1.txt 89"
    "./result_8chains/node449_2_1.txt 88"
    "./result_8chains/node449_3_1.txt 87"
    "./result_8chains/node449_4_1.txt 86"
    "./result_8chains/node449_5_1.txt 85"
    "./result_8chains/node449_6_1.txt 84"
    "./result_8chains/node449_7_1.txt 83"
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
