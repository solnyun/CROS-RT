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
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_1 -p 320 -st topic344_0_0 -pt topic344_0_1 -u 0.027121989599923235 > ./result_6chains/node344_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_1 -p 332 -st topic344_1_0 -pt topic344_1_1 -u 0.04181325776275774 > ./result_6chains/node344_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_1 -p 525 -st topic344_2_0 -pt topic344_2_1 -u 0.016629191983681568 > ./result_6chains/node344_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_1 -p 633 -st topic344_3_0 -pt topic344_3_1 -u 0.05947800439845552 > ./result_6chains/node344_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_1 -p 741 -st topic344_4_0 -pt topic344_4_1 -u 0.001597205047360828 > ./result_6chains/node344_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_1 -p 922 -st topic344_5_0 -pt topic344_5_1 -u 0.07104339383087174 > ./result_6chains/node344_5_1.txt &
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
    "./result_6chains/node344_0_1.txt 90"
    "./result_6chains/node344_1_1.txt 89"
    "./result_6chains/node344_2_1.txt 88"
    "./result_6chains/node344_3_1.txt 87"
    "./result_6chains/node344_4_1.txt 86"
    "./result_6chains/node344_5_1.txt 85"
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
