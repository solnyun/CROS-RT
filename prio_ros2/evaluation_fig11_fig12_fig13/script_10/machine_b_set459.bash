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
ros2 run evaluation_3_randomdag uunifast_node -n node459_0_1 -p 161 -st topic459_0_0 -pt topic459_0_1 -u 0.007058516697611539 > ./result_10chains/node459_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_1_1 -p 266 -st topic459_1_0 -pt topic459_1_1 -u 0.004225377218903537 > ./result_10chains/node459_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_2_1 -p 329 -st topic459_2_0 -pt topic459_2_1 -u 0.00902625646103844 > ./result_10chains/node459_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_3_1 -p 464 -st topic459_3_0 -pt topic459_3_1 -u 0.01338015543704435 > ./result_10chains/node459_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_4_1 -p 465 -st topic459_4_0 -pt topic459_4_1 -u 0.0602975038097546 > ./result_10chains/node459_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_5_1 -p 500 -st topic459_5_0 -pt topic459_5_1 -u 0.004561087619760623 > ./result_10chains/node459_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_6_1 -p 512 -st topic459_6_0 -pt topic459_6_1 -u 0.01209476916328378 > ./result_10chains/node459_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_7_1 -p 766 -st topic459_7_0 -pt topic459_7_1 -u 0.008083887233322054 > ./result_10chains/node459_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_8_1 -p 915 -st topic459_8_0 -pt topic459_8_1 -u 0.020255264039777197 > ./result_10chains/node459_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node459_9_1 -p 978 -st topic459_9_0 -pt topic459_9_1 -u 0.009527364505037734 > ./result_10chains/node459_9_1.txt &
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
    "./result_10chains/node459_0_1.txt 90"
    "./result_10chains/node459_1_1.txt 89"
    "./result_10chains/node459_2_1.txt 88"
    "./result_10chains/node459_3_1.txt 87"
    "./result_10chains/node459_4_1.txt 86"
    "./result_10chains/node459_5_1.txt 85"
    "./result_10chains/node459_6_1.txt 84"
    "./result_10chains/node459_7_1.txt 83"
    "./result_10chains/node459_8_1.txt 82"
    "./result_10chains/node459_9_1.txt 81"
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
