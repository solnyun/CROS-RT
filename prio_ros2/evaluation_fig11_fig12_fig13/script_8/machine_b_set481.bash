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
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_1 -p 60 -st topic481_0_0 -pt topic481_0_1 -u 0.004792340592030708 > ./result_8chains/node481_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_1 -p 471 -st topic481_1_0 -pt topic481_1_1 -u 0.010660682690851853 > ./result_8chains/node481_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_1 -p 497 -st topic481_2_0 -pt topic481_2_1 -u 0.05072224169193895 > ./result_8chains/node481_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_1 -p 630 -st topic481_3_0 -pt topic481_3_1 -u 0.007132107849354308 > ./result_8chains/node481_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_1 -p 694 -st topic481_4_0 -pt topic481_4_1 -u 0.008504270162875471 > ./result_8chains/node481_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_1 -p 699 -st topic481_5_0 -pt topic481_5_1 -u 0.015615076643835935 > ./result_8chains/node481_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_6_1 -p 755 -st topic481_6_0 -pt topic481_6_1 -u 0.00745568295660326 > ./result_8chains/node481_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_7_1 -p 878 -st topic481_7_0 -pt topic481_7_1 -u 0.05568094168364954 > ./result_8chains/node481_7_1.txt &
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
    "./result_8chains/node481_0_1.txt 90"
    "./result_8chains/node481_1_1.txt 89"
    "./result_8chains/node481_2_1.txt 88"
    "./result_8chains/node481_3_1.txt 87"
    "./result_8chains/node481_4_1.txt 86"
    "./result_8chains/node481_5_1.txt 85"
    "./result_8chains/node481_6_1.txt 84"
    "./result_8chains/node481_7_1.txt 83"
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
