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
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_2 -p 168 -st topic494_0_1 -pt None -u 0.003162367376188746 > ./result_8chains/node494_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_2 -p 281 -st topic494_1_1 -pt None -u 0.0012900688809383554 > ./result_8chains/node494_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_2 -p 486 -st topic494_2_1 -pt None -u 0.03884699836868982 > ./result_8chains/node494_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_2 -p 763 -st topic494_3_1 -pt None -u 0.007291123176896952 > ./result_8chains/node494_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_2 -p 814 -st topic494_4_1 -pt None -u 0.004644565154718616 > ./result_8chains/node494_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_2 -p 931 -st topic494_5_1 -pt None -u 0.04800158292951626 > ./result_8chains/node494_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_6_2 -p 971 -st topic494_6_1 -pt None -u 0.008266069604224553 > ./result_8chains/node494_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_7_2 -p 997 -st topic494_7_1 -pt None -u 0.025127014520267468 > ./result_8chains/node494_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_0_0 -p 168 -st none -pt topic494_0_0 -u 0.0358892690605202 > ./result_8chains/node494_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_1_0 -p 281 -st none -pt topic494_1_0 -u 0.020694288788534743 > ./result_8chains/node494_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_2_0 -p 486 -st none -pt topic494_2_0 -u 0.010897020039271121 > ./result_8chains/node494_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_3_0 -p 763 -st none -pt topic494_3_0 -u 0.015320099660911857 > ./result_8chains/node494_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_4_0 -p 814 -st none -pt topic494_4_0 -u 0.04582228630151769 > ./result_8chains/node494_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_5_0 -p 931 -st none -pt topic494_5_0 -u 0.009271348379142064 > ./result_8chains/node494_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node494_6_0 -p 971 -st none -pt topic494_6_0 -u 0.004132407726107734 > ./result_8chains/node494_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node494_7_0 -p 997 -st none -pt topic494_7_0 -u 0.006092046626059111 > ./result_8chains/node494_7_0.txt &
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
    "./result_8chains/node494_0_0.txt 90"
    "./result_8chains/node494_0_2.txt 90"
    "./result_8chains/node494_1_0.txt 89"
    "./result_8chains/node494_1_2.txt 89"
    "./result_8chains/node494_2_0.txt 88"
    "./result_8chains/node494_2_2.txt 88"
    "./result_8chains/node494_3_0.txt 87"
    "./result_8chains/node494_3_2.txt 87"
    "./result_8chains/node494_4_0.txt 86"
    "./result_8chains/node494_4_2.txt 86"
    "./result_8chains/node494_5_0.txt 85"
    "./result_8chains/node494_5_2.txt 85"
    "./result_8chains/node494_6_0.txt 84"
    "./result_8chains/node494_6_2.txt 84"
    "./result_8chains/node494_7_0.txt 83"
    "./result_8chains/node494_7_2.txt 83"
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
