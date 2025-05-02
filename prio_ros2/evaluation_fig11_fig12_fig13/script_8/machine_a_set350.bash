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
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_2 -p 362 -st topic350_0_1 -pt None -u 0.014042962959827432 > ./result_8chains/node350_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_2 -p 416 -st topic350_1_1 -pt None -u 0.0040993477758635155 > ./result_8chains/node350_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_2 -p 463 -st topic350_2_1 -pt None -u 0.0004921203145862862 > ./result_8chains/node350_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_2 -p 491 -st topic350_3_1 -pt None -u 0.023023765395069007 > ./result_8chains/node350_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_2 -p 686 -st topic350_4_1 -pt None -u 0.009703748107248389 > ./result_8chains/node350_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_2 -p 859 -st topic350_5_1 -pt None -u 0.047176598209791684 > ./result_8chains/node350_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_6_2 -p 919 -st topic350_6_1 -pt None -u 0.042154238197257776 > ./result_8chains/node350_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_7_2 -p 984 -st topic350_7_1 -pt None -u 0.017039073386194464 > ./result_8chains/node350_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_0 -p 362 -st none -pt topic350_0_0 -u 0.01411033650066773 > ./result_8chains/node350_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_0 -p 416 -st none -pt topic350_1_0 -u 0.0008648122369374622 > ./result_8chains/node350_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_0 -p 463 -st none -pt topic350_2_0 -u 0.005714204186754002 > ./result_8chains/node350_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_0 -p 491 -st none -pt topic350_3_0 -u 0.036737531327769635 > ./result_8chains/node350_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_0 -p 686 -st none -pt topic350_4_0 -u 0.0031111815325713388 > ./result_8chains/node350_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_0 -p 859 -st none -pt topic350_5_0 -u 0.05441208915549542 > ./result_8chains/node350_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_6_0 -p 919 -st none -pt topic350_6_0 -u 0.008409137929660776 > ./result_8chains/node350_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_7_0 -p 984 -st none -pt topic350_7_0 -u 0.04423982653209295 > ./result_8chains/node350_7_0.txt &
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
    "./result_8chains/node350_0_0.txt 90"
    "./result_8chains/node350_0_2.txt 90"
    "./result_8chains/node350_1_0.txt 89"
    "./result_8chains/node350_1_2.txt 89"
    "./result_8chains/node350_2_0.txt 88"
    "./result_8chains/node350_2_2.txt 88"
    "./result_8chains/node350_3_0.txt 87"
    "./result_8chains/node350_3_2.txt 87"
    "./result_8chains/node350_4_0.txt 86"
    "./result_8chains/node350_4_2.txt 86"
    "./result_8chains/node350_5_0.txt 85"
    "./result_8chains/node350_5_2.txt 85"
    "./result_8chains/node350_6_0.txt 84"
    "./result_8chains/node350_6_2.txt 84"
    "./result_8chains/node350_7_0.txt 83"
    "./result_8chains/node350_7_2.txt 83"
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
