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
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_2 -p 227 -st topic11_0_1 -pt None -u 0.013547171927385138 > ./result_10chains/node11_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_2 -p 248 -st topic11_1_1 -pt None -u 0.002149990323827067 > ./result_10chains/node11_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_2 -p 457 -st topic11_2_1 -pt None -u 0.004508599615136888 > ./result_10chains/node11_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_2 -p 470 -st topic11_3_1 -pt None -u 0.023254789171295365 > ./result_10chains/node11_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_2 -p 519 -st topic11_4_1 -pt None -u 0.016666022003663933 > ./result_10chains/node11_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_2 -p 648 -st topic11_5_1 -pt None -u 0.0015917657282141506 > ./result_10chains/node11_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_6_2 -p 699 -st topic11_6_1 -pt None -u 0.012074321777207048 > ./result_10chains/node11_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_7_2 -p 734 -st topic11_7_1 -pt None -u 0.004498472960906608 > ./result_10chains/node11_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_8_2 -p 738 -st topic11_8_1 -pt None -u 0.03188749053376974 > ./result_10chains/node11_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_9_2 -p 976 -st topic11_9_1 -pt None -u 0.03592534482707782 > ./result_10chains/node11_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_0 -p 227 -st none -pt topic11_0_0 -u 0.0065136600146291634 > ./result_10chains/node11_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_0 -p 248 -st none -pt topic11_1_0 -u 0.021818211310093982 > ./result_10chains/node11_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_0 -p 457 -st none -pt topic11_2_0 -u 0.009686937272421425 > ./result_10chains/node11_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_0 -p 470 -st none -pt topic11_3_0 -u 0.017947183709391468 > ./result_10chains/node11_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_0 -p 519 -st none -pt topic11_4_0 -u 0.013865482829231612 > ./result_10chains/node11_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_0 -p 648 -st none -pt topic11_5_0 -u 0.005441009322073254 > ./result_10chains/node11_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_6_0 -p 699 -st none -pt topic11_6_0 -u 0.002555927803857161 > ./result_10chains/node11_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_7_0 -p 734 -st none -pt topic11_7_0 -u 0.0084956656391042 > ./result_10chains/node11_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_8_0 -p 738 -st none -pt topic11_8_0 -u 0.012338452427475527 > ./result_10chains/node11_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_9_0 -p 976 -st none -pt topic11_9_0 -u 0.04785694579364549 > ./result_10chains/node11_9_0.txt &
sleep 10
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
    "./result_10chains/node11_0_0.txt 90"
    "./result_10chains/node11_0_2.txt 90"
    "./result_10chains/node11_1_0.txt 89"
    "./result_10chains/node11_1_2.txt 89"
    "./result_10chains/node11_2_0.txt 88"
    "./result_10chains/node11_2_2.txt 88"
    "./result_10chains/node11_3_0.txt 87"
    "./result_10chains/node11_3_2.txt 87"
    "./result_10chains/node11_4_0.txt 86"
    "./result_10chains/node11_4_2.txt 86"
    "./result_10chains/node11_5_0.txt 85"
    "./result_10chains/node11_5_2.txt 85"
    "./result_10chains/node11_6_0.txt 84"
    "./result_10chains/node11_6_2.txt 84"
    "./result_10chains/node11_7_0.txt 83"
    "./result_10chains/node11_7_2.txt 83"
    "./result_10chains/node11_8_0.txt 82"
    "./result_10chains/node11_8_2.txt 82"
    "./result_10chains/node11_9_0.txt 81"
    "./result_10chains/node11_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
