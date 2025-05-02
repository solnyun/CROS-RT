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
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_1 -p 51 -st topic26_0_0 -pt topic26_0_1 -u 0.0034503218595852703 > ./result_10chains/node26_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_1 -p 219 -st topic26_1_0 -pt topic26_1_1 -u 0.014831590843529474 > ./result_10chains/node26_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_1 -p 248 -st topic26_2_0 -pt topic26_2_1 -u 0.019557781386019546 > ./result_10chains/node26_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_1 -p 548 -st topic26_3_0 -pt topic26_3_1 -u 0.013210344822475184 > ./result_10chains/node26_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_1 -p 607 -st topic26_4_0 -pt topic26_4_1 -u 0.035675922086418926 > ./result_10chains/node26_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_1 -p 611 -st topic26_5_0 -pt topic26_5_1 -u 0.0005857726402093699 > ./result_10chains/node26_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_6_1 -p 696 -st topic26_6_0 -pt topic26_6_1 -u 0.010346333769537835 > ./result_10chains/node26_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_7_1 -p 905 -st topic26_7_0 -pt topic26_7_1 -u 0.003003861390704382 > ./result_10chains/node26_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_8_1 -p 938 -st topic26_8_0 -pt topic26_8_1 -u 0.009194671010826896 > ./result_10chains/node26_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node26_9_1 -p 949 -st topic26_9_0 -pt topic26_9_1 -u 0.01675398238362774 > ./result_10chains/node26_9_1.txt &
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
    "./result_10chains/node26_0_1.txt 90"
    "./result_10chains/node26_1_1.txt 89"
    "./result_10chains/node26_2_1.txt 88"
    "./result_10chains/node26_3_1.txt 87"
    "./result_10chains/node26_4_1.txt 86"
    "./result_10chains/node26_5_1.txt 85"
    "./result_10chains/node26_6_1.txt 84"
    "./result_10chains/node26_7_1.txt 83"
    "./result_10chains/node26_8_1.txt 82"
    "./result_10chains/node26_9_1.txt 81"
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
