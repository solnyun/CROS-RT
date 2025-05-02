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
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_1 -p 135 -st topic115_0_0 -pt topic115_0_1 -u 0.02837961518403659 > ./result_10chains/node115_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_1 -p 143 -st topic115_1_0 -pt topic115_1_1 -u 0.0023376723748869677 > ./result_10chains/node115_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_1 -p 173 -st topic115_2_0 -pt topic115_2_1 -u 0.011796405113841002 > ./result_10chains/node115_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_1 -p 381 -st topic115_3_0 -pt topic115_3_1 -u 0.0028601495485201522 > ./result_10chains/node115_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_1 -p 391 -st topic115_4_0 -pt topic115_4_1 -u 0.030936710006548074 > ./result_10chains/node115_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_1 -p 450 -st topic115_5_0 -pt topic115_5_1 -u 0.02277585624734374 > ./result_10chains/node115_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_6_1 -p 504 -st topic115_6_0 -pt topic115_6_1 -u 0.004597365529442704 > ./result_10chains/node115_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_7_1 -p 705 -st topic115_7_0 -pt topic115_7_1 -u 0.06723519591774058 > ./result_10chains/node115_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_8_1 -p 786 -st topic115_8_0 -pt topic115_8_1 -u 0.022668384733428575 > ./result_10chains/node115_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_9_1 -p 955 -st topic115_9_0 -pt topic115_9_1 -u 0.012068975817314484 > ./result_10chains/node115_9_1.txt &
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
    "./result_10chains/node115_0_1.txt 90"
    "./result_10chains/node115_1_1.txt 89"
    "./result_10chains/node115_2_1.txt 88"
    "./result_10chains/node115_3_1.txt 87"
    "./result_10chains/node115_4_1.txt 86"
    "./result_10chains/node115_5_1.txt 85"
    "./result_10chains/node115_6_1.txt 84"
    "./result_10chains/node115_7_1.txt 83"
    "./result_10chains/node115_8_1.txt 82"
    "./result_10chains/node115_9_1.txt 81"
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
