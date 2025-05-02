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
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_1 -p 74 -st topic37_0_0 -pt topic37_0_1 -u 0.025588317184292997 > ./result_8chains/node37_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_1 -p 350 -st topic37_1_0 -pt topic37_1_1 -u 0.014499755566211137 > ./result_8chains/node37_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_1 -p 461 -st topic37_2_0 -pt topic37_2_1 -u 0.00830758457393721 > ./result_8chains/node37_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_1 -p 758 -st topic37_3_0 -pt topic37_3_1 -u 0.0036044106876216286 > ./result_8chains/node37_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_1 -p 828 -st topic37_4_0 -pt topic37_4_1 -u 0.011216361396953534 > ./result_8chains/node37_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_1 -p 835 -st topic37_5_0 -pt topic37_5_1 -u 0.009597950885594897 > ./result_8chains/node37_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_6_1 -p 948 -st topic37_6_0 -pt topic37_6_1 -u 0.06911553458566712 > ./result_8chains/node37_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_7_1 -p 991 -st topic37_7_0 -pt topic37_7_1 -u 0.011570571769280932 > ./result_8chains/node37_7_1.txt &
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
    "./result_8chains/node37_0_1.txt 90"
    "./result_8chains/node37_1_1.txt 89"
    "./result_8chains/node37_2_1.txt 88"
    "./result_8chains/node37_3_1.txt 87"
    "./result_8chains/node37_4_1.txt 86"
    "./result_8chains/node37_5_1.txt 85"
    "./result_8chains/node37_6_1.txt 84"
    "./result_8chains/node37_7_1.txt 83"
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
