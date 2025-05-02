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
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_1 -p 237 -st topic380_0_0 -pt topic380_0_1 -u 0.04311141239209376 > ./result_8chains/node380_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_1 -p 454 -st topic380_1_0 -pt topic380_1_1 -u 0.0020248459426203125 > ./result_8chains/node380_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_1 -p 455 -st topic380_2_0 -pt topic380_2_1 -u 0.003896560903227042 > ./result_8chains/node380_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_1 -p 554 -st topic380_3_0 -pt topic380_3_1 -u 0.028850431149852834 > ./result_8chains/node380_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_1 -p 653 -st topic380_4_0 -pt topic380_4_1 -u 0.007834758366561723 > ./result_8chains/node380_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_1 -p 861 -st topic380_5_0 -pt topic380_5_1 -u 0.04052494348935688 > ./result_8chains/node380_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_6_1 -p 886 -st topic380_6_0 -pt topic380_6_1 -u 0.0059278671120316165 > ./result_8chains/node380_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_7_1 -p 968 -st topic380_7_0 -pt topic380_7_1 -u 0.0034686499815535163 > ./result_8chains/node380_7_1.txt &
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
    "./result_8chains/node380_0_1.txt 90"
    "./result_8chains/node380_1_1.txt 89"
    "./result_8chains/node380_2_1.txt 88"
    "./result_8chains/node380_3_1.txt 87"
    "./result_8chains/node380_4_1.txt 86"
    "./result_8chains/node380_5_1.txt 85"
    "./result_8chains/node380_6_1.txt 84"
    "./result_8chains/node380_7_1.txt 83"
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
