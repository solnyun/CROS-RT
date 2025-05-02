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
ros2 run evaluation_3_randomdag uunifast_node -n node256_0_2 -p 47 -st topic256_0_1 -pt None -u 0.008589166799572112 > ./result_8chains/node256_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_1_2 -p 271 -st topic256_1_1 -pt None -u 0.010299197007636707 > ./result_8chains/node256_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_2_2 -p 273 -st topic256_2_1 -pt None -u 0.004577304907218527 > ./result_8chains/node256_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_3_2 -p 741 -st topic256_3_1 -pt None -u 0.0192005351532063 > ./result_8chains/node256_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_4_2 -p 760 -st topic256_4_1 -pt None -u 0.04368931199338 > ./result_8chains/node256_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_5_2 -p 768 -st topic256_5_1 -pt None -u 0.06728144141481728 > ./result_8chains/node256_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_6_2 -p 911 -st topic256_6_1 -pt None -u 0.03093487896248407 > ./result_8chains/node256_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_7_2 -p 935 -st topic256_7_1 -pt None -u 0.016122152561884505 > ./result_8chains/node256_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_0_0 -p 47 -st none -pt topic256_0_0 -u 0.02359981959105889 > ./result_8chains/node256_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_1_0 -p 271 -st none -pt topic256_1_0 -u 0.0009986926889943293 > ./result_8chains/node256_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_2_0 -p 273 -st none -pt topic256_2_0 -u 0.00046463306326999243 > ./result_8chains/node256_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_3_0 -p 741 -st none -pt topic256_3_0 -u 0.0018934738542507046 > ./result_8chains/node256_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_4_0 -p 760 -st none -pt topic256_4_0 -u 0.028505579341762177 > ./result_8chains/node256_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_5_0 -p 768 -st none -pt topic256_5_0 -u 0.012869199714650281 > ./result_8chains/node256_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_6_0 -p 911 -st none -pt topic256_6_0 -u 0.02011064079927663 > ./result_8chains/node256_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node256_7_0 -p 935 -st none -pt topic256_7_0 -u 0.016761258581915097 > ./result_8chains/node256_7_0.txt &
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
    "./result_8chains/node256_0_0.txt 90"
    "./result_8chains/node256_0_2.txt 90"
    "./result_8chains/node256_1_0.txt 89"
    "./result_8chains/node256_1_2.txt 89"
    "./result_8chains/node256_2_0.txt 88"
    "./result_8chains/node256_2_2.txt 88"
    "./result_8chains/node256_3_0.txt 87"
    "./result_8chains/node256_3_2.txt 87"
    "./result_8chains/node256_4_0.txt 86"
    "./result_8chains/node256_4_2.txt 86"
    "./result_8chains/node256_5_0.txt 85"
    "./result_8chains/node256_5_2.txt 85"
    "./result_8chains/node256_6_0.txt 84"
    "./result_8chains/node256_6_2.txt 84"
    "./result_8chains/node256_7_0.txt 83"
    "./result_8chains/node256_7_2.txt 83"
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
