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
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_1 -p 85 -st topic208_0_0 -pt topic208_0_1 -u 0.02485818701010173 > ./result_8chains/node208_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_1 -p 463 -st topic208_1_0 -pt topic208_1_1 -u 0.028101331035929322 > ./result_8chains/node208_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_1 -p 466 -st topic208_2_0 -pt topic208_2_1 -u 0.014640450344173384 > ./result_8chains/node208_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_1 -p 630 -st topic208_3_0 -pt topic208_3_1 -u 0.0033254840418797116 > ./result_8chains/node208_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_4_1 -p 688 -st topic208_4_0 -pt topic208_4_1 -u 0.06189802177796125 > ./result_8chains/node208_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_5_1 -p 794 -st topic208_5_0 -pt topic208_5_1 -u 0.009261204179822957 > ./result_8chains/node208_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_6_1 -p 894 -st topic208_6_0 -pt topic208_6_1 -u 0.008381004979525958 > ./result_8chains/node208_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_7_1 -p 910 -st topic208_7_0 -pt topic208_7_1 -u 0.01584343611139927 > ./result_8chains/node208_7_1.txt &
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
    "./result_8chains/node208_0_1.txt 90"
    "./result_8chains/node208_1_1.txt 89"
    "./result_8chains/node208_2_1.txt 88"
    "./result_8chains/node208_3_1.txt 87"
    "./result_8chains/node208_4_1.txt 86"
    "./result_8chains/node208_5_1.txt 85"
    "./result_8chains/node208_6_1.txt 84"
    "./result_8chains/node208_7_1.txt 83"
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
