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
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_1 -p 21 -st topic43_0_0 -pt topic43_0_1 -u 0.023789822496820157 > ./result_10chains/node43_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_1 -p 54 -st topic43_1_0 -pt topic43_1_1 -u 0.05346026202543608 > ./result_10chains/node43_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_1 -p 302 -st topic43_2_0 -pt topic43_2_1 -u 0.05516998474538781 > ./result_10chains/node43_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_1 -p 338 -st topic43_3_0 -pt topic43_3_1 -u 0.0068895182270785615 > ./result_10chains/node43_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_1 -p 381 -st topic43_4_0 -pt topic43_4_1 -u 0.006141504583475232 > ./result_10chains/node43_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_1 -p 726 -st topic43_5_0 -pt topic43_5_1 -u 0.025152383853662197 > ./result_10chains/node43_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_6_1 -p 732 -st topic43_6_0 -pt topic43_6_1 -u 0.008869417974902316 > ./result_10chains/node43_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_7_1 -p 763 -st topic43_7_0 -pt topic43_7_1 -u 0.017604823172419626 > ./result_10chains/node43_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_8_1 -p 838 -st topic43_8_0 -pt topic43_8_1 -u 0.007412451853336964 > ./result_10chains/node43_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_9_1 -p 885 -st topic43_9_0 -pt topic43_9_1 -u 0.014899990650567109 > ./result_10chains/node43_9_1.txt &
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
    "./result_10chains/node43_0_1.txt 90"
    "./result_10chains/node43_1_1.txt 89"
    "./result_10chains/node43_2_1.txt 88"
    "./result_10chains/node43_3_1.txt 87"
    "./result_10chains/node43_4_1.txt 86"
    "./result_10chains/node43_5_1.txt 85"
    "./result_10chains/node43_6_1.txt 84"
    "./result_10chains/node43_7_1.txt 83"
    "./result_10chains/node43_8_1.txt 82"
    "./result_10chains/node43_9_1.txt 81"
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
