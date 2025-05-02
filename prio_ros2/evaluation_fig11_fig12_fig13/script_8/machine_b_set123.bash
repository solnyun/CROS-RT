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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_1 -p 13 -st topic123_0_0 -pt topic123_0_1 -u 0.032688681794534435 > ./result_8chains/node123_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_1 -p 260 -st topic123_1_0 -pt topic123_1_1 -u 0.025599986816586096 > ./result_8chains/node123_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_1 -p 302 -st topic123_2_0 -pt topic123_2_1 -u 0.013520147641291946 > ./result_8chains/node123_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_1 -p 380 -st topic123_3_0 -pt topic123_3_1 -u 0.006879264747076758 > ./result_8chains/node123_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_1 -p 527 -st topic123_4_0 -pt topic123_4_1 -u 0.019975850073295998 > ./result_8chains/node123_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_1 -p 635 -st topic123_5_0 -pt topic123_5_1 -u 0.030246746116133996 > ./result_8chains/node123_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_6_1 -p 920 -st topic123_6_0 -pt topic123_6_1 -u 9.076383390399512e-05 > ./result_8chains/node123_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_7_1 -p 926 -st topic123_7_0 -pt topic123_7_1 -u 0.027194019110781575 > ./result_8chains/node123_7_1.txt &
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
    "./result_8chains/node123_0_1.txt 90"
    "./result_8chains/node123_1_1.txt 89"
    "./result_8chains/node123_2_1.txt 88"
    "./result_8chains/node123_3_1.txt 87"
    "./result_8chains/node123_4_1.txt 86"
    "./result_8chains/node123_5_1.txt 85"
    "./result_8chains/node123_6_1.txt 84"
    "./result_8chains/node123_7_1.txt 83"
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
