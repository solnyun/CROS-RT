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
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_1 -p 209 -st topic383_0_0 -pt topic383_0_1 -u 0.013802522007058338 > ./result_8chains/node383_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_1 -p 327 -st topic383_1_0 -pt topic383_1_1 -u 0.01618415041118826 > ./result_8chains/node383_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_1 -p 333 -st topic383_2_0 -pt topic383_2_1 -u 0.014236856133846731 > ./result_8chains/node383_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_1 -p 449 -st topic383_3_0 -pt topic383_3_1 -u 0.025260993218957306 > ./result_8chains/node383_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_1 -p 673 -st topic383_4_0 -pt topic383_4_1 -u 0.0057036519191094315 > ./result_8chains/node383_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_1 -p 717 -st topic383_5_0 -pt topic383_5_1 -u 0.030242974854657545 > ./result_8chains/node383_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_6_1 -p 735 -st topic383_6_0 -pt topic383_6_1 -u 0.024377319202785352 > ./result_8chains/node383_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_7_1 -p 927 -st topic383_7_0 -pt topic383_7_1 -u 0.04258557293532075 > ./result_8chains/node383_7_1.txt &
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
    "./result_8chains/node383_0_1.txt 90"
    "./result_8chains/node383_1_1.txt 89"
    "./result_8chains/node383_2_1.txt 88"
    "./result_8chains/node383_3_1.txt 87"
    "./result_8chains/node383_4_1.txt 86"
    "./result_8chains/node383_5_1.txt 85"
    "./result_8chains/node383_6_1.txt 84"
    "./result_8chains/node383_7_1.txt 83"
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
