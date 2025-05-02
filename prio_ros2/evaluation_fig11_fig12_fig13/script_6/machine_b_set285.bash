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
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_1 -p 205 -st topic285_0_0 -pt topic285_0_1 -u 0.0196370238779347 > ./result_6chains/node285_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_1 -p 269 -st topic285_1_0 -pt topic285_1_1 -u 0.021657568228565627 > ./result_6chains/node285_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_1 -p 585 -st topic285_2_0 -pt topic285_2_1 -u 0.04028098200632663 > ./result_6chains/node285_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_1 -p 817 -st topic285_3_0 -pt topic285_3_1 -u 0.05303004347705015 > ./result_6chains/node285_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_1 -p 871 -st topic285_4_0 -pt topic285_4_1 -u 0.026755421550684222 > ./result_6chains/node285_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_1 -p 961 -st topic285_5_0 -pt topic285_5_1 -u 0.034487398054395484 > ./result_6chains/node285_5_1.txt &
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
    "./result_6chains/node285_0_1.txt 90"
    "./result_6chains/node285_1_1.txt 89"
    "./result_6chains/node285_2_1.txt 88"
    "./result_6chains/node285_3_1.txt 87"
    "./result_6chains/node285_4_1.txt 86"
    "./result_6chains/node285_5_1.txt 85"
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
