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
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_1 -p 154 -st topic456_0_0 -pt topic456_0_1 -u 0.012210776502317167 > ./result_10chains/node456_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_1 -p 178 -st topic456_1_0 -pt topic456_1_1 -u 0.04896539555445617 > ./result_10chains/node456_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_1 -p 279 -st topic456_2_0 -pt topic456_2_1 -u 0.0017690127283181423 > ./result_10chains/node456_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_1 -p 313 -st topic456_3_0 -pt topic456_3_1 -u 0.018363809684496912 > ./result_10chains/node456_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_1 -p 487 -st topic456_4_0 -pt topic456_4_1 -u 0.011959023352210135 > ./result_10chains/node456_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_1 -p 631 -st topic456_5_0 -pt topic456_5_1 -u 0.000962021190856116 > ./result_10chains/node456_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_6_1 -p 662 -st topic456_6_0 -pt topic456_6_1 -u 0.0005633402507786434 > ./result_10chains/node456_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_7_1 -p 764 -st topic456_7_0 -pt topic456_7_1 -u 0.05172778647061174 > ./result_10chains/node456_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_8_1 -p 803 -st topic456_8_0 -pt topic456_8_1 -u 0.03993085145879077 > ./result_10chains/node456_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_9_1 -p 950 -st topic456_9_0 -pt topic456_9_1 -u 0.013412493156553629 > ./result_10chains/node456_9_1.txt &
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
    "./result_10chains/node456_0_1.txt 90"
    "./result_10chains/node456_1_1.txt 89"
    "./result_10chains/node456_2_1.txt 88"
    "./result_10chains/node456_3_1.txt 87"
    "./result_10chains/node456_4_1.txt 86"
    "./result_10chains/node456_5_1.txt 85"
    "./result_10chains/node456_6_1.txt 84"
    "./result_10chains/node456_7_1.txt 83"
    "./result_10chains/node456_8_1.txt 82"
    "./result_10chains/node456_9_1.txt 81"
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
