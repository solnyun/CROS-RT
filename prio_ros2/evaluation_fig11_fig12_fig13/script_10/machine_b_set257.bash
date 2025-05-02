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
ros2 run evaluation_3_randomdag uunifast_node -n node257_0_1 -p 115 -st topic257_0_0 -pt topic257_0_1 -u 0.003941363845342272 > ./result_10chains/node257_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_1_1 -p 185 -st topic257_1_0 -pt topic257_1_1 -u 0.0015038864709738808 > ./result_10chains/node257_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_2_1 -p 189 -st topic257_2_0 -pt topic257_2_1 -u 0.005932061313403292 > ./result_10chains/node257_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_3_1 -p 212 -st topic257_3_0 -pt topic257_3_1 -u 0.030772984317944452 > ./result_10chains/node257_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_4_1 -p 225 -st topic257_4_0 -pt topic257_4_1 -u 0.01318356347597549 > ./result_10chains/node257_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_5_1 -p 363 -st topic257_5_0 -pt topic257_5_1 -u 0.006472922431499689 > ./result_10chains/node257_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_6_1 -p 502 -st topic257_6_0 -pt topic257_6_1 -u 0.00118407287978195 > ./result_10chains/node257_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_7_1 -p 664 -st topic257_7_0 -pt topic257_7_1 -u 0.01337785744215697 > ./result_10chains/node257_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_8_1 -p 693 -st topic257_8_0 -pt topic257_8_1 -u 0.0032330645443755246 > ./result_10chains/node257_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node257_9_1 -p 747 -st topic257_9_0 -pt topic257_9_1 -u 0.04206612697884744 > ./result_10chains/node257_9_1.txt &
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
    "./result_10chains/node257_0_1.txt 90"
    "./result_10chains/node257_1_1.txt 89"
    "./result_10chains/node257_2_1.txt 88"
    "./result_10chains/node257_3_1.txt 87"
    "./result_10chains/node257_4_1.txt 86"
    "./result_10chains/node257_5_1.txt 85"
    "./result_10chains/node257_6_1.txt 84"
    "./result_10chains/node257_7_1.txt 83"
    "./result_10chains/node257_8_1.txt 82"
    "./result_10chains/node257_9_1.txt 81"
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
