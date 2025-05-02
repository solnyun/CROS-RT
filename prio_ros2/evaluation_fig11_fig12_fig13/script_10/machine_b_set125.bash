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
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_1 -p 246 -st topic125_0_0 -pt topic125_0_1 -u 0.005620715050903113 > ./result_10chains/node125_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_1 -p 279 -st topic125_1_0 -pt topic125_1_1 -u 0.009122186217989992 > ./result_10chains/node125_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_1 -p 290 -st topic125_2_0 -pt topic125_2_1 -u 0.00537934946770624 > ./result_10chains/node125_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_1 -p 358 -st topic125_3_0 -pt topic125_3_1 -u 0.009025419702814064 > ./result_10chains/node125_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_1 -p 370 -st topic125_4_0 -pt topic125_4_1 -u 0.017508804465935557 > ./result_10chains/node125_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_1 -p 436 -st topic125_5_0 -pt topic125_5_1 -u 0.004617732450860834 > ./result_10chains/node125_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_6_1 -p 467 -st topic125_6_0 -pt topic125_6_1 -u 0.002559819663905477 > ./result_10chains/node125_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_7_1 -p 493 -st topic125_7_0 -pt topic125_7_1 -u 0.014669669365579424 > ./result_10chains/node125_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_8_1 -p 500 -st topic125_8_0 -pt topic125_8_1 -u 0.04839690028883957 > ./result_10chains/node125_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_9_1 -p 943 -st topic125_9_0 -pt topic125_9_1 -u 0.0003034532499122547 > ./result_10chains/node125_9_1.txt &
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
    "./result_10chains/node125_0_1.txt 90"
    "./result_10chains/node125_1_1.txt 89"
    "./result_10chains/node125_2_1.txt 88"
    "./result_10chains/node125_3_1.txt 87"
    "./result_10chains/node125_4_1.txt 86"
    "./result_10chains/node125_5_1.txt 85"
    "./result_10chains/node125_6_1.txt 84"
    "./result_10chains/node125_7_1.txt 83"
    "./result_10chains/node125_8_1.txt 82"
    "./result_10chains/node125_9_1.txt 81"
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
