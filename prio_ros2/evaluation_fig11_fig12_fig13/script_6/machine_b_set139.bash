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
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_1 -p 264 -st topic139_0_0 -pt topic139_0_1 -u 0.021449469414015987 > ./result_6chains/node139_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_1 -p 302 -st topic139_1_0 -pt topic139_1_1 -u 0.02000532848132225 > ./result_6chains/node139_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_1 -p 328 -st topic139_2_0 -pt topic139_2_1 -u 0.006260701637325949 > ./result_6chains/node139_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_1 -p 529 -st topic139_3_0 -pt topic139_3_1 -u 0.04123593223495847 > ./result_6chains/node139_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_1 -p 810 -st topic139_4_0 -pt topic139_4_1 -u 0.02723566736405003 > ./result_6chains/node139_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_1 -p 914 -st topic139_5_0 -pt topic139_5_1 -u 0.021108453225775592 > ./result_6chains/node139_5_1.txt &
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
    "./result_6chains/node139_0_1.txt 90"
    "./result_6chains/node139_1_1.txt 89"
    "./result_6chains/node139_2_1.txt 88"
    "./result_6chains/node139_3_1.txt 87"
    "./result_6chains/node139_4_1.txt 86"
    "./result_6chains/node139_5_1.txt 85"
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
