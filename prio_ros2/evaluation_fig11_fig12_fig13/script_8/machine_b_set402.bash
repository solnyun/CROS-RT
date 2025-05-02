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
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_1 -p 89 -st topic402_0_0 -pt topic402_0_1 -u 0.005588419496899311 > ./result_8chains/node402_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_1 -p 444 -st topic402_1_0 -pt topic402_1_1 -u 0.011401684259806477 > ./result_8chains/node402_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_1 -p 454 -st topic402_2_0 -pt topic402_2_1 -u 0.004044988541621497 > ./result_8chains/node402_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_1 -p 547 -st topic402_3_0 -pt topic402_3_1 -u 0.070782343049899 > ./result_8chains/node402_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_4_1 -p 744 -st topic402_4_0 -pt topic402_4_1 -u 0.03666866564581178 > ./result_8chains/node402_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_5_1 -p 813 -st topic402_5_0 -pt topic402_5_1 -u 0.020551441018864025 > ./result_8chains/node402_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_6_1 -p 898 -st topic402_6_0 -pt topic402_6_1 -u 0.007242061285190907 > ./result_8chains/node402_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_7_1 -p 907 -st topic402_7_0 -pt topic402_7_1 -u 0.007069837158666445 > ./result_8chains/node402_7_1.txt &
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
    "./result_8chains/node402_0_1.txt 90"
    "./result_8chains/node402_1_1.txt 89"
    "./result_8chains/node402_2_1.txt 88"
    "./result_8chains/node402_3_1.txt 87"
    "./result_8chains/node402_4_1.txt 86"
    "./result_8chains/node402_5_1.txt 85"
    "./result_8chains/node402_6_1.txt 84"
    "./result_8chains/node402_7_1.txt 83"
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
