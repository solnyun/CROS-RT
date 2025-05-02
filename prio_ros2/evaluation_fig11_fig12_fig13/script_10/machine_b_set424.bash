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
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_1 -p 108 -st topic424_0_0 -pt topic424_0_1 -u 0.029118205970681876 > ./result_10chains/node424_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_1 -p 116 -st topic424_1_0 -pt topic424_1_1 -u 0.011448185355218798 > ./result_10chains/node424_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_1 -p 218 -st topic424_2_0 -pt topic424_2_1 -u 0.0023332077468411483 > ./result_10chains/node424_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_1 -p 352 -st topic424_3_0 -pt topic424_3_1 -u 0.03514763433042911 > ./result_10chains/node424_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_1 -p 371 -st topic424_4_0 -pt topic424_4_1 -u 0.013632631588938737 > ./result_10chains/node424_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_1 -p 461 -st topic424_5_0 -pt topic424_5_1 -u 0.02147955138633323 > ./result_10chains/node424_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_6_1 -p 660 -st topic424_6_0 -pt topic424_6_1 -u 0.0003268982372239271 > ./result_10chains/node424_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_7_1 -p 801 -st topic424_7_0 -pt topic424_7_1 -u 0.032642565540613525 > ./result_10chains/node424_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_8_1 -p 828 -st topic424_8_0 -pt topic424_8_1 -u 0.0221973248290242 > ./result_10chains/node424_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_9_1 -p 934 -st topic424_9_0 -pt topic424_9_1 -u 0.011847403232558071 > ./result_10chains/node424_9_1.txt &
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
    "./result_10chains/node424_0_1.txt 90"
    "./result_10chains/node424_1_1.txt 89"
    "./result_10chains/node424_2_1.txt 88"
    "./result_10chains/node424_3_1.txt 87"
    "./result_10chains/node424_4_1.txt 86"
    "./result_10chains/node424_5_1.txt 85"
    "./result_10chains/node424_6_1.txt 84"
    "./result_10chains/node424_7_1.txt 83"
    "./result_10chains/node424_8_1.txt 82"
    "./result_10chains/node424_9_1.txt 81"
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
