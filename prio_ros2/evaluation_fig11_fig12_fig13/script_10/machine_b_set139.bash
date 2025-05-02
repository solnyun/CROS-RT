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
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_1 -p 93 -st topic139_0_0 -pt topic139_0_1 -u 0.004440029211654428 > ./result_10chains/node139_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_1 -p 138 -st topic139_1_0 -pt topic139_1_1 -u 0.0062637423403847925 > ./result_10chains/node139_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_1 -p 173 -st topic139_2_0 -pt topic139_2_1 -u 0.00559922426778825 > ./result_10chains/node139_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_1 -p 416 -st topic139_3_0 -pt topic139_3_1 -u 0.055524185312751606 > ./result_10chains/node139_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_1 -p 486 -st topic139_4_0 -pt topic139_4_1 -u 0.020710964196026027 > ./result_10chains/node139_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_1 -p 560 -st topic139_5_0 -pt topic139_5_1 -u 0.09403531353801547 > ./result_10chains/node139_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_6_1 -p 582 -st topic139_6_0 -pt topic139_6_1 -u 0.007304685602648367 > ./result_10chains/node139_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_7_1 -p 739 -st topic139_7_0 -pt topic139_7_1 -u 0.006715927916499054 > ./result_10chains/node139_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_8_1 -p 905 -st topic139_8_0 -pt topic139_8_1 -u 0.01789059833384009 > ./result_10chains/node139_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_9_1 -p 916 -st topic139_9_0 -pt topic139_9_1 -u 0.011694546160341799 > ./result_10chains/node139_9_1.txt &
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
    "./result_10chains/node139_0_1.txt 90"
    "./result_10chains/node139_1_1.txt 89"
    "./result_10chains/node139_2_1.txt 88"
    "./result_10chains/node139_3_1.txt 87"
    "./result_10chains/node139_4_1.txt 86"
    "./result_10chains/node139_5_1.txt 85"
    "./result_10chains/node139_6_1.txt 84"
    "./result_10chains/node139_7_1.txt 83"
    "./result_10chains/node139_8_1.txt 82"
    "./result_10chains/node139_9_1.txt 81"
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
