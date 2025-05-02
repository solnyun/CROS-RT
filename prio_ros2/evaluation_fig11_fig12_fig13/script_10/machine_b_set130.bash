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
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_1 -p 143 -st topic130_0_0 -pt topic130_0_1 -u 0.008586513369572502 > ./result_10chains/node130_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_1 -p 225 -st topic130_1_0 -pt topic130_1_1 -u 0.002442694554955993 > ./result_10chains/node130_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_1 -p 242 -st topic130_2_0 -pt topic130_2_1 -u 0.004475635432920122 > ./result_10chains/node130_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_1 -p 317 -st topic130_3_0 -pt topic130_3_1 -u 0.013205564667435998 > ./result_10chains/node130_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_1 -p 347 -st topic130_4_0 -pt topic130_4_1 -u 0.04766667344486453 > ./result_10chains/node130_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_1 -p 414 -st topic130_5_0 -pt topic130_5_1 -u 0.009673508299807149 > ./result_10chains/node130_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_6_1 -p 541 -st topic130_6_0 -pt topic130_6_1 -u 0.0020063592553468124 > ./result_10chains/node130_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_7_1 -p 645 -st topic130_7_0 -pt topic130_7_1 -u 0.017543943739514595 > ./result_10chains/node130_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_8_1 -p 647 -st topic130_8_0 -pt topic130_8_1 -u 0.03522445155245485 > ./result_10chains/node130_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_9_1 -p 663 -st topic130_9_0 -pt topic130_9_1 -u 0.021866324189534103 > ./result_10chains/node130_9_1.txt &
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
    "./result_10chains/node130_0_1.txt 90"
    "./result_10chains/node130_1_1.txt 89"
    "./result_10chains/node130_2_1.txt 88"
    "./result_10chains/node130_3_1.txt 87"
    "./result_10chains/node130_4_1.txt 86"
    "./result_10chains/node130_5_1.txt 85"
    "./result_10chains/node130_6_1.txt 84"
    "./result_10chains/node130_7_1.txt 83"
    "./result_10chains/node130_8_1.txt 82"
    "./result_10chains/node130_9_1.txt 81"
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
