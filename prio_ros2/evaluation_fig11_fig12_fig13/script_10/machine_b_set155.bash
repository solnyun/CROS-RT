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
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_1 -p 121 -st topic155_0_0 -pt topic155_0_1 -u 0.009030322535150292 > ./result_10chains/node155_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_1 -p 227 -st topic155_1_0 -pt topic155_1_1 -u 0.02568717160511913 > ./result_10chains/node155_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_1 -p 240 -st topic155_2_0 -pt topic155_2_1 -u 0.0071569621430193076 > ./result_10chains/node155_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_1 -p 263 -st topic155_3_0 -pt topic155_3_1 -u 0.010314356712963546 > ./result_10chains/node155_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_1 -p 350 -st topic155_4_0 -pt topic155_4_1 -u 0.007802881235531495 > ./result_10chains/node155_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_1 -p 460 -st topic155_5_0 -pt topic155_5_1 -u 0.01448637920490417 > ./result_10chains/node155_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_6_1 -p 771 -st topic155_6_0 -pt topic155_6_1 -u 0.0019997884803217847 > ./result_10chains/node155_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_7_1 -p 828 -st topic155_7_0 -pt topic155_7_1 -u 0.022661226215390462 > ./result_10chains/node155_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_8_1 -p 870 -st topic155_8_0 -pt topic155_8_1 -u 0.0032043700560755867 > ./result_10chains/node155_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_9_1 -p 956 -st topic155_9_0 -pt topic155_9_1 -u 0.0730522248480283 > ./result_10chains/node155_9_1.txt &
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
    "./result_10chains/node155_0_1.txt 90"
    "./result_10chains/node155_1_1.txt 89"
    "./result_10chains/node155_2_1.txt 88"
    "./result_10chains/node155_3_1.txt 87"
    "./result_10chains/node155_4_1.txt 86"
    "./result_10chains/node155_5_1.txt 85"
    "./result_10chains/node155_6_1.txt 84"
    "./result_10chains/node155_7_1.txt 83"
    "./result_10chains/node155_8_1.txt 82"
    "./result_10chains/node155_9_1.txt 81"
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
