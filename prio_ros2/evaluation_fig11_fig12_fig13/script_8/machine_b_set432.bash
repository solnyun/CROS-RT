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
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_1 -p 83 -st topic432_0_0 -pt topic432_0_1 -u 0.025653439298954583 > ./result_8chains/node432_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_1 -p 151 -st topic432_1_0 -pt topic432_1_1 -u 0.03231921910742036 > ./result_8chains/node432_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_1 -p 388 -st topic432_2_0 -pt topic432_2_1 -u 0.03270977487060117 > ./result_8chains/node432_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_1 -p 640 -st topic432_3_0 -pt topic432_3_1 -u 0.028994768782419522 > ./result_8chains/node432_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_1 -p 815 -st topic432_4_0 -pt topic432_4_1 -u 0.06313148349074199 > ./result_8chains/node432_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_1 -p 818 -st topic432_5_0 -pt topic432_5_1 -u 0.032722331098124474 > ./result_8chains/node432_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_6_1 -p 872 -st topic432_6_0 -pt topic432_6_1 -u 0.021746953539504316 > ./result_8chains/node432_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_7_1 -p 919 -st topic432_7_0 -pt topic432_7_1 -u 0.0034909066806156977 > ./result_8chains/node432_7_1.txt &
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
    "./result_8chains/node432_0_1.txt 90"
    "./result_8chains/node432_1_1.txt 89"
    "./result_8chains/node432_2_1.txt 88"
    "./result_8chains/node432_3_1.txt 87"
    "./result_8chains/node432_4_1.txt 86"
    "./result_8chains/node432_5_1.txt 85"
    "./result_8chains/node432_6_1.txt 84"
    "./result_8chains/node432_7_1.txt 83"
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
