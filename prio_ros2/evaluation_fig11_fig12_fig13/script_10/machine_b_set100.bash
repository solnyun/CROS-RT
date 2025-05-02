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
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_1 -p 277 -st topic100_0_0 -pt topic100_0_1 -u 0.02420422691909807 > ./result_10chains/node100_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_1 -p 402 -st topic100_1_0 -pt topic100_1_1 -u 0.0205226712635036 > ./result_10chains/node100_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_1 -p 421 -st topic100_2_0 -pt topic100_2_1 -u 0.0445199521508286 > ./result_10chains/node100_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_1 -p 456 -st topic100_3_0 -pt topic100_3_1 -u 0.006416888494629958 > ./result_10chains/node100_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_1 -p 459 -st topic100_4_0 -pt topic100_4_1 -u 0.005244190482630584 > ./result_10chains/node100_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_1 -p 506 -st topic100_5_0 -pt topic100_5_1 -u 0.004438276806921687 > ./result_10chains/node100_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_6_1 -p 592 -st topic100_6_0 -pt topic100_6_1 -u 0.004787907869036073 > ./result_10chains/node100_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_7_1 -p 666 -st topic100_7_0 -pt topic100_7_1 -u 0.01477088057560609 > ./result_10chains/node100_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_8_1 -p 689 -st topic100_8_0 -pt topic100_8_1 -u 0.010996403038920646 > ./result_10chains/node100_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_9_1 -p 796 -st topic100_9_0 -pt topic100_9_1 -u 0.007668315326640224 > ./result_10chains/node100_9_1.txt &
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
    "./result_10chains/node100_0_1.txt 90"
    "./result_10chains/node100_1_1.txt 89"
    "./result_10chains/node100_2_1.txt 88"
    "./result_10chains/node100_3_1.txt 87"
    "./result_10chains/node100_4_1.txt 86"
    "./result_10chains/node100_5_1.txt 85"
    "./result_10chains/node100_6_1.txt 84"
    "./result_10chains/node100_7_1.txt 83"
    "./result_10chains/node100_8_1.txt 82"
    "./result_10chains/node100_9_1.txt 81"
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
