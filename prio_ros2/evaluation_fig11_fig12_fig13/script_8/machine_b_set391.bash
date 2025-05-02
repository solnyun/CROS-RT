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
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_1 -p 66 -st topic391_0_0 -pt topic391_0_1 -u 0.025046227543477018 > ./result_8chains/node391_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_1 -p 106 -st topic391_1_0 -pt topic391_1_1 -u 0.022963065654032777 > ./result_8chains/node391_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_1 -p 108 -st topic391_2_0 -pt topic391_2_1 -u 0.0004193600650186369 > ./result_8chains/node391_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_1 -p 468 -st topic391_3_0 -pt topic391_3_1 -u 0.017049694865377607 > ./result_8chains/node391_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_1 -p 493 -st topic391_4_0 -pt topic391_4_1 -u 0.005997275547171277 > ./result_8chains/node391_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_1 -p 680 -st topic391_5_0 -pt topic391_5_1 -u 0.006363874434450717 > ./result_8chains/node391_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_6_1 -p 689 -st topic391_6_0 -pt topic391_6_1 -u 0.0723546837466785 > ./result_8chains/node391_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_7_1 -p 861 -st topic391_7_0 -pt topic391_7_1 -u 0.00870357657332159 > ./result_8chains/node391_7_1.txt &
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
    "./result_8chains/node391_0_1.txt 90"
    "./result_8chains/node391_1_1.txt 89"
    "./result_8chains/node391_2_1.txt 88"
    "./result_8chains/node391_3_1.txt 87"
    "./result_8chains/node391_4_1.txt 86"
    "./result_8chains/node391_5_1.txt 85"
    "./result_8chains/node391_6_1.txt 84"
    "./result_8chains/node391_7_1.txt 83"
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
