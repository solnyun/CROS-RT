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
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_1 -p 120 -st topic64_0_0 -pt topic64_0_1 -u 0.0019425965632572373 > ./result_8chains/node64_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_1 -p 162 -st topic64_1_0 -pt topic64_1_1 -u 0.039047619350567275 > ./result_8chains/node64_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_1 -p 175 -st topic64_2_0 -pt topic64_2_1 -u 0.001790237995052013 > ./result_8chains/node64_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_1 -p 243 -st topic64_3_0 -pt topic64_3_1 -u 0.007676424804334614 > ./result_8chains/node64_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_1 -p 302 -st topic64_4_0 -pt topic64_4_1 -u 0.05392706625624763 > ./result_8chains/node64_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_1 -p 318 -st topic64_5_0 -pt topic64_5_1 -u 0.0064851769219003985 > ./result_8chains/node64_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_6_1 -p 487 -st topic64_6_0 -pt topic64_6_1 -u 0.024514065840727822 > ./result_8chains/node64_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_7_1 -p 671 -st topic64_7_0 -pt topic64_7_1 -u 0.020726652741523733 > ./result_8chains/node64_7_1.txt &
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
    "./result_8chains/node64_0_1.txt 90"
    "./result_8chains/node64_1_1.txt 89"
    "./result_8chains/node64_2_1.txt 88"
    "./result_8chains/node64_3_1.txt 87"
    "./result_8chains/node64_4_1.txt 86"
    "./result_8chains/node64_5_1.txt 85"
    "./result_8chains/node64_6_1.txt 84"
    "./result_8chains/node64_7_1.txt 83"
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
