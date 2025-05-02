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
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_1 -p 65 -st topic260_0_0 -pt topic260_0_1 -u 0.0037796245373800663 > ./result_8chains/node260_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_1 -p 168 -st topic260_1_0 -pt topic260_1_1 -u 0.015725861815938713 > ./result_8chains/node260_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_1 -p 217 -st topic260_2_0 -pt topic260_2_1 -u 0.00484944981909774 > ./result_8chains/node260_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_1 -p 692 -st topic260_3_0 -pt topic260_3_1 -u 0.001306607515228042 > ./result_8chains/node260_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_1 -p 711 -st topic260_4_0 -pt topic260_4_1 -u 0.029196211407615025 > ./result_8chains/node260_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_1 -p 750 -st topic260_5_0 -pt topic260_5_1 -u 0.05246896762510289 > ./result_8chains/node260_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_6_1 -p 761 -st topic260_6_0 -pt topic260_6_1 -u 0.03785812549056111 > ./result_8chains/node260_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_7_1 -p 914 -st topic260_7_0 -pt topic260_7_1 -u 0.00115350941511861 > ./result_8chains/node260_7_1.txt &
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
    "./result_8chains/node260_0_1.txt 90"
    "./result_8chains/node260_1_1.txt 89"
    "./result_8chains/node260_2_1.txt 88"
    "./result_8chains/node260_3_1.txt 87"
    "./result_8chains/node260_4_1.txt 86"
    "./result_8chains/node260_5_1.txt 85"
    "./result_8chains/node260_6_1.txt 84"
    "./result_8chains/node260_7_1.txt 83"
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
