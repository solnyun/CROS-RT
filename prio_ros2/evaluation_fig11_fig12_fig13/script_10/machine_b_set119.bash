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
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_1 -p 39 -st topic119_0_0 -pt topic119_0_1 -u 0.01774332979151072 > ./result_10chains/node119_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_1 -p 63 -st topic119_1_0 -pt topic119_1_1 -u 0.0556545441110145 > ./result_10chains/node119_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_1 -p 74 -st topic119_2_0 -pt topic119_2_1 -u 0.008995582540935743 > ./result_10chains/node119_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_1 -p 185 -st topic119_3_0 -pt topic119_3_1 -u 0.001605519779414366 > ./result_10chains/node119_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_1 -p 247 -st topic119_4_0 -pt topic119_4_1 -u 0.0063263297099530325 > ./result_10chains/node119_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_1 -p 388 -st topic119_5_0 -pt topic119_5_1 -u 0.07407798622793116 > ./result_10chains/node119_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_6_1 -p 552 -st topic119_6_0 -pt topic119_6_1 -u 0.004245184403135122 > ./result_10chains/node119_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_7_1 -p 636 -st topic119_7_0 -pt topic119_7_1 -u 0.020094309749711742 > ./result_10chains/node119_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_8_1 -p 713 -st topic119_8_0 -pt topic119_8_1 -u 0.02274016043381829 > ./result_10chains/node119_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_9_1 -p 906 -st topic119_9_0 -pt topic119_9_1 -u 0.011866924553834618 > ./result_10chains/node119_9_1.txt &
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
    "./result_10chains/node119_0_1.txt 90"
    "./result_10chains/node119_1_1.txt 89"
    "./result_10chains/node119_2_1.txt 88"
    "./result_10chains/node119_3_1.txt 87"
    "./result_10chains/node119_4_1.txt 86"
    "./result_10chains/node119_5_1.txt 85"
    "./result_10chains/node119_6_1.txt 84"
    "./result_10chains/node119_7_1.txt 83"
    "./result_10chains/node119_8_1.txt 82"
    "./result_10chains/node119_9_1.txt 81"
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
