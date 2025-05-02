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
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_1 -p 60 -st topic139_0_0 -pt topic139_0_1 -u 0.00903729200815534 > ./result_8chains/node139_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_1 -p 158 -st topic139_1_0 -pt topic139_1_1 -u 0.001134323629904288 > ./result_8chains/node139_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_1 -p 226 -st topic139_2_0 -pt topic139_2_1 -u 0.005721017005854867 > ./result_8chains/node139_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_1 -p 329 -st topic139_3_0 -pt topic139_3_1 -u 0.010994706439542867 > ./result_8chains/node139_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_1 -p 598 -st topic139_4_0 -pt topic139_4_1 -u 0.004525079264149995 > ./result_8chains/node139_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_1 -p 604 -st topic139_5_0 -pt topic139_5_1 -u 0.04218964639709867 > ./result_8chains/node139_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_6_1 -p 915 -st topic139_6_0 -pt topic139_6_1 -u 0.02203341164990061 > ./result_8chains/node139_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_7_1 -p 947 -st topic139_7_0 -pt topic139_7_1 -u 0.010399457229471103 > ./result_8chains/node139_7_1.txt &
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
    "./result_8chains/node139_0_1.txt 90"
    "./result_8chains/node139_1_1.txt 89"
    "./result_8chains/node139_2_1.txt 88"
    "./result_8chains/node139_3_1.txt 87"
    "./result_8chains/node139_4_1.txt 86"
    "./result_8chains/node139_5_1.txt 85"
    "./result_8chains/node139_6_1.txt 84"
    "./result_8chains/node139_7_1.txt 83"
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
