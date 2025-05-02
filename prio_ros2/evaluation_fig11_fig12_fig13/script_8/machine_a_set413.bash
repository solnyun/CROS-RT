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
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_2 -p 108 -st topic413_0_1 -pt None -u 0.00738445085032402 > ./result_8chains/node413_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_2 -p 192 -st topic413_1_1 -pt None -u 0.0010824801521756577 > ./result_8chains/node413_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_2 -p 561 -st topic413_2_1 -pt None -u 0.009908836409889377 > ./result_8chains/node413_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_2 -p 702 -st topic413_3_1 -pt None -u 0.01721539197655747 > ./result_8chains/node413_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_2 -p 784 -st topic413_4_1 -pt None -u 0.008125604945905751 > ./result_8chains/node413_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_2 -p 866 -st topic413_5_1 -pt None -u 0.012692682944280831 > ./result_8chains/node413_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_6_2 -p 919 -st topic413_6_1 -pt None -u 0.0007855089491546757 > ./result_8chains/node413_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_7_2 -p 925 -st topic413_7_1 -pt None -u 0.05747543999243483 > ./result_8chains/node413_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_0 -p 108 -st none -pt topic413_0_0 -u 0.023111844502159584 > ./result_8chains/node413_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_0 -p 192 -st none -pt topic413_1_0 -u 0.03596738723609311 > ./result_8chains/node413_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_0 -p 561 -st none -pt topic413_2_0 -u 0.014142553959129778 > ./result_8chains/node413_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_0 -p 702 -st none -pt topic413_3_0 -u 0.007923395793878352 > ./result_8chains/node413_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_0 -p 784 -st none -pt topic413_4_0 -u 0.006560696140277489 > ./result_8chains/node413_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_0 -p 866 -st none -pt topic413_5_0 -u 0.058253231030791996 > ./result_8chains/node413_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_6_0 -p 919 -st none -pt topic413_6_0 -u 0.05144822272253305 > ./result_8chains/node413_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node413_7_0 -p 925 -st none -pt topic413_7_0 -u 0.0510047313437718 > ./result_8chains/node413_7_0.txt &
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
    "./result_8chains/node413_0_0.txt 90"
    "./result_8chains/node413_0_2.txt 90"
    "./result_8chains/node413_1_0.txt 89"
    "./result_8chains/node413_1_2.txt 89"
    "./result_8chains/node413_2_0.txt 88"
    "./result_8chains/node413_2_2.txt 88"
    "./result_8chains/node413_3_0.txt 87"
    "./result_8chains/node413_3_2.txt 87"
    "./result_8chains/node413_4_0.txt 86"
    "./result_8chains/node413_4_2.txt 86"
    "./result_8chains/node413_5_0.txt 85"
    "./result_8chains/node413_5_2.txt 85"
    "./result_8chains/node413_6_0.txt 84"
    "./result_8chains/node413_6_2.txt 84"
    "./result_8chains/node413_7_0.txt 83"
    "./result_8chains/node413_7_2.txt 83"
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
