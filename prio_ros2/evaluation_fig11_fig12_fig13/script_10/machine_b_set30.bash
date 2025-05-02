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
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_1 -p 26 -st topic30_0_0 -pt topic30_0_1 -u 0.01061927323002404 > ./result_10chains/node30_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_1 -p 59 -st topic30_1_0 -pt topic30_1_1 -u 0.030643673330409016 > ./result_10chains/node30_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_1 -p 349 -st topic30_2_0 -pt topic30_2_1 -u 0.006063582681321955 > ./result_10chains/node30_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_1 -p 431 -st topic30_3_0 -pt topic30_3_1 -u 0.02139079274145833 > ./result_10chains/node30_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_1 -p 641 -st topic30_4_0 -pt topic30_4_1 -u 0.0013829981388183699 > ./result_10chains/node30_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_1 -p 702 -st topic30_5_0 -pt topic30_5_1 -u 0.012517846075353223 > ./result_10chains/node30_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_6_1 -p 875 -st topic30_6_0 -pt topic30_6_1 -u 0.07364547156445383 > ./result_10chains/node30_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_7_1 -p 884 -st topic30_7_0 -pt topic30_7_1 -u 0.003647881027549399 > ./result_10chains/node30_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_8_1 -p 928 -st topic30_8_0 -pt topic30_8_1 -u 0.03094780199970168 > ./result_10chains/node30_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_9_1 -p 965 -st topic30_9_0 -pt topic30_9_1 -u 0.015529880441826578 > ./result_10chains/node30_9_1.txt &
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
    "./result_10chains/node30_0_1.txt 90"
    "./result_10chains/node30_1_1.txt 89"
    "./result_10chains/node30_2_1.txt 88"
    "./result_10chains/node30_3_1.txt 87"
    "./result_10chains/node30_4_1.txt 86"
    "./result_10chains/node30_5_1.txt 85"
    "./result_10chains/node30_6_1.txt 84"
    "./result_10chains/node30_7_1.txt 83"
    "./result_10chains/node30_8_1.txt 82"
    "./result_10chains/node30_9_1.txt 81"
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
