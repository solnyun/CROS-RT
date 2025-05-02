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
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_1 -p 221 -st topic498_0_0 -pt topic498_0_1 -u 0.028121419272330916 > ./result_10chains/node498_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_1 -p 280 -st topic498_1_0 -pt topic498_1_1 -u 0.030572364494360793 > ./result_10chains/node498_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_1 -p 334 -st topic498_2_0 -pt topic498_2_1 -u 0.02161583872414191 > ./result_10chains/node498_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_1 -p 454 -st topic498_3_0 -pt topic498_3_1 -u 0.0005975145295779027 > ./result_10chains/node498_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_1 -p 652 -st topic498_4_0 -pt topic498_4_1 -u 0.0027754506469876983 > ./result_10chains/node498_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_1 -p 672 -st topic498_5_0 -pt topic498_5_1 -u 0.011074675563023828 > ./result_10chains/node498_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_6_1 -p 755 -st topic498_6_0 -pt topic498_6_1 -u 0.010741490276666349 > ./result_10chains/node498_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_7_1 -p 819 -st topic498_7_0 -pt topic498_7_1 -u 0.011108961700848297 > ./result_10chains/node498_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_8_1 -p 867 -st topic498_8_0 -pt topic498_8_1 -u 0.02020480029585934 > ./result_10chains/node498_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_9_1 -p 972 -st topic498_9_0 -pt topic498_9_1 -u 0.03496732522745561 > ./result_10chains/node498_9_1.txt &
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
    "./result_10chains/node498_0_1.txt 90"
    "./result_10chains/node498_1_1.txt 89"
    "./result_10chains/node498_2_1.txt 88"
    "./result_10chains/node498_3_1.txt 87"
    "./result_10chains/node498_4_1.txt 86"
    "./result_10chains/node498_5_1.txt 85"
    "./result_10chains/node498_6_1.txt 84"
    "./result_10chains/node498_7_1.txt 83"
    "./result_10chains/node498_8_1.txt 82"
    "./result_10chains/node498_9_1.txt 81"
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
