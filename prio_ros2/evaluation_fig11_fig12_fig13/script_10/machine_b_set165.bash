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
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_1 -p 17 -st topic165_0_0 -pt topic165_0_1 -u 0.024129684119429173 > ./result_10chains/node165_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_1 -p 33 -st topic165_1_0 -pt topic165_1_1 -u 0.0034439238651509108 > ./result_10chains/node165_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_1 -p 76 -st topic165_2_0 -pt topic165_2_1 -u 0.04558199790140066 > ./result_10chains/node165_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_1 -p 415 -st topic165_3_0 -pt topic165_3_1 -u 0.004817663082079926 > ./result_10chains/node165_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_1 -p 494 -st topic165_4_0 -pt topic165_4_1 -u 0.0429321765818203 > ./result_10chains/node165_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_1 -p 497 -st topic165_5_0 -pt topic165_5_1 -u 0.002045562203348783 > ./result_10chains/node165_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_6_1 -p 545 -st topic165_6_0 -pt topic165_6_1 -u 0.004087561670078899 > ./result_10chains/node165_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_7_1 -p 638 -st topic165_7_0 -pt topic165_7_1 -u 0.02435451405274225 > ./result_10chains/node165_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_8_1 -p 665 -st topic165_8_0 -pt topic165_8_1 -u 0.10037750982851001 > ./result_10chains/node165_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_9_1 -p 986 -st topic165_9_0 -pt topic165_9_1 -u 0.005052955622124429 > ./result_10chains/node165_9_1.txt &
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
    "./result_10chains/node165_0_1.txt 90"
    "./result_10chains/node165_1_1.txt 89"
    "./result_10chains/node165_2_1.txt 88"
    "./result_10chains/node165_3_1.txt 87"
    "./result_10chains/node165_4_1.txt 86"
    "./result_10chains/node165_5_1.txt 85"
    "./result_10chains/node165_6_1.txt 84"
    "./result_10chains/node165_7_1.txt 83"
    "./result_10chains/node165_8_1.txt 82"
    "./result_10chains/node165_9_1.txt 81"
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
