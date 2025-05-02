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
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_1 -p 116 -st topic350_0_0 -pt topic350_0_1 -u 0.0020320837253912094 > ./result_10chains/node350_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_1 -p 222 -st topic350_1_0 -pt topic350_1_1 -u 0.005311346561026109 > ./result_10chains/node350_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_1 -p 285 -st topic350_2_0 -pt topic350_2_1 -u 0.0640300861052252 > ./result_10chains/node350_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_1 -p 423 -st topic350_3_0 -pt topic350_3_1 -u 0.012111288021667443 > ./result_10chains/node350_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_1 -p 450 -st topic350_4_0 -pt topic350_4_1 -u 0.003400322206266876 > ./result_10chains/node350_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_1 -p 579 -st topic350_5_0 -pt topic350_5_1 -u 0.012238058108252625 > ./result_10chains/node350_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_6_1 -p 599 -st topic350_6_0 -pt topic350_6_1 -u 0.007989333145711847 > ./result_10chains/node350_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_7_1 -p 719 -st topic350_7_0 -pt topic350_7_1 -u 0.030396502275432585 > ./result_10chains/node350_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_8_1 -p 785 -st topic350_8_0 -pt topic350_8_1 -u 0.024514219093913617 > ./result_10chains/node350_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_9_1 -p 979 -st topic350_9_0 -pt topic350_9_1 -u 0.007727427147695377 > ./result_10chains/node350_9_1.txt &
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
    "./result_10chains/node350_0_1.txt 90"
    "./result_10chains/node350_1_1.txt 89"
    "./result_10chains/node350_2_1.txt 88"
    "./result_10chains/node350_3_1.txt 87"
    "./result_10chains/node350_4_1.txt 86"
    "./result_10chains/node350_5_1.txt 85"
    "./result_10chains/node350_6_1.txt 84"
    "./result_10chains/node350_7_1.txt 83"
    "./result_10chains/node350_8_1.txt 82"
    "./result_10chains/node350_9_1.txt 81"
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
