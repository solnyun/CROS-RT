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
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_2 -p 24 -st topic392_0_1 -pt None -u 0.05720611383623986 > ./result_8chains/node392_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_2 -p 107 -st topic392_1_1 -pt None -u 0.01714648315199163 > ./result_8chains/node392_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_2 -p 129 -st topic392_2_1 -pt None -u 0.03449199446640194 > ./result_8chains/node392_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_2 -p 330 -st topic392_3_1 -pt None -u 0.05321624776398104 > ./result_8chains/node392_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_2 -p 332 -st topic392_4_1 -pt None -u 7.075744441695231e-05 > ./result_8chains/node392_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_2 -p 348 -st topic392_5_1 -pt None -u 0.0009334678339485286 > ./result_8chains/node392_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_6_2 -p 382 -st topic392_6_1 -pt None -u 0.03843616534340867 > ./result_8chains/node392_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_7_2 -p 401 -st topic392_7_1 -pt None -u 0.02614677193704731 > ./result_8chains/node392_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_0 -p 24 -st none -pt topic392_0_0 -u 0.03989293519504872 > ./result_8chains/node392_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_0 -p 107 -st none -pt topic392_1_0 -u 0.012445940951527956 > ./result_8chains/node392_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_0 -p 129 -st none -pt topic392_2_0 -u 0.006545449218126664 > ./result_8chains/node392_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_0 -p 330 -st none -pt topic392_3_0 -u 0.0282800109962017 > ./result_8chains/node392_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_0 -p 332 -st none -pt topic392_4_0 -u 0.04741392830777391 > ./result_8chains/node392_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_0 -p 348 -st none -pt topic392_5_0 -u 0.06982647994947552 > ./result_8chains/node392_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_6_0 -p 382 -st none -pt topic392_6_0 -u 0.002351203671379809 > ./result_8chains/node392_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_7_0 -p 401 -st none -pt topic392_7_0 -u 0.015385929589521202 > ./result_8chains/node392_7_0.txt &
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
    "./result_8chains/node392_0_0.txt 90"
    "./result_8chains/node392_0_2.txt 90"
    "./result_8chains/node392_1_0.txt 89"
    "./result_8chains/node392_1_2.txt 89"
    "./result_8chains/node392_2_0.txt 88"
    "./result_8chains/node392_2_2.txt 88"
    "./result_8chains/node392_3_0.txt 87"
    "./result_8chains/node392_3_2.txt 87"
    "./result_8chains/node392_4_0.txt 86"
    "./result_8chains/node392_4_2.txt 86"
    "./result_8chains/node392_5_0.txt 85"
    "./result_8chains/node392_5_2.txt 85"
    "./result_8chains/node392_6_0.txt 84"
    "./result_8chains/node392_6_2.txt 84"
    "./result_8chains/node392_7_0.txt 83"
    "./result_8chains/node392_7_2.txt 83"
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
