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
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_2 -p 164 -st topic441_0_1 -pt None -u 0.004250712270462809 > ./result_10chains/node441_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_2 -p 201 -st topic441_1_1 -pt None -u 0.00929928605031749 > ./result_10chains/node441_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_2 -p 247 -st topic441_2_1 -pt None -u 0.01938625904808644 > ./result_10chains/node441_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_2 -p 295 -st topic441_3_1 -pt None -u 0.003671615915718518 > ./result_10chains/node441_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_2 -p 478 -st topic441_4_1 -pt None -u 0.020319021986088037 > ./result_10chains/node441_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_2 -p 740 -st topic441_5_1 -pt None -u 0.008073976203610944 > ./result_10chains/node441_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_6_2 -p 758 -st topic441_6_1 -pt None -u 0.029615868975551407 > ./result_10chains/node441_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_7_2 -p 850 -st topic441_7_1 -pt None -u 0.02311181423352862 > ./result_10chains/node441_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_8_2 -p 854 -st topic441_8_1 -pt None -u 0.05192673241100822 > ./result_10chains/node441_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_9_2 -p 864 -st topic441_9_1 -pt None -u 0.01086938850898964 > ./result_10chains/node441_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_0 -p 164 -st none -pt topic441_0_0 -u 0.0008452367943542205 > ./result_10chains/node441_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_0 -p 201 -st none -pt topic441_1_0 -u 0.003834960475276372 > ./result_10chains/node441_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_0 -p 247 -st none -pt topic441_2_0 -u 0.01111104782047373 > ./result_10chains/node441_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_0 -p 295 -st none -pt topic441_3_0 -u 0.008968638442644172 > ./result_10chains/node441_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_0 -p 478 -st none -pt topic441_4_0 -u 0.06479446211085299 > ./result_10chains/node441_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_0 -p 740 -st none -pt topic441_5_0 -u 0.015253942300678947 > ./result_10chains/node441_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_6_0 -p 758 -st none -pt topic441_6_0 -u 0.042265999878350696 > ./result_10chains/node441_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_7_0 -p 850 -st none -pt topic441_7_0 -u 0.004307022460108667 > ./result_10chains/node441_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_8_0 -p 854 -st none -pt topic441_8_0 -u 0.06613685417843636 > ./result_10chains/node441_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_9_0 -p 864 -st none -pt topic441_9_0 -u 0.00836046800538415 > ./result_10chains/node441_9_0.txt &
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
    "./result_10chains/node441_0_0.txt 90"
    "./result_10chains/node441_0_2.txt 90"
    "./result_10chains/node441_1_0.txt 89"
    "./result_10chains/node441_1_2.txt 89"
    "./result_10chains/node441_2_0.txt 88"
    "./result_10chains/node441_2_2.txt 88"
    "./result_10chains/node441_3_0.txt 87"
    "./result_10chains/node441_3_2.txt 87"
    "./result_10chains/node441_4_0.txt 86"
    "./result_10chains/node441_4_2.txt 86"
    "./result_10chains/node441_5_0.txt 85"
    "./result_10chains/node441_5_2.txt 85"
    "./result_10chains/node441_6_0.txt 84"
    "./result_10chains/node441_6_2.txt 84"
    "./result_10chains/node441_7_0.txt 83"
    "./result_10chains/node441_7_2.txt 83"
    "./result_10chains/node441_8_0.txt 82"
    "./result_10chains/node441_8_2.txt 82"
    "./result_10chains/node441_9_0.txt 81"
    "./result_10chains/node441_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
