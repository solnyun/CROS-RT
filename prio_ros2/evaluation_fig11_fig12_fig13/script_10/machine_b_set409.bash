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
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_1 -p 341 -st topic409_0_0 -pt topic409_0_1 -u 0.027100497242373733 > ./result_10chains/node409_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_1 -p 445 -st topic409_1_0 -pt topic409_1_1 -u 0.03490805423126059 > ./result_10chains/node409_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_1 -p 467 -st topic409_2_0 -pt topic409_2_1 -u 0.022527528124847707 > ./result_10chains/node409_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_1 -p 482 -st topic409_3_0 -pt topic409_3_1 -u 0.004328574576884903 > ./result_10chains/node409_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_1 -p 551 -st topic409_4_0 -pt topic409_4_1 -u 0.006645596246711377 > ./result_10chains/node409_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_1 -p 644 -st topic409_5_0 -pt topic409_5_1 -u 0.00889712641885776 > ./result_10chains/node409_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_6_1 -p 667 -st topic409_6_0 -pt topic409_6_1 -u 0.03819278158279049 > ./result_10chains/node409_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_7_1 -p 701 -st topic409_7_0 -pt topic409_7_1 -u 0.004123914272491078 > ./result_10chains/node409_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_8_1 -p 720 -st topic409_8_0 -pt topic409_8_1 -u 0.020385734775056702 > ./result_10chains/node409_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_9_1 -p 868 -st topic409_9_0 -pt topic409_9_1 -u 0.01928320765371793 > ./result_10chains/node409_9_1.txt &
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
    "./result_10chains/node409_0_1.txt 90"
    "./result_10chains/node409_1_1.txt 89"
    "./result_10chains/node409_2_1.txt 88"
    "./result_10chains/node409_3_1.txt 87"
    "./result_10chains/node409_4_1.txt 86"
    "./result_10chains/node409_5_1.txt 85"
    "./result_10chains/node409_6_1.txt 84"
    "./result_10chains/node409_7_1.txt 83"
    "./result_10chains/node409_8_1.txt 82"
    "./result_10chains/node409_9_1.txt 81"
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
