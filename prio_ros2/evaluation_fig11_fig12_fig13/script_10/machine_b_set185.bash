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
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_1 -p 38 -st topic185_0_0 -pt topic185_0_1 -u 0.019914908104124107 > ./result_10chains/node185_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_1 -p 80 -st topic185_1_0 -pt topic185_1_1 -u 0.01991064197661263 > ./result_10chains/node185_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_1 -p 222 -st topic185_2_0 -pt topic185_2_1 -u 0.043940144406382775 > ./result_10chains/node185_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_1 -p 249 -st topic185_3_0 -pt topic185_3_1 -u 0.015808286448416864 > ./result_10chains/node185_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_1 -p 529 -st topic185_4_0 -pt topic185_4_1 -u 0.008852818107103061 > ./result_10chains/node185_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_1 -p 542 -st topic185_5_0 -pt topic185_5_1 -u 0.004830684332209789 > ./result_10chains/node185_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_6_1 -p 582 -st topic185_6_0 -pt topic185_6_1 -u 0.014416853543878921 > ./result_10chains/node185_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_7_1 -p 625 -st topic185_7_0 -pt topic185_7_1 -u 0.020524578474487937 > ./result_10chains/node185_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_8_1 -p 711 -st topic185_8_0 -pt topic185_8_1 -u 0.006644880097822478 > ./result_10chains/node185_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_9_1 -p 831 -st topic185_9_0 -pt topic185_9_1 -u 0.0204448421934616 > ./result_10chains/node185_9_1.txt &
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
    "./result_10chains/node185_0_1.txt 90"
    "./result_10chains/node185_1_1.txt 89"
    "./result_10chains/node185_2_1.txt 88"
    "./result_10chains/node185_3_1.txt 87"
    "./result_10chains/node185_4_1.txt 86"
    "./result_10chains/node185_5_1.txt 85"
    "./result_10chains/node185_6_1.txt 84"
    "./result_10chains/node185_7_1.txt 83"
    "./result_10chains/node185_8_1.txt 82"
    "./result_10chains/node185_9_1.txt 81"
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
