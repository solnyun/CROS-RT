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
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_1 -p 199 -st topic76_0_0 -pt topic76_0_1 -u 0.00708177843256369 > ./result_10chains/node76_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_1 -p 330 -st topic76_1_0 -pt topic76_1_1 -u 0.007908723177498855 > ./result_10chains/node76_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_1 -p 397 -st topic76_2_0 -pt topic76_2_1 -u 0.031131652259212994 > ./result_10chains/node76_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_1 -p 579 -st topic76_3_0 -pt topic76_3_1 -u 0.011681903139710625 > ./result_10chains/node76_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_1 -p 598 -st topic76_4_0 -pt topic76_4_1 -u 0.057064750238961875 > ./result_10chains/node76_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_1 -p 750 -st topic76_5_0 -pt topic76_5_1 -u 0.0013895667748359264 > ./result_10chains/node76_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_6_1 -p 824 -st topic76_6_0 -pt topic76_6_1 -u 0.01996479347347868 > ./result_10chains/node76_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_7_1 -p 899 -st topic76_7_0 -pt topic76_7_1 -u 0.02842824834026353 > ./result_10chains/node76_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_8_1 -p 907 -st topic76_8_0 -pt topic76_8_1 -u 0.008449477798944768 > ./result_10chains/node76_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_9_1 -p 955 -st topic76_9_0 -pt topic76_9_1 -u 0.0024854214773681257 > ./result_10chains/node76_9_1.txt &
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
    "./result_10chains/node76_0_1.txt 90"
    "./result_10chains/node76_1_1.txt 89"
    "./result_10chains/node76_2_1.txt 88"
    "./result_10chains/node76_3_1.txt 87"
    "./result_10chains/node76_4_1.txt 86"
    "./result_10chains/node76_5_1.txt 85"
    "./result_10chains/node76_6_1.txt 84"
    "./result_10chains/node76_7_1.txt 83"
    "./result_10chains/node76_8_1.txt 82"
    "./result_10chains/node76_9_1.txt 81"
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
