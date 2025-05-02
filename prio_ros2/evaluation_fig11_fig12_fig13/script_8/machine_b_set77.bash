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
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_1 -p 110 -st topic77_0_0 -pt topic77_0_1 -u 0.002387071213287517 > ./result_8chains/node77_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_1 -p 249 -st topic77_1_0 -pt topic77_1_1 -u 0.00923734368156659 > ./result_8chains/node77_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_1 -p 277 -st topic77_2_0 -pt topic77_2_1 -u 0.025871083924262295 > ./result_8chains/node77_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_1 -p 293 -st topic77_3_0 -pt topic77_3_1 -u 0.10798497777362334 > ./result_8chains/node77_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_1 -p 330 -st topic77_4_0 -pt topic77_4_1 -u 0.04663045789020043 > ./result_8chains/node77_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_1 -p 744 -st topic77_5_0 -pt topic77_5_1 -u 0.015521241248390813 > ./result_8chains/node77_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_6_1 -p 747 -st topic77_6_0 -pt topic77_6_1 -u 0.03965849784118152 > ./result_8chains/node77_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_7_1 -p 921 -st topic77_7_0 -pt topic77_7_1 -u 0.012464174342024115 > ./result_8chains/node77_7_1.txt &
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
    "./result_8chains/node77_0_1.txt 90"
    "./result_8chains/node77_1_1.txt 89"
    "./result_8chains/node77_2_1.txt 88"
    "./result_8chains/node77_3_1.txt 87"
    "./result_8chains/node77_4_1.txt 86"
    "./result_8chains/node77_5_1.txt 85"
    "./result_8chains/node77_6_1.txt 84"
    "./result_8chains/node77_7_1.txt 83"
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
