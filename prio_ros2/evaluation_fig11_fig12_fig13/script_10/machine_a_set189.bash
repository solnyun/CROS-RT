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
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_2 -p 32 -st topic189_0_1 -pt None -u 0.04355489940778545 > ./result_10chains/node189_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_2 -p 39 -st topic189_1_1 -pt None -u 0.0002961261001397375 > ./result_10chains/node189_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_2 -p 112 -st topic189_2_1 -pt None -u 0.0002673908822432014 > ./result_10chains/node189_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_2 -p 315 -st topic189_3_1 -pt None -u 0.009643941518135135 > ./result_10chains/node189_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_2 -p 358 -st topic189_4_1 -pt None -u 8.818311180147642e-05 > ./result_10chains/node189_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_2 -p 450 -st topic189_5_1 -pt None -u 0.018147918467456614 > ./result_10chains/node189_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_6_2 -p 827 -st topic189_6_1 -pt None -u 0.017063239243311573 > ./result_10chains/node189_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_7_2 -p 830 -st topic189_7_1 -pt None -u 0.0016629954800452956 > ./result_10chains/node189_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_8_2 -p 897 -st topic189_8_1 -pt None -u 0.03398394364628259 > ./result_10chains/node189_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_9_2 -p 931 -st topic189_9_1 -pt None -u 0.00908266261148256 > ./result_10chains/node189_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_0 -p 32 -st none -pt topic189_0_0 -u 0.0053626542848214664 > ./result_10chains/node189_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_0 -p 39 -st none -pt topic189_1_0 -u 0.000359912779953675 > ./result_10chains/node189_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_0 -p 112 -st none -pt topic189_2_0 -u 0.00032946041576548124 > ./result_10chains/node189_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_0 -p 315 -st none -pt topic189_3_0 -u 0.027057116125584313 > ./result_10chains/node189_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_0 -p 358 -st none -pt topic189_4_0 -u 0.0017385931495876306 > ./result_10chains/node189_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_0 -p 450 -st none -pt topic189_5_0 -u 0.003910798984973651 > ./result_10chains/node189_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_6_0 -p 827 -st none -pt topic189_6_0 -u 0.01250916486999426 > ./result_10chains/node189_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_7_0 -p 830 -st none -pt topic189_7_0 -u 0.031498373119896506 > ./result_10chains/node189_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_8_0 -p 897 -st none -pt topic189_8_0 -u 0.025194518977402214 > ./result_10chains/node189_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_9_0 -p 931 -st none -pt topic189_9_0 -u 0.02844720941272606 > ./result_10chains/node189_9_0.txt &
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
    "./result_10chains/node189_0_0.txt 90"
    "./result_10chains/node189_0_2.txt 90"
    "./result_10chains/node189_1_0.txt 89"
    "./result_10chains/node189_1_2.txt 89"
    "./result_10chains/node189_2_0.txt 88"
    "./result_10chains/node189_2_2.txt 88"
    "./result_10chains/node189_3_0.txt 87"
    "./result_10chains/node189_3_2.txt 87"
    "./result_10chains/node189_4_0.txt 86"
    "./result_10chains/node189_4_2.txt 86"
    "./result_10chains/node189_5_0.txt 85"
    "./result_10chains/node189_5_2.txt 85"
    "./result_10chains/node189_6_0.txt 84"
    "./result_10chains/node189_6_2.txt 84"
    "./result_10chains/node189_7_0.txt 83"
    "./result_10chains/node189_7_2.txt 83"
    "./result_10chains/node189_8_0.txt 82"
    "./result_10chains/node189_8_2.txt 82"
    "./result_10chains/node189_9_0.txt 81"
    "./result_10chains/node189_9_2.txt 81"
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
