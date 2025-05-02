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
ros2 run evaluation_3_randomdag uunifast_node -n node206_0_1 -p 18 -st topic206_0_0 -pt topic206_0_1 -u 0.016109107534321043 > ./result_10chains/node206_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_1_1 -p 378 -st topic206_1_0 -pt topic206_1_1 -u 0.007756771327050882 > ./result_10chains/node206_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_2_1 -p 394 -st topic206_2_0 -pt topic206_2_1 -u 0.008636955797427348 > ./result_10chains/node206_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_3_1 -p 432 -st topic206_3_0 -pt topic206_3_1 -u 0.007439260738566766 > ./result_10chains/node206_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_4_1 -p 472 -st topic206_4_0 -pt topic206_4_1 -u 0.0053078664756336935 > ./result_10chains/node206_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_5_1 -p 646 -st topic206_5_0 -pt topic206_5_1 -u 0.013219554115755955 > ./result_10chains/node206_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_6_1 -p 761 -st topic206_6_0 -pt topic206_6_1 -u 0.016586118387957455 > ./result_10chains/node206_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_7_1 -p 774 -st topic206_7_0 -pt topic206_7_1 -u 0.012480888193978884 > ./result_10chains/node206_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_8_1 -p 778 -st topic206_8_0 -pt topic206_8_1 -u 0.02103941166988127 > ./result_10chains/node206_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_9_1 -p 802 -st topic206_9_0 -pt topic206_9_1 -u 0.0018347696317637108 > ./result_10chains/node206_9_1.txt &
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
    "./result_10chains/node206_0_1.txt 90"
    "./result_10chains/node206_1_1.txt 89"
    "./result_10chains/node206_2_1.txt 88"
    "./result_10chains/node206_3_1.txt 87"
    "./result_10chains/node206_4_1.txt 86"
    "./result_10chains/node206_5_1.txt 85"
    "./result_10chains/node206_6_1.txt 84"
    "./result_10chains/node206_7_1.txt 83"
    "./result_10chains/node206_8_1.txt 82"
    "./result_10chains/node206_9_1.txt 81"
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
