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
ros2 run evaluation_3_randomdag uunifast_node -n node60_0_1 -p 84 -st topic60_0_0 -pt topic60_0_1 -u 0.022363652273039547 > ./result_10chains/node60_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_1_1 -p 115 -st topic60_1_0 -pt topic60_1_1 -u 0.03659038782016483 > ./result_10chains/node60_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_2_1 -p 240 -st topic60_2_0 -pt topic60_2_1 -u 0.009487277900967095 > ./result_10chains/node60_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_3_1 -p 317 -st topic60_3_0 -pt topic60_3_1 -u 0.03103189066641454 > ./result_10chains/node60_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_4_1 -p 487 -st topic60_4_0 -pt topic60_4_1 -u 0.015320894412384878 > ./result_10chains/node60_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_5_1 -p 549 -st topic60_5_0 -pt topic60_5_1 -u 0.00810470103005212 > ./result_10chains/node60_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_6_1 -p 658 -st topic60_6_0 -pt topic60_6_1 -u 0.03420144279147036 > ./result_10chains/node60_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_7_1 -p 750 -st topic60_7_0 -pt topic60_7_1 -u 0.005951691656374859 > ./result_10chains/node60_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_8_1 -p 910 -st topic60_8_0 -pt topic60_8_1 -u 0.01001018028433396 > ./result_10chains/node60_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node60_9_1 -p 923 -st topic60_9_0 -pt topic60_9_1 -u 0.01198810882986895 > ./result_10chains/node60_9_1.txt &
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
    "./result_10chains/node60_0_1.txt 90"
    "./result_10chains/node60_1_1.txt 89"
    "./result_10chains/node60_2_1.txt 88"
    "./result_10chains/node60_3_1.txt 87"
    "./result_10chains/node60_4_1.txt 86"
    "./result_10chains/node60_5_1.txt 85"
    "./result_10chains/node60_6_1.txt 84"
    "./result_10chains/node60_7_1.txt 83"
    "./result_10chains/node60_8_1.txt 82"
    "./result_10chains/node60_9_1.txt 81"
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
