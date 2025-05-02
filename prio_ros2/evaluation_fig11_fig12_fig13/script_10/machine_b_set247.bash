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
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_1 -p 104 -st topic247_0_0 -pt topic247_0_1 -u 0.01739724703887946 > ./result_10chains/node247_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_1 -p 105 -st topic247_1_0 -pt topic247_1_1 -u 0.0036230730175155212 > ./result_10chains/node247_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_1 -p 214 -st topic247_2_0 -pt topic247_2_1 -u 0.016981802119595546 > ./result_10chains/node247_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_1 -p 244 -st topic247_3_0 -pt topic247_3_1 -u 5.1683424620641016e-05 > ./result_10chains/node247_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_1 -p 372 -st topic247_4_0 -pt topic247_4_1 -u 0.006463119505568771 > ./result_10chains/node247_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_1 -p 418 -st topic247_5_0 -pt topic247_5_1 -u 0.005134672856925648 > ./result_10chains/node247_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_6_1 -p 550 -st topic247_6_0 -pt topic247_6_1 -u 0.0009111747881516696 > ./result_10chains/node247_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_7_1 -p 684 -st topic247_7_0 -pt topic247_7_1 -u 0.010233287666739116 > ./result_10chains/node247_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_8_1 -p 754 -st topic247_8_0 -pt topic247_8_1 -u 0.007181202511291784 > ./result_10chains/node247_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_9_1 -p 857 -st topic247_9_0 -pt topic247_9_1 -u 0.011234579102509856 > ./result_10chains/node247_9_1.txt &
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
    "./result_10chains/node247_0_1.txt 90"
    "./result_10chains/node247_1_1.txt 89"
    "./result_10chains/node247_2_1.txt 88"
    "./result_10chains/node247_3_1.txt 87"
    "./result_10chains/node247_4_1.txt 86"
    "./result_10chains/node247_5_1.txt 85"
    "./result_10chains/node247_6_1.txt 84"
    "./result_10chains/node247_7_1.txt 83"
    "./result_10chains/node247_8_1.txt 82"
    "./result_10chains/node247_9_1.txt 81"
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
