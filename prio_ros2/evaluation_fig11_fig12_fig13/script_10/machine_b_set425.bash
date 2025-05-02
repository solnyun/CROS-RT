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
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_1 -p 106 -st topic425_0_0 -pt topic425_0_1 -u 0.0017020837152056378 > ./result_10chains/node425_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_1 -p 125 -st topic425_1_0 -pt topic425_1_1 -u 0.007162966102304491 > ./result_10chains/node425_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_1 -p 228 -st topic425_2_0 -pt topic425_2_1 -u 0.06536802858011304 > ./result_10chains/node425_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_1 -p 248 -st topic425_3_0 -pt topic425_3_1 -u 0.009028262314407176 > ./result_10chains/node425_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_1 -p 286 -st topic425_4_0 -pt topic425_4_1 -u 0.007771117679255007 > ./result_10chains/node425_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_1 -p 724 -st topic425_5_0 -pt topic425_5_1 -u 0.014435183428248538 > ./result_10chains/node425_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_6_1 -p 788 -st topic425_6_0 -pt topic425_6_1 -u 0.0015648948999107681 > ./result_10chains/node425_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_7_1 -p 878 -st topic425_7_0 -pt topic425_7_1 -u 0.0038907469293661193 > ./result_10chains/node425_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_8_1 -p 972 -st topic425_8_0 -pt topic425_8_1 -u 0.001483452494192978 > ./result_10chains/node425_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_9_1 -p 994 -st topic425_9_0 -pt topic425_9_1 -u 0.006209208018477059 > ./result_10chains/node425_9_1.txt &
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
    "./result_10chains/node425_0_1.txt 90"
    "./result_10chains/node425_1_1.txt 89"
    "./result_10chains/node425_2_1.txt 88"
    "./result_10chains/node425_3_1.txt 87"
    "./result_10chains/node425_4_1.txt 86"
    "./result_10chains/node425_5_1.txt 85"
    "./result_10chains/node425_6_1.txt 84"
    "./result_10chains/node425_7_1.txt 83"
    "./result_10chains/node425_8_1.txt 82"
    "./result_10chains/node425_9_1.txt 81"
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
