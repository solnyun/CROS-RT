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
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_2 -p 155 -st topic484_0_1 -pt None -u 0.004466001413748533 > ./result_8chains/node484_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_2 -p 181 -st topic484_1_1 -pt None -u 0.004767467523860314 > ./result_8chains/node484_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_2 -p 373 -st topic484_2_1 -pt None -u 0.02287324598229512 > ./result_8chains/node484_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_2 -p 379 -st topic484_3_1 -pt None -u 0.009487977626646216 > ./result_8chains/node484_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_2 -p 432 -st topic484_4_1 -pt None -u 0.0007697023433698158 > ./result_8chains/node484_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_2 -p 478 -st topic484_5_1 -pt None -u 0.06147967614651681 > ./result_8chains/node484_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_6_2 -p 527 -st topic484_6_1 -pt None -u 0.007765623487789017 > ./result_8chains/node484_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_7_2 -p 984 -st topic484_7_1 -pt None -u 0.004948382638421233 > ./result_8chains/node484_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_0 -p 155 -st none -pt topic484_0_0 -u 0.01117187867536279 > ./result_8chains/node484_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_0 -p 181 -st none -pt topic484_1_0 -u 0.01582830298942034 > ./result_8chains/node484_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_0 -p 373 -st none -pt topic484_2_0 -u 0.02234736122312586 > ./result_8chains/node484_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_0 -p 379 -st none -pt topic484_3_0 -u 0.022984241073496725 > ./result_8chains/node484_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_0 -p 432 -st none -pt topic484_4_0 -u 0.0185399957590327 > ./result_8chains/node484_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_0 -p 478 -st none -pt topic484_5_0 -u 0.010665226236002995 > ./result_8chains/node484_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_6_0 -p 527 -st none -pt topic484_6_0 -u 0.003918636841449705 > ./result_8chains/node484_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_7_0 -p 984 -st none -pt topic484_7_0 -u 0.04973226797055137 > ./result_8chains/node484_7_0.txt &
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
    "./result_8chains/node484_0_0.txt 90"
    "./result_8chains/node484_0_2.txt 90"
    "./result_8chains/node484_1_0.txt 89"
    "./result_8chains/node484_1_2.txt 89"
    "./result_8chains/node484_2_0.txt 88"
    "./result_8chains/node484_2_2.txt 88"
    "./result_8chains/node484_3_0.txt 87"
    "./result_8chains/node484_3_2.txt 87"
    "./result_8chains/node484_4_0.txt 86"
    "./result_8chains/node484_4_2.txt 86"
    "./result_8chains/node484_5_0.txt 85"
    "./result_8chains/node484_5_2.txt 85"
    "./result_8chains/node484_6_0.txt 84"
    "./result_8chains/node484_6_2.txt 84"
    "./result_8chains/node484_7_0.txt 83"
    "./result_8chains/node484_7_2.txt 83"
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
