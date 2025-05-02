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
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_2 -p 45 -st topic160_0_1 -pt None -u 0.0028064658505315143 > ./result_8chains/node160_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_2 -p 155 -st topic160_1_1 -pt None -u 0.042610455875244646 > ./result_8chains/node160_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_2 -p 321 -st topic160_2_1 -pt None -u 0.02594421977069533 > ./result_8chains/node160_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_2 -p 494 -st topic160_3_1 -pt None -u 0.010268755256967688 > ./result_8chains/node160_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_2 -p 512 -st topic160_4_1 -pt None -u 0.003507090966546056 > ./result_8chains/node160_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_2 -p 873 -st topic160_5_1 -pt None -u 0.047363222387098086 > ./result_8chains/node160_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_6_2 -p 959 -st topic160_6_1 -pt None -u 0.019700340203189594 > ./result_8chains/node160_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_7_2 -p 966 -st topic160_7_1 -pt None -u 0.0260104030283064 > ./result_8chains/node160_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_0 -p 45 -st none -pt topic160_0_0 -u 0.0020248983438543866 > ./result_8chains/node160_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_0 -p 155 -st none -pt topic160_1_0 -u 0.013563163356054064 > ./result_8chains/node160_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_0 -p 321 -st none -pt topic160_2_0 -u 0.011974290608805505 > ./result_8chains/node160_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_0 -p 494 -st none -pt topic160_3_0 -u 0.03459120239884597 > ./result_8chains/node160_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_0 -p 512 -st none -pt topic160_4_0 -u 0.010710564488283808 > ./result_8chains/node160_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_0 -p 873 -st none -pt topic160_5_0 -u 0.016901735459245254 > ./result_8chains/node160_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_6_0 -p 959 -st none -pt topic160_6_0 -u 0.0044084609847483275 > ./result_8chains/node160_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_7_0 -p 966 -st none -pt topic160_7_0 -u 0.002169558636929178 > ./result_8chains/node160_7_0.txt &
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
    "./result_8chains/node160_0_0.txt 90"
    "./result_8chains/node160_0_2.txt 90"
    "./result_8chains/node160_1_0.txt 89"
    "./result_8chains/node160_1_2.txt 89"
    "./result_8chains/node160_2_0.txt 88"
    "./result_8chains/node160_2_2.txt 88"
    "./result_8chains/node160_3_0.txt 87"
    "./result_8chains/node160_3_2.txt 87"
    "./result_8chains/node160_4_0.txt 86"
    "./result_8chains/node160_4_2.txt 86"
    "./result_8chains/node160_5_0.txt 85"
    "./result_8chains/node160_5_2.txt 85"
    "./result_8chains/node160_6_0.txt 84"
    "./result_8chains/node160_6_2.txt 84"
    "./result_8chains/node160_7_0.txt 83"
    "./result_8chains/node160_7_2.txt 83"
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
