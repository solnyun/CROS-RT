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
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_1 -p 98 -st topic137_0_0 -pt topic137_0_1 -u 0.011377113292046936 > ./result_8chains/node137_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_1 -p 191 -st topic137_1_0 -pt topic137_1_1 -u 0.011241694218482978 > ./result_8chains/node137_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_1 -p 219 -st topic137_2_0 -pt topic137_2_1 -u 0.06384566222806254 > ./result_8chains/node137_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_1 -p 307 -st topic137_3_0 -pt topic137_3_1 -u 0.011904648336603763 > ./result_8chains/node137_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_1 -p 381 -st topic137_4_0 -pt topic137_4_1 -u 0.02769730538281312 > ./result_8chains/node137_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_1 -p 609 -st topic137_5_0 -pt topic137_5_1 -u 0.02982381549893426 > ./result_8chains/node137_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_6_1 -p 610 -st topic137_6_0 -pt topic137_6_1 -u 0.008760823422326772 > ./result_8chains/node137_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_7_1 -p 833 -st topic137_7_0 -pt topic137_7_1 -u 0.018015716775845275 > ./result_8chains/node137_7_1.txt &
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
    "./result_8chains/node137_0_1.txt 90"
    "./result_8chains/node137_1_1.txt 89"
    "./result_8chains/node137_2_1.txt 88"
    "./result_8chains/node137_3_1.txt 87"
    "./result_8chains/node137_4_1.txt 86"
    "./result_8chains/node137_5_1.txt 85"
    "./result_8chains/node137_6_1.txt 84"
    "./result_8chains/node137_7_1.txt 83"
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
