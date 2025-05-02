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
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_1 -p 158 -st topic310_0_0 -pt topic310_0_1 -u 0.012718053244738403 > ./result_10chains/node310_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_1 -p 179 -st topic310_1_0 -pt topic310_1_1 -u 0.009690996321302991 > ./result_10chains/node310_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_1 -p 217 -st topic310_2_0 -pt topic310_2_1 -u 0.020622362705870978 > ./result_10chains/node310_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_1 -p 316 -st topic310_3_0 -pt topic310_3_1 -u 0.0010641598891983906 > ./result_10chains/node310_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_4_1 -p 382 -st topic310_4_0 -pt topic310_4_1 -u 0.013518894649155733 > ./result_10chains/node310_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_5_1 -p 587 -st topic310_5_0 -pt topic310_5_1 -u 0.054119418904889305 > ./result_10chains/node310_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_6_1 -p 682 -st topic310_6_0 -pt topic310_6_1 -u 0.000959602433297263 > ./result_10chains/node310_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_7_1 -p 709 -st topic310_7_0 -pt topic310_7_1 -u 0.004932235790945941 > ./result_10chains/node310_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_8_1 -p 790 -st topic310_8_0 -pt topic310_8_1 -u 0.001353022966179826 > ./result_10chains/node310_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_9_1 -p 957 -st topic310_9_0 -pt topic310_9_1 -u 0.018425318016348877 > ./result_10chains/node310_9_1.txt &
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
    "./result_10chains/node310_0_1.txt 90"
    "./result_10chains/node310_1_1.txt 89"
    "./result_10chains/node310_2_1.txt 88"
    "./result_10chains/node310_3_1.txt 87"
    "./result_10chains/node310_4_1.txt 86"
    "./result_10chains/node310_5_1.txt 85"
    "./result_10chains/node310_6_1.txt 84"
    "./result_10chains/node310_7_1.txt 83"
    "./result_10chains/node310_8_1.txt 82"
    "./result_10chains/node310_9_1.txt 81"
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
