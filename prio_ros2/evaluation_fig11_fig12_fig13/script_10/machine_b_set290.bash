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
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_1 -p 32 -st topic290_0_0 -pt topic290_0_1 -u 0.03837703586151098 > ./result_10chains/node290_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_1 -p 42 -st topic290_1_0 -pt topic290_1_1 -u 0.02223502465341437 > ./result_10chains/node290_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_1 -p 219 -st topic290_2_0 -pt topic290_2_1 -u 0.019607937962455302 > ./result_10chains/node290_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_1 -p 250 -st topic290_3_0 -pt topic290_3_1 -u 0.003381667460809701 > ./result_10chains/node290_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_1 -p 312 -st topic290_4_0 -pt topic290_4_1 -u 0.004572952620437942 > ./result_10chains/node290_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_1 -p 330 -st topic290_5_0 -pt topic290_5_1 -u 0.0077619376061445755 > ./result_10chains/node290_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_6_1 -p 472 -st topic290_6_0 -pt topic290_6_1 -u 0.011060951763683102 > ./result_10chains/node290_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_7_1 -p 658 -st topic290_7_0 -pt topic290_7_1 -u 0.06253837188723715 > ./result_10chains/node290_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_8_1 -p 744 -st topic290_8_0 -pt topic290_8_1 -u 0.021769463324465728 > ./result_10chains/node290_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_9_1 -p 903 -st topic290_9_0 -pt topic290_9_1 -u 0.004978604074736503 > ./result_10chains/node290_9_1.txt &
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
    "./result_10chains/node290_0_1.txt 90"
    "./result_10chains/node290_1_1.txt 89"
    "./result_10chains/node290_2_1.txt 88"
    "./result_10chains/node290_3_1.txt 87"
    "./result_10chains/node290_4_1.txt 86"
    "./result_10chains/node290_5_1.txt 85"
    "./result_10chains/node290_6_1.txt 84"
    "./result_10chains/node290_7_1.txt 83"
    "./result_10chains/node290_8_1.txt 82"
    "./result_10chains/node290_9_1.txt 81"
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
