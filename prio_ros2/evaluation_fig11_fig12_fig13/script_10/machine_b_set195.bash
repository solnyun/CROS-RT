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
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_1 -p 99 -st topic195_0_0 -pt topic195_0_1 -u 0.022868223839385582 > ./result_10chains/node195_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_1 -p 247 -st topic195_1_0 -pt topic195_1_1 -u 0.0320533389685933 > ./result_10chains/node195_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_1 -p 302 -st topic195_2_0 -pt topic195_2_1 -u 0.001126187754289576 > ./result_10chains/node195_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_1 -p 306 -st topic195_3_0 -pt topic195_3_1 -u 0.020879372872424307 > ./result_10chains/node195_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_1 -p 485 -st topic195_4_0 -pt topic195_4_1 -u 0.005858370709593941 > ./result_10chains/node195_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_1 -p 516 -st topic195_5_0 -pt topic195_5_1 -u 0.015334855697715699 > ./result_10chains/node195_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_6_1 -p 838 -st topic195_6_0 -pt topic195_6_1 -u 0.008878404648817506 > ./result_10chains/node195_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_7_1 -p 879 -st topic195_7_0 -pt topic195_7_1 -u 0.008563117243040014 > ./result_10chains/node195_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_8_1 -p 885 -st topic195_8_0 -pt topic195_8_1 -u 0.009121933625859294 > ./result_10chains/node195_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_9_1 -p 955 -st topic195_9_0 -pt topic195_9_1 -u 0.07982647211791484 > ./result_10chains/node195_9_1.txt &
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
    "./result_10chains/node195_0_1.txt 90"
    "./result_10chains/node195_1_1.txt 89"
    "./result_10chains/node195_2_1.txt 88"
    "./result_10chains/node195_3_1.txt 87"
    "./result_10chains/node195_4_1.txt 86"
    "./result_10chains/node195_5_1.txt 85"
    "./result_10chains/node195_6_1.txt 84"
    "./result_10chains/node195_7_1.txt 83"
    "./result_10chains/node195_8_1.txt 82"
    "./result_10chains/node195_9_1.txt 81"
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
