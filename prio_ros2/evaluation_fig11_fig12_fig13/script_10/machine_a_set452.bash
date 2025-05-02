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
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_2 -p 16 -st topic452_0_1 -pt None -u 0.018137098085548586 > ./result_10chains/node452_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_2 -p 39 -st topic452_1_1 -pt None -u 0.006391853616266263 > ./result_10chains/node452_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_2 -p 49 -st topic452_2_1 -pt None -u 0.007039804465976907 > ./result_10chains/node452_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_2 -p 78 -st topic452_3_1 -pt None -u 0.002008032536880644 > ./result_10chains/node452_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_4_2 -p 267 -st topic452_4_1 -pt None -u 0.002411741479331375 > ./result_10chains/node452_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_5_2 -p 294 -st topic452_5_1 -pt None -u 0.014410868359581552 > ./result_10chains/node452_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_6_2 -p 359 -st topic452_6_1 -pt None -u 0.020824562499145494 > ./result_10chains/node452_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_7_2 -p 746 -st topic452_7_1 -pt None -u 0.021037983584154096 > ./result_10chains/node452_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_8_2 -p 910 -st topic452_8_1 -pt None -u 0.009964087897220517 > ./result_10chains/node452_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_9_2 -p 984 -st topic452_9_1 -pt None -u 0.042969889935509716 > ./result_10chains/node452_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_0 -p 16 -st none -pt topic452_0_0 -u 0.01777937891255882 > ./result_10chains/node452_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_0 -p 39 -st none -pt topic452_1_0 -u 0.02537492393306967 > ./result_10chains/node452_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_0 -p 49 -st none -pt topic452_2_0 -u 0.0761877594556401 > ./result_10chains/node452_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_0 -p 78 -st none -pt topic452_3_0 -u 0.002940114990785503 > ./result_10chains/node452_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_4_0 -p 267 -st none -pt topic452_4_0 -u 0.0008584000133236014 > ./result_10chains/node452_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_5_0 -p 294 -st none -pt topic452_5_0 -u 0.010676999275107957 > ./result_10chains/node452_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_6_0 -p 359 -st none -pt topic452_6_0 -u 0.003582577573663953 > ./result_10chains/node452_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_7_0 -p 746 -st none -pt topic452_7_0 -u 0.0008241215505983279 > ./result_10chains/node452_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_8_0 -p 910 -st none -pt topic452_8_0 -u 0.028949221155384258 > ./result_10chains/node452_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_9_0 -p 984 -st none -pt topic452_9_0 -u 0.007963775676264925 > ./result_10chains/node452_9_0.txt &
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
    "./result_10chains/node452_0_0.txt 90"
    "./result_10chains/node452_0_2.txt 90"
    "./result_10chains/node452_1_0.txt 89"
    "./result_10chains/node452_1_2.txt 89"
    "./result_10chains/node452_2_0.txt 88"
    "./result_10chains/node452_2_2.txt 88"
    "./result_10chains/node452_3_0.txt 87"
    "./result_10chains/node452_3_2.txt 87"
    "./result_10chains/node452_4_0.txt 86"
    "./result_10chains/node452_4_2.txt 86"
    "./result_10chains/node452_5_0.txt 85"
    "./result_10chains/node452_5_2.txt 85"
    "./result_10chains/node452_6_0.txt 84"
    "./result_10chains/node452_6_2.txt 84"
    "./result_10chains/node452_7_0.txt 83"
    "./result_10chains/node452_7_2.txt 83"
    "./result_10chains/node452_8_0.txt 82"
    "./result_10chains/node452_8_2.txt 82"
    "./result_10chains/node452_9_0.txt 81"
    "./result_10chains/node452_9_2.txt 81"
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
