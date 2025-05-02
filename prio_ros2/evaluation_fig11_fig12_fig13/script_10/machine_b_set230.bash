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
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_1 -p 47 -st topic230_0_0 -pt topic230_0_1 -u 0.010275826782560615 > ./result_10chains/node230_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_1 -p 250 -st topic230_1_0 -pt topic230_1_1 -u 0.0035382366647958574 > ./result_10chains/node230_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_1 -p 323 -st topic230_2_0 -pt topic230_2_1 -u 0.008607309188067847 > ./result_10chains/node230_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_1 -p 324 -st topic230_3_0 -pt topic230_3_1 -u 0.0019517985360418821 > ./result_10chains/node230_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_1 -p 524 -st topic230_4_0 -pt topic230_4_1 -u 0.011964109267819989 > ./result_10chains/node230_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_1 -p 645 -st topic230_5_0 -pt topic230_5_1 -u 0.0174142880157912 > ./result_10chains/node230_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_6_1 -p 737 -st topic230_6_0 -pt topic230_6_1 -u 0.02687995151902889 > ./result_10chains/node230_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_7_1 -p 762 -st topic230_7_0 -pt topic230_7_1 -u 0.008822320506338854 > ./result_10chains/node230_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_8_1 -p 907 -st topic230_8_0 -pt topic230_8_1 -u 9.559004913450853e-06 > ./result_10chains/node230_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_9_1 -p 935 -st topic230_9_0 -pt topic230_9_1 -u 0.05183736752052627 > ./result_10chains/node230_9_1.txt &
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
    "./result_10chains/node230_0_1.txt 90"
    "./result_10chains/node230_1_1.txt 89"
    "./result_10chains/node230_2_1.txt 88"
    "./result_10chains/node230_3_1.txt 87"
    "./result_10chains/node230_4_1.txt 86"
    "./result_10chains/node230_5_1.txt 85"
    "./result_10chains/node230_6_1.txt 84"
    "./result_10chains/node230_7_1.txt 83"
    "./result_10chains/node230_8_1.txt 82"
    "./result_10chains/node230_9_1.txt 81"
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
