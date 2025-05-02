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
ros2 run evaluation_3_randomdag uunifast_node -n node24_0_1 -p 90 -st topic24_0_0 -pt topic24_0_1 -u 0.022244749707445277 > ./result_10chains/node24_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_1_1 -p 185 -st topic24_1_0 -pt topic24_1_1 -u 0.02074149353008725 > ./result_10chains/node24_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_2_1 -p 368 -st topic24_2_0 -pt topic24_2_1 -u 2.2512879310210288e-06 > ./result_10chains/node24_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_3_1 -p 447 -st topic24_3_0 -pt topic24_3_1 -u 0.002907868754910947 > ./result_10chains/node24_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_4_1 -p 450 -st topic24_4_0 -pt topic24_4_1 -u 0.026354015850877766 > ./result_10chains/node24_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_5_1 -p 476 -st topic24_5_0 -pt topic24_5_1 -u 0.03546111164331184 > ./result_10chains/node24_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_6_1 -p 723 -st topic24_6_0 -pt topic24_6_1 -u 0.0028875565841359196 > ./result_10chains/node24_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_7_1 -p 725 -st topic24_7_0 -pt topic24_7_1 -u 0.0173854186889493 > ./result_10chains/node24_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_8_1 -p 869 -st topic24_8_0 -pt topic24_8_1 -u 0.002183932893922765 > ./result_10chains/node24_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node24_9_1 -p 906 -st topic24_9_0 -pt topic24_9_1 -u 0.00031755477581476183 > ./result_10chains/node24_9_1.txt &
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
    "./result_10chains/node24_0_1.txt 90"
    "./result_10chains/node24_1_1.txt 89"
    "./result_10chains/node24_2_1.txt 88"
    "./result_10chains/node24_3_1.txt 87"
    "./result_10chains/node24_4_1.txt 86"
    "./result_10chains/node24_5_1.txt 85"
    "./result_10chains/node24_6_1.txt 84"
    "./result_10chains/node24_7_1.txt 83"
    "./result_10chains/node24_8_1.txt 82"
    "./result_10chains/node24_9_1.txt 81"
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
