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
ros2 run evaluation_3_randomdag uunifast_node -n node482_0_1 -p 44 -st topic482_0_0 -pt topic482_0_1 -u 0.003089055298347687 > ./result_10chains/node482_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_1_1 -p 94 -st topic482_1_0 -pt topic482_1_1 -u 0.06832100943677305 > ./result_10chains/node482_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_2_1 -p 181 -st topic482_2_0 -pt topic482_2_1 -u 0.009521576163671774 > ./result_10chains/node482_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_3_1 -p 244 -st topic482_3_0 -pt topic482_3_1 -u 0.01907182432012433 > ./result_10chains/node482_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_4_1 -p 399 -st topic482_4_0 -pt topic482_4_1 -u 0.007272909486739143 > ./result_10chains/node482_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_5_1 -p 420 -st topic482_5_0 -pt topic482_5_1 -u 0.022095105645420693 > ./result_10chains/node482_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_6_1 -p 450 -st topic482_6_0 -pt topic482_6_1 -u 0.03661210882695794 > ./result_10chains/node482_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_7_1 -p 475 -st topic482_7_0 -pt topic482_7_1 -u 0.00300690344775921 > ./result_10chains/node482_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_8_1 -p 757 -st topic482_8_0 -pt topic482_8_1 -u 0.0014599278944474742 > ./result_10chains/node482_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_9_1 -p 958 -st topic482_9_0 -pt topic482_9_1 -u 0.012835430925267677 > ./result_10chains/node482_9_1.txt &
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
    "./result_10chains/node482_0_1.txt 90"
    "./result_10chains/node482_1_1.txt 89"
    "./result_10chains/node482_2_1.txt 88"
    "./result_10chains/node482_3_1.txt 87"
    "./result_10chains/node482_4_1.txt 86"
    "./result_10chains/node482_5_1.txt 85"
    "./result_10chains/node482_6_1.txt 84"
    "./result_10chains/node482_7_1.txt 83"
    "./result_10chains/node482_8_1.txt 82"
    "./result_10chains/node482_9_1.txt 81"
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
