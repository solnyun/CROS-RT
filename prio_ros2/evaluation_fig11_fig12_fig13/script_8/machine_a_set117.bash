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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_2 -p 289 -st topic117_0_1 -pt None -u 0.002309274864600974 > ./result_8chains/node117_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_2 -p 442 -st topic117_1_1 -pt None -u 0.03282999411436499 > ./result_8chains/node117_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_2 -p 541 -st topic117_2_1 -pt None -u 0.008389070946446198 > ./result_8chains/node117_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_2 -p 542 -st topic117_3_1 -pt None -u 0.011431346624012628 > ./result_8chains/node117_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_2 -p 602 -st topic117_4_1 -pt None -u 0.033516885819495856 > ./result_8chains/node117_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_2 -p 716 -st topic117_5_1 -pt None -u 0.04676513813892423 > ./result_8chains/node117_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_6_2 -p 855 -st topic117_6_1 -pt None -u 0.005596148895117024 > ./result_8chains/node117_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_7_2 -p 873 -st topic117_7_1 -pt None -u 0.008538719078627617 > ./result_8chains/node117_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_0 -p 289 -st none -pt topic117_0_0 -u 0.020758897043033908 > ./result_8chains/node117_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_0 -p 442 -st none -pt topic117_1_0 -u 0.06995058369113905 > ./result_8chains/node117_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_0 -p 541 -st none -pt topic117_2_0 -u 0.01493747744582985 > ./result_8chains/node117_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_0 -p 542 -st none -pt topic117_3_0 -u 0.04863545821747678 > ./result_8chains/node117_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_0 -p 602 -st none -pt topic117_4_0 -u 0.011185621006291002 > ./result_8chains/node117_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_0 -p 716 -st none -pt topic117_5_0 -u 0.010969127898857844 > ./result_8chains/node117_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_6_0 -p 855 -st none -pt topic117_6_0 -u 0.0034734625721553752 > ./result_8chains/node117_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_7_0 -p 873 -st none -pt topic117_7_0 -u 0.027197621282722975 > ./result_8chains/node117_7_0.txt &
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
    "./result_8chains/node117_0_0.txt 90"
    "./result_8chains/node117_0_2.txt 90"
    "./result_8chains/node117_1_0.txt 89"
    "./result_8chains/node117_1_2.txt 89"
    "./result_8chains/node117_2_0.txt 88"
    "./result_8chains/node117_2_2.txt 88"
    "./result_8chains/node117_3_0.txt 87"
    "./result_8chains/node117_3_2.txt 87"
    "./result_8chains/node117_4_0.txt 86"
    "./result_8chains/node117_4_2.txt 86"
    "./result_8chains/node117_5_0.txt 85"
    "./result_8chains/node117_5_2.txt 85"
    "./result_8chains/node117_6_0.txt 84"
    "./result_8chains/node117_6_2.txt 84"
    "./result_8chains/node117_7_0.txt 83"
    "./result_8chains/node117_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
