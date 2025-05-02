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
ros2 run evaluation_3_randomdag uunifast_node -n node209_0_2 -p 45 -st topic209_0_1 -pt None -u 0.01999427909385082 > ./result_8chains/node209_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_1_2 -p 88 -st topic209_1_1 -pt None -u 0.033010160179295756 > ./result_8chains/node209_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_2_2 -p 192 -st topic209_2_1 -pt None -u 0.005700134767546328 > ./result_8chains/node209_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_3_2 -p 535 -st topic209_3_1 -pt None -u 0.05077533060494149 > ./result_8chains/node209_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_4_2 -p 617 -st topic209_4_1 -pt None -u 0.012887692224449465 > ./result_8chains/node209_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_5_2 -p 714 -st topic209_5_1 -pt None -u 0.024935122514843047 > ./result_8chains/node209_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_6_2 -p 992 -st topic209_6_1 -pt None -u 0.012665058433683058 > ./result_8chains/node209_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_7_2 -p 997 -st topic209_7_1 -pt None -u 0.004947144121067855 > ./result_8chains/node209_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_0_0 -p 45 -st none -pt topic209_0_0 -u 0.008341917046017888 > ./result_8chains/node209_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_1_0 -p 88 -st none -pt topic209_1_0 -u 0.021805352399779154 > ./result_8chains/node209_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_2_0 -p 192 -st none -pt topic209_2_0 -u 0.045304990995460925 > ./result_8chains/node209_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_3_0 -p 535 -st none -pt topic209_3_0 -u 0.012226286133347863 > ./result_8chains/node209_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_4_0 -p 617 -st none -pt topic209_4_0 -u 0.008530819512876181 > ./result_8chains/node209_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_5_0 -p 714 -st none -pt topic209_5_0 -u 0.008127000399085288 > ./result_8chains/node209_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_6_0 -p 992 -st none -pt topic209_6_0 -u 0.015570724367757235 > ./result_8chains/node209_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_7_0 -p 997 -st none -pt topic209_7_0 -u 0.006123197853179399 > ./result_8chains/node209_7_0.txt &
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
    "./result_8chains/node209_0_0.txt 90"
    "./result_8chains/node209_0_2.txt 90"
    "./result_8chains/node209_1_0.txt 89"
    "./result_8chains/node209_1_2.txt 89"
    "./result_8chains/node209_2_0.txt 88"
    "./result_8chains/node209_2_2.txt 88"
    "./result_8chains/node209_3_0.txt 87"
    "./result_8chains/node209_3_2.txt 87"
    "./result_8chains/node209_4_0.txt 86"
    "./result_8chains/node209_4_2.txt 86"
    "./result_8chains/node209_5_0.txt 85"
    "./result_8chains/node209_5_2.txt 85"
    "./result_8chains/node209_6_0.txt 84"
    "./result_8chains/node209_6_2.txt 84"
    "./result_8chains/node209_7_0.txt 83"
    "./result_8chains/node209_7_2.txt 83"
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
