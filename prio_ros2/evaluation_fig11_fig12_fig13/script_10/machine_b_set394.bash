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
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_1 -p 50 -st topic394_0_0 -pt topic394_0_1 -u 0.005801498267135385 > ./result_10chains/node394_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_1 -p 62 -st topic394_1_0 -pt topic394_1_1 -u 0.026684514483110988 > ./result_10chains/node394_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_1 -p 109 -st topic394_2_0 -pt topic394_2_1 -u 0.016022717558315358 > ./result_10chains/node394_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_1 -p 179 -st topic394_3_0 -pt topic394_3_1 -u 0.011335250815054543 > ./result_10chains/node394_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_1 -p 250 -st topic394_4_0 -pt topic394_4_1 -u 0.017088576487887197 > ./result_10chains/node394_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_1 -p 362 -st topic394_5_0 -pt topic394_5_1 -u 0.004837585671917721 > ./result_10chains/node394_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_6_1 -p 372 -st topic394_6_0 -pt topic394_6_1 -u 6.37738698816559e-06 > ./result_10chains/node394_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_7_1 -p 665 -st topic394_7_0 -pt topic394_7_1 -u 0.010636059095866623 > ./result_10chains/node394_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_8_1 -p 693 -st topic394_8_0 -pt topic394_8_1 -u 0.016191721422851676 > ./result_10chains/node394_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_9_1 -p 926 -st topic394_9_0 -pt topic394_9_1 -u 0.014878791870089373 > ./result_10chains/node394_9_1.txt &
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
    "./result_10chains/node394_0_1.txt 90"
    "./result_10chains/node394_1_1.txt 89"
    "./result_10chains/node394_2_1.txt 88"
    "./result_10chains/node394_3_1.txt 87"
    "./result_10chains/node394_4_1.txt 86"
    "./result_10chains/node394_5_1.txt 85"
    "./result_10chains/node394_6_1.txt 84"
    "./result_10chains/node394_7_1.txt 83"
    "./result_10chains/node394_8_1.txt 82"
    "./result_10chains/node394_9_1.txt 81"
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
