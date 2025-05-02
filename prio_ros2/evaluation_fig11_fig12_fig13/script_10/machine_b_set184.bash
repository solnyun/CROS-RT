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
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_1 -p 87 -st topic184_0_0 -pt topic184_0_1 -u 0.0019303202675611808 > ./result_10chains/node184_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_1 -p 130 -st topic184_1_0 -pt topic184_1_1 -u 0.004551740707842367 > ./result_10chains/node184_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_1 -p 195 -st topic184_2_0 -pt topic184_2_1 -u 0.002961913647508363 > ./result_10chains/node184_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_1 -p 397 -st topic184_3_0 -pt topic184_3_1 -u 0.00021708774117057406 > ./result_10chains/node184_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_1 -p 450 -st topic184_4_0 -pt topic184_4_1 -u 0.002205288691657259 > ./result_10chains/node184_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_1 -p 517 -st topic184_5_0 -pt topic184_5_1 -u 0.0007765794499874357 > ./result_10chains/node184_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_6_1 -p 572 -st topic184_6_0 -pt topic184_6_1 -u 0.005481304156423145 > ./result_10chains/node184_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_7_1 -p 953 -st topic184_7_0 -pt topic184_7_1 -u 0.013363050699611675 > ./result_10chains/node184_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_8_1 -p 985 -st topic184_8_0 -pt topic184_8_1 -u 0.0011439319088270838 > ./result_10chains/node184_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_9_1 -p 992 -st topic184_9_0 -pt topic184_9_1 -u 0.013349192871890354 > ./result_10chains/node184_9_1.txt &
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
    "./result_10chains/node184_0_1.txt 90"
    "./result_10chains/node184_1_1.txt 89"
    "./result_10chains/node184_2_1.txt 88"
    "./result_10chains/node184_3_1.txt 87"
    "./result_10chains/node184_4_1.txt 86"
    "./result_10chains/node184_5_1.txt 85"
    "./result_10chains/node184_6_1.txt 84"
    "./result_10chains/node184_7_1.txt 83"
    "./result_10chains/node184_8_1.txt 82"
    "./result_10chains/node184_9_1.txt 81"
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
