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
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_1 -p 105 -st topic251_0_0 -pt topic251_0_1 -u 0.03854321003733241 > ./result_4chains/node251_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_1 -p 301 -st topic251_1_0 -pt topic251_1_1 -u 0.027115794296560136 > ./result_4chains/node251_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_1 -p 307 -st topic251_2_0 -pt topic251_2_1 -u 0.055834015357573416 > ./result_4chains/node251_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_1 -p 959 -st topic251_3_0 -pt topic251_3_1 -u 0.018872171634706204 > ./result_4chains/node251_3_1.txt &
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
    "./result_4chains/node251_0_1.txt 90"
    "./result_4chains/node251_1_1.txt 89"
    "./result_4chains/node251_2_1.txt 88"
    "./result_4chains/node251_3_1.txt 87"
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
