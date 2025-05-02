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
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_1 -p 32 -st topic5_0_0 -pt topic5_0_1 -u 0.009482823884197467 > ./result_10chains/node5_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_1 -p 51 -st topic5_1_0 -pt topic5_1_1 -u 0.017588368672078303 > ./result_10chains/node5_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_1 -p 434 -st topic5_2_0 -pt topic5_2_1 -u 0.04789415893800003 > ./result_10chains/node5_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_1 -p 458 -st topic5_3_0 -pt topic5_3_1 -u 0.03985001132802052 > ./result_10chains/node5_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_1 -p 505 -st topic5_4_0 -pt topic5_4_1 -u 0.03579662537604589 > ./result_10chains/node5_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_1 -p 561 -st topic5_5_0 -pt topic5_5_1 -u 0.009575272394078793 > ./result_10chains/node5_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_6_1 -p 657 -st topic5_6_0 -pt topic5_6_1 -u 0.0010508104469103274 > ./result_10chains/node5_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_7_1 -p 685 -st topic5_7_0 -pt topic5_7_1 -u 0.002129985704494658 > ./result_10chains/node5_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_8_1 -p 703 -st topic5_8_0 -pt topic5_8_1 -u 0.00245882579146664 > ./result_10chains/node5_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node5_9_1 -p 859 -st topic5_9_0 -pt topic5_9_1 -u 0.03517669247324727 > ./result_10chains/node5_9_1.txt &
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
    "./result_10chains/node5_0_1.txt 90"
    "./result_10chains/node5_1_1.txt 89"
    "./result_10chains/node5_2_1.txt 88"
    "./result_10chains/node5_3_1.txt 87"
    "./result_10chains/node5_4_1.txt 86"
    "./result_10chains/node5_5_1.txt 85"
    "./result_10chains/node5_6_1.txt 84"
    "./result_10chains/node5_7_1.txt 83"
    "./result_10chains/node5_8_1.txt 82"
    "./result_10chains/node5_9_1.txt 81"
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
