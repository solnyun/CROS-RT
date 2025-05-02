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
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_2 -p 12 -st topic484_0_1 -pt None -u 0.0009538019108025764 > ./result_10chains/node484_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_2 -p 40 -st topic484_1_1 -pt None -u 0.0038938876937116285 > ./result_10chains/node484_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_2 -p 147 -st topic484_2_1 -pt None -u 0.012692074201130554 > ./result_10chains/node484_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_2 -p 306 -st topic484_3_1 -pt None -u 0.03466166194232628 > ./result_10chains/node484_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_2 -p 369 -st topic484_4_1 -pt None -u 0.035004342347098816 > ./result_10chains/node484_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_2 -p 391 -st topic484_5_1 -pt None -u 0.004364591991781935 > ./result_10chains/node484_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_6_2 -p 707 -st topic484_6_1 -pt None -u 0.02841489007092146 > ./result_10chains/node484_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_7_2 -p 719 -st topic484_7_1 -pt None -u 0.00536970928307913 > ./result_10chains/node484_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_8_2 -p 823 -st topic484_8_1 -pt None -u 0.051022736798980596 > ./result_10chains/node484_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_9_2 -p 868 -st topic484_9_1 -pt None -u 0.02441567136442986 > ./result_10chains/node484_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_0 -p 12 -st none -pt topic484_0_0 -u 0.021390249707515407 > ./result_10chains/node484_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_0 -p 40 -st none -pt topic484_1_0 -u 0.007445448915440078 > ./result_10chains/node484_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_0 -p 147 -st none -pt topic484_2_0 -u 0.013831458606754277 > ./result_10chains/node484_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_0 -p 306 -st none -pt topic484_3_0 -u 0.02557044542628062 > ./result_10chains/node484_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_0 -p 369 -st none -pt topic484_4_0 -u 0.015003905296489428 > ./result_10chains/node484_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_0 -p 391 -st none -pt topic484_5_0 -u 0.047634327623636175 > ./result_10chains/node484_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_6_0 -p 707 -st none -pt topic484_6_0 -u 0.008904051220397502 > ./result_10chains/node484_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_7_0 -p 719 -st none -pt topic484_7_0 -u 0.023760280598525085 > ./result_10chains/node484_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_8_0 -p 823 -st none -pt topic484_8_0 -u 0.0009298331607983518 > ./result_10chains/node484_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_9_0 -p 868 -st none -pt topic484_9_0 -u 0.03229425318095348 > ./result_10chains/node484_9_0.txt &
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
    "./result_10chains/node484_0_0.txt 90"
    "./result_10chains/node484_0_2.txt 90"
    "./result_10chains/node484_1_0.txt 89"
    "./result_10chains/node484_1_2.txt 89"
    "./result_10chains/node484_2_0.txt 88"
    "./result_10chains/node484_2_2.txt 88"
    "./result_10chains/node484_3_0.txt 87"
    "./result_10chains/node484_3_2.txt 87"
    "./result_10chains/node484_4_0.txt 86"
    "./result_10chains/node484_4_2.txt 86"
    "./result_10chains/node484_5_0.txt 85"
    "./result_10chains/node484_5_2.txt 85"
    "./result_10chains/node484_6_0.txt 84"
    "./result_10chains/node484_6_2.txt 84"
    "./result_10chains/node484_7_0.txt 83"
    "./result_10chains/node484_7_2.txt 83"
    "./result_10chains/node484_8_0.txt 82"
    "./result_10chains/node484_8_2.txt 82"
    "./result_10chains/node484_9_0.txt 81"
    "./result_10chains/node484_9_2.txt 81"
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
