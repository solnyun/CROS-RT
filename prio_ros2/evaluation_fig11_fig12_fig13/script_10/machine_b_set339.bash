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
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_1 -p 114 -st topic339_0_0 -pt topic339_0_1 -u 0.03616940960060516 > ./result_10chains/node339_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_1 -p 168 -st topic339_1_0 -pt topic339_1_1 -u 0.028527044559707337 > ./result_10chains/node339_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_1 -p 272 -st topic339_2_0 -pt topic339_2_1 -u 0.0012423605250233005 > ./result_10chains/node339_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_1 -p 292 -st topic339_3_0 -pt topic339_3_1 -u 0.02035753355393405 > ./result_10chains/node339_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_1 -p 418 -st topic339_4_0 -pt topic339_4_1 -u 0.007884070122533615 > ./result_10chains/node339_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_1 -p 439 -st topic339_5_0 -pt topic339_5_1 -u 0.02775947971004014 > ./result_10chains/node339_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_6_1 -p 670 -st topic339_6_0 -pt topic339_6_1 -u 0.006267520724940856 > ./result_10chains/node339_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_7_1 -p 742 -st topic339_7_0 -pt topic339_7_1 -u 0.015513261966539654 > ./result_10chains/node339_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_8_1 -p 809 -st topic339_8_0 -pt topic339_8_1 -u 0.061923982184614396 > ./result_10chains/node339_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_9_1 -p 981 -st topic339_9_0 -pt topic339_9_1 -u 0.013190023654178588 > ./result_10chains/node339_9_1.txt &
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
    "./result_10chains/node339_0_1.txt 90"
    "./result_10chains/node339_1_1.txt 89"
    "./result_10chains/node339_2_1.txt 88"
    "./result_10chains/node339_3_1.txt 87"
    "./result_10chains/node339_4_1.txt 86"
    "./result_10chains/node339_5_1.txt 85"
    "./result_10chains/node339_6_1.txt 84"
    "./result_10chains/node339_7_1.txt 83"
    "./result_10chains/node339_8_1.txt 82"
    "./result_10chains/node339_9_1.txt 81"
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
