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
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_1 -p 83 -st topic153_0_0 -pt topic153_0_1 -u 0.023637262774334256 > ./result_10chains/node153_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_1 -p 252 -st topic153_1_0 -pt topic153_1_1 -u 0.0037202241372478184 > ./result_10chains/node153_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_1 -p 339 -st topic153_2_0 -pt topic153_2_1 -u 0.00026656867663499284 > ./result_10chains/node153_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_1 -p 399 -st topic153_3_0 -pt topic153_3_1 -u 0.0058897617110346134 > ./result_10chains/node153_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_1 -p 632 -st topic153_4_0 -pt topic153_4_1 -u 0.017746893658296736 > ./result_10chains/node153_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_1 -p 670 -st topic153_5_0 -pt topic153_5_1 -u 0.03317193777807506 > ./result_10chains/node153_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_6_1 -p 692 -st topic153_6_0 -pt topic153_6_1 -u 0.0013728895789900386 > ./result_10chains/node153_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_7_1 -p 742 -st topic153_7_0 -pt topic153_7_1 -u 0.0013431896453701686 > ./result_10chains/node153_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_8_1 -p 920 -st topic153_8_0 -pt topic153_8_1 -u 0.004575678279862182 > ./result_10chains/node153_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_9_1 -p 999 -st topic153_9_0 -pt topic153_9_1 -u 0.0004691304028701347 > ./result_10chains/node153_9_1.txt &
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
    "./result_10chains/node153_0_1.txt 90"
    "./result_10chains/node153_1_1.txt 89"
    "./result_10chains/node153_2_1.txt 88"
    "./result_10chains/node153_3_1.txt 87"
    "./result_10chains/node153_4_1.txt 86"
    "./result_10chains/node153_5_1.txt 85"
    "./result_10chains/node153_6_1.txt 84"
    "./result_10chains/node153_7_1.txt 83"
    "./result_10chains/node153_8_1.txt 82"
    "./result_10chains/node153_9_1.txt 81"
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
