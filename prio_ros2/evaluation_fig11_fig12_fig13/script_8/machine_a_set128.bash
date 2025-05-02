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
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_2 -p 135 -st topic128_0_1 -pt None -u 0.021956982017040605 > ./result_8chains/node128_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_2 -p 362 -st topic128_1_1 -pt None -u 0.03126579160571197 > ./result_8chains/node128_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_2 -p 419 -st topic128_2_1 -pt None -u 0.005370322002888839 > ./result_8chains/node128_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_2 -p 509 -st topic128_3_1 -pt None -u 0.04288603636542768 > ./result_8chains/node128_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_2 -p 573 -st topic128_4_1 -pt None -u 0.029690669939577252 > ./result_8chains/node128_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_2 -p 718 -st topic128_5_1 -pt None -u 0.007448630116183075 > ./result_8chains/node128_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_6_2 -p 732 -st topic128_6_1 -pt None -u 0.008594590192312093 > ./result_8chains/node128_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_7_2 -p 811 -st topic128_7_1 -pt None -u 0.013975308530429713 > ./result_8chains/node128_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_0 -p 135 -st none -pt topic128_0_0 -u 0.02000791080578912 > ./result_8chains/node128_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_0 -p 362 -st none -pt topic128_1_0 -u 0.0024914679400676043 > ./result_8chains/node128_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_0 -p 419 -st none -pt topic128_2_0 -u 0.01922436577610609 > ./result_8chains/node128_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_0 -p 509 -st none -pt topic128_3_0 -u 0.00768225444413001 > ./result_8chains/node128_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_0 -p 573 -st none -pt topic128_4_0 -u 0.0029168157739107026 > ./result_8chains/node128_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_0 -p 718 -st none -pt topic128_5_0 -u 0.019872757991769158 > ./result_8chains/node128_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_6_0 -p 732 -st none -pt topic128_6_0 -u 0.03679391715628122 > ./result_8chains/node128_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_7_0 -p 811 -st none -pt topic128_7_0 -u 0.0014079532952888212 > ./result_8chains/node128_7_0.txt &
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
    "./result_8chains/node128_0_0.txt 90"
    "./result_8chains/node128_0_2.txt 90"
    "./result_8chains/node128_1_0.txt 89"
    "./result_8chains/node128_1_2.txt 89"
    "./result_8chains/node128_2_0.txt 88"
    "./result_8chains/node128_2_2.txt 88"
    "./result_8chains/node128_3_0.txt 87"
    "./result_8chains/node128_3_2.txt 87"
    "./result_8chains/node128_4_0.txt 86"
    "./result_8chains/node128_4_2.txt 86"
    "./result_8chains/node128_5_0.txt 85"
    "./result_8chains/node128_5_2.txt 85"
    "./result_8chains/node128_6_0.txt 84"
    "./result_8chains/node128_6_2.txt 84"
    "./result_8chains/node128_7_0.txt 83"
    "./result_8chains/node128_7_2.txt 83"
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
