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
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_1 -p 279 -st topic368_0_0 -pt topic368_0_1 -u 0.08983795158926255 > ./result_6chains/node368_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_1 -p 392 -st topic368_1_0 -pt topic368_1_1 -u 0.034799164778437586 > ./result_6chains/node368_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_1 -p 400 -st topic368_2_0 -pt topic368_2_1 -u 0.008260590857830041 > ./result_6chains/node368_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_1 -p 543 -st topic368_3_0 -pt topic368_3_1 -u 3.331667711112263e-05 > ./result_6chains/node368_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_1 -p 580 -st topic368_4_0 -pt topic368_4_1 -u 0.008262814024495968 > ./result_6chains/node368_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_1 -p 999 -st topic368_5_0 -pt topic368_5_1 -u 0.03311970301123712 > ./result_6chains/node368_5_1.txt &
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
    "./result_6chains/node368_0_1.txt 90"
    "./result_6chains/node368_1_1.txt 89"
    "./result_6chains/node368_2_1.txt 88"
    "./result_6chains/node368_3_1.txt 87"
    "./result_6chains/node368_4_1.txt 86"
    "./result_6chains/node368_5_1.txt 85"
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
