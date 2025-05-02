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
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_1 -p 254 -st topic172_0_0 -pt topic172_0_1 -u 0.01722667590412219 > ./result_6chains/node172_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_1 -p 386 -st topic172_1_0 -pt topic172_1_1 -u 0.03228962326816992 > ./result_6chains/node172_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_1 -p 414 -st topic172_2_0 -pt topic172_2_1 -u 0.006743653534850957 > ./result_6chains/node172_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_1 -p 651 -st topic172_3_0 -pt topic172_3_1 -u 0.010113905615133756 > ./result_6chains/node172_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_1 -p 864 -st topic172_4_0 -pt topic172_4_1 -u 0.024590571171020398 > ./result_6chains/node172_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_1 -p 916 -st topic172_5_0 -pt topic172_5_1 -u 0.07460375292968435 > ./result_6chains/node172_5_1.txt &
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
    "./result_6chains/node172_0_1.txt 90"
    "./result_6chains/node172_1_1.txt 89"
    "./result_6chains/node172_2_1.txt 88"
    "./result_6chains/node172_3_1.txt 87"
    "./result_6chains/node172_4_1.txt 86"
    "./result_6chains/node172_5_1.txt 85"
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
