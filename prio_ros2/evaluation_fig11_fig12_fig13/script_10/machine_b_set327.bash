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
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_1 -p 73 -st topic327_0_0 -pt topic327_0_1 -u 0.02529920887343101 > ./result_10chains/node327_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_1 -p 147 -st topic327_1_0 -pt topic327_1_1 -u 0.014236158145042921 > ./result_10chains/node327_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_1 -p 221 -st topic327_2_0 -pt topic327_2_1 -u 0.013559438246821709 > ./result_10chains/node327_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_1 -p 236 -st topic327_3_0 -pt topic327_3_1 -u 0.003570439587171237 > ./result_10chains/node327_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_1 -p 361 -st topic327_4_0 -pt topic327_4_1 -u 0.01155403406605457 > ./result_10chains/node327_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_1 -p 422 -st topic327_5_0 -pt topic327_5_1 -u 0.008754589761482107 > ./result_10chains/node327_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_6_1 -p 436 -st topic327_6_0 -pt topic327_6_1 -u 0.01833775133314347 > ./result_10chains/node327_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_7_1 -p 572 -st topic327_7_0 -pt topic327_7_1 -u 0.04100399010813553 > ./result_10chains/node327_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_8_1 -p 707 -st topic327_8_0 -pt topic327_8_1 -u 0.007336545877120036 > ./result_10chains/node327_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_9_1 -p 711 -st topic327_9_0 -pt topic327_9_1 -u 0.01843968328393624 > ./result_10chains/node327_9_1.txt &
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
    "./result_10chains/node327_0_1.txt 90"
    "./result_10chains/node327_1_1.txt 89"
    "./result_10chains/node327_2_1.txt 88"
    "./result_10chains/node327_3_1.txt 87"
    "./result_10chains/node327_4_1.txt 86"
    "./result_10chains/node327_5_1.txt 85"
    "./result_10chains/node327_6_1.txt 84"
    "./result_10chains/node327_7_1.txt 83"
    "./result_10chains/node327_8_1.txt 82"
    "./result_10chains/node327_9_1.txt 81"
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
