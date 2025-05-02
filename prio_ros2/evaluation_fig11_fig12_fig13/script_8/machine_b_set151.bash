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
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_1 -p 237 -st topic151_0_0 -pt topic151_0_1 -u 0.0009944965504299352 > ./result_8chains/node151_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_1 -p 255 -st topic151_1_0 -pt topic151_1_1 -u 0.026518268339065898 > ./result_8chains/node151_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_1 -p 352 -st topic151_2_0 -pt topic151_2_1 -u 0.02932177189511187 > ./result_8chains/node151_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_1 -p 358 -st topic151_3_0 -pt topic151_3_1 -u 0.004993294555647787 > ./result_8chains/node151_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_1 -p 443 -st topic151_4_0 -pt topic151_4_1 -u 0.0139740372875084 > ./result_8chains/node151_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_1 -p 706 -st topic151_5_0 -pt topic151_5_1 -u 0.012131966925037485 > ./result_8chains/node151_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_6_1 -p 780 -st topic151_6_0 -pt topic151_6_1 -u 0.020745962198470927 > ./result_8chains/node151_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_7_1 -p 932 -st topic151_7_0 -pt topic151_7_1 -u 0.037385963367865094 > ./result_8chains/node151_7_1.txt &
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
    "./result_8chains/node151_0_1.txt 90"
    "./result_8chains/node151_1_1.txt 89"
    "./result_8chains/node151_2_1.txt 88"
    "./result_8chains/node151_3_1.txt 87"
    "./result_8chains/node151_4_1.txt 86"
    "./result_8chains/node151_5_1.txt 85"
    "./result_8chains/node151_6_1.txt 84"
    "./result_8chains/node151_7_1.txt 83"
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
