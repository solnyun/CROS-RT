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
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_1 -p 70 -st topic345_0_0 -pt topic345_0_1 -u 0.01730644274338955 > ./result_10chains/node345_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_1 -p 440 -st topic345_1_0 -pt topic345_1_1 -u 0.0207059489847094 > ./result_10chains/node345_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_1 -p 447 -st topic345_2_0 -pt topic345_2_1 -u 0.002261142133549332 > ./result_10chains/node345_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_1 -p 583 -st topic345_3_0 -pt topic345_3_1 -u 0.005833768940866346 > ./result_10chains/node345_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_1 -p 621 -st topic345_4_0 -pt topic345_4_1 -u 0.015124108067165298 > ./result_10chains/node345_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_1 -p 694 -st topic345_5_0 -pt topic345_5_1 -u 0.018769917972108363 > ./result_10chains/node345_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_6_1 -p 783 -st topic345_6_0 -pt topic345_6_1 -u 0.012009029806062776 > ./result_10chains/node345_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_7_1 -p 814 -st topic345_7_0 -pt topic345_7_1 -u 0.007417968136590319 > ./result_10chains/node345_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_8_1 -p 844 -st topic345_8_0 -pt topic345_8_1 -u 0.011379452216181168 > ./result_10chains/node345_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_9_1 -p 890 -st topic345_9_0 -pt topic345_9_1 -u 0.01976474785539265 > ./result_10chains/node345_9_1.txt &
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
    "./result_10chains/node345_0_1.txt 90"
    "./result_10chains/node345_1_1.txt 89"
    "./result_10chains/node345_2_1.txt 88"
    "./result_10chains/node345_3_1.txt 87"
    "./result_10chains/node345_4_1.txt 86"
    "./result_10chains/node345_5_1.txt 85"
    "./result_10chains/node345_6_1.txt 84"
    "./result_10chains/node345_7_1.txt 83"
    "./result_10chains/node345_8_1.txt 82"
    "./result_10chains/node345_9_1.txt 81"
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
