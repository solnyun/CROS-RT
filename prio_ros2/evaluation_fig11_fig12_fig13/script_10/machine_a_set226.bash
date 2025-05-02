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
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_2 -p 191 -st topic226_0_1 -pt None -u 0.01128017752019117 > ./result_10chains/node226_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_2 -p 270 -st topic226_1_1 -pt None -u 0.0225228063427374 > ./result_10chains/node226_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_2 -p 343 -st topic226_2_1 -pt None -u 0.0019562355662491315 > ./result_10chains/node226_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_2 -p 416 -st topic226_3_1 -pt None -u 0.02150466117542349 > ./result_10chains/node226_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_2 -p 523 -st topic226_4_1 -pt None -u 0.007700057375127856 > ./result_10chains/node226_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_2 -p 555 -st topic226_5_1 -pt None -u 0.016346171795123154 > ./result_10chains/node226_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_6_2 -p 567 -st topic226_6_1 -pt None -u 0.03244289276932624 > ./result_10chains/node226_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_7_2 -p 775 -st topic226_7_1 -pt None -u 0.006349912113668213 > ./result_10chains/node226_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_8_2 -p 811 -st topic226_8_1 -pt None -u 0.004914443175792038 > ./result_10chains/node226_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_9_2 -p 960 -st topic226_9_1 -pt None -u 0.041072367843370594 > ./result_10chains/node226_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_0 -p 191 -st none -pt topic226_0_0 -u 0.000696532010810269 > ./result_10chains/node226_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_0 -p 270 -st none -pt topic226_1_0 -u 0.013279438966972368 > ./result_10chains/node226_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_0 -p 343 -st none -pt topic226_2_0 -u 0.004650570718166491 > ./result_10chains/node226_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_0 -p 416 -st none -pt topic226_3_0 -u 0.0011165814248577655 > ./result_10chains/node226_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_0 -p 523 -st none -pt topic226_4_0 -u 0.015129016154110775 > ./result_10chains/node226_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_0 -p 555 -st none -pt topic226_5_0 -u 0.028341762374592128 > ./result_10chains/node226_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_6_0 -p 567 -st none -pt topic226_6_0 -u 0.006842398526062998 > ./result_10chains/node226_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_7_0 -p 775 -st none -pt topic226_7_0 -u 0.07686084869692754 > ./result_10chains/node226_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_8_0 -p 811 -st none -pt topic226_8_0 -u 0.01354979827109666 > ./result_10chains/node226_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node226_9_0 -p 960 -st none -pt topic226_9_0 -u 0.0277778740954533 > ./result_10chains/node226_9_0.txt &
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
    "./result_10chains/node226_0_0.txt 90"
    "./result_10chains/node226_0_2.txt 90"
    "./result_10chains/node226_1_0.txt 89"
    "./result_10chains/node226_1_2.txt 89"
    "./result_10chains/node226_2_0.txt 88"
    "./result_10chains/node226_2_2.txt 88"
    "./result_10chains/node226_3_0.txt 87"
    "./result_10chains/node226_3_2.txt 87"
    "./result_10chains/node226_4_0.txt 86"
    "./result_10chains/node226_4_2.txt 86"
    "./result_10chains/node226_5_0.txt 85"
    "./result_10chains/node226_5_2.txt 85"
    "./result_10chains/node226_6_0.txt 84"
    "./result_10chains/node226_6_2.txt 84"
    "./result_10chains/node226_7_0.txt 83"
    "./result_10chains/node226_7_2.txt 83"
    "./result_10chains/node226_8_0.txt 82"
    "./result_10chains/node226_8_2.txt 82"
    "./result_10chains/node226_9_0.txt 81"
    "./result_10chains/node226_9_2.txt 81"
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
