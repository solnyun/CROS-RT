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
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_2 -p 122 -st topic325_0_1 -pt None -u 0.007735153502911152 > ./result_10chains/node325_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_2 -p 176 -st topic325_1_1 -pt None -u 0.02780307105024471 > ./result_10chains/node325_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_2 -p 363 -st topic325_2_1 -pt None -u 0.024470967831035917 > ./result_10chains/node325_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_2 -p 369 -st topic325_3_1 -pt None -u 0.002238915080948478 > ./result_10chains/node325_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_2 -p 451 -st topic325_4_1 -pt None -u 0.009502883377331739 > ./result_10chains/node325_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_2 -p 613 -st topic325_5_1 -pt None -u 0.004069277547820688 > ./result_10chains/node325_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_6_2 -p 669 -st topic325_6_1 -pt None -u 0.0016715127904778082 > ./result_10chains/node325_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_7_2 -p 701 -st topic325_7_1 -pt None -u 0.03963606313186911 > ./result_10chains/node325_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_8_2 -p 715 -st topic325_8_1 -pt None -u 0.00753321821890162 > ./result_10chains/node325_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_9_2 -p 921 -st topic325_9_1 -pt None -u 0.008267592273202043 > ./result_10chains/node325_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_0_0 -p 122 -st none -pt topic325_0_0 -u 0.06276492766781983 > ./result_10chains/node325_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_1_0 -p 176 -st none -pt topic325_1_0 -u 0.0032868469956383595 > ./result_10chains/node325_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_2_0 -p 363 -st none -pt topic325_2_0 -u 0.029591441570729238 > ./result_10chains/node325_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_3_0 -p 369 -st none -pt topic325_3_0 -u 0.011462209301574544 > ./result_10chains/node325_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_4_0 -p 451 -st none -pt topic325_4_0 -u 0.011095988330462603 > ./result_10chains/node325_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_5_0 -p 613 -st none -pt topic325_5_0 -u 0.052641383049522955 > ./result_10chains/node325_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_6_0 -p 669 -st none -pt topic325_6_0 -u 0.004186637653524006 > ./result_10chains/node325_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_7_0 -p 701 -st none -pt topic325_7_0 -u 0.016228877946089626 > ./result_10chains/node325_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node325_8_0 -p 715 -st none -pt topic325_8_0 -u 0.011608208325517982 > ./result_10chains/node325_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node325_9_0 -p 921 -st none -pt topic325_9_0 -u 0.017304084512550846 > ./result_10chains/node325_9_0.txt &
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
    "./result_10chains/node325_0_0.txt 90"
    "./result_10chains/node325_0_2.txt 90"
    "./result_10chains/node325_1_0.txt 89"
    "./result_10chains/node325_1_2.txt 89"
    "./result_10chains/node325_2_0.txt 88"
    "./result_10chains/node325_2_2.txt 88"
    "./result_10chains/node325_3_0.txt 87"
    "./result_10chains/node325_3_2.txt 87"
    "./result_10chains/node325_4_0.txt 86"
    "./result_10chains/node325_4_2.txt 86"
    "./result_10chains/node325_5_0.txt 85"
    "./result_10chains/node325_5_2.txt 85"
    "./result_10chains/node325_6_0.txt 84"
    "./result_10chains/node325_6_2.txt 84"
    "./result_10chains/node325_7_0.txt 83"
    "./result_10chains/node325_7_2.txt 83"
    "./result_10chains/node325_8_0.txt 82"
    "./result_10chains/node325_8_2.txt 82"
    "./result_10chains/node325_9_0.txt 81"
    "./result_10chains/node325_9_2.txt 81"
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
