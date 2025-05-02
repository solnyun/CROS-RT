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
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_2 -p 246 -st topic79_0_1 -pt None -u 0.057997987918836924 > ./result_10chains/node79_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_2 -p 296 -st topic79_1_1 -pt None -u 0.0051410692944843794 > ./result_10chains/node79_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_2 -p 370 -st topic79_2_1 -pt None -u 0.011587313816318057 > ./result_10chains/node79_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_2 -p 417 -st topic79_3_1 -pt None -u 0.027200016897010293 > ./result_10chains/node79_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_2 -p 544 -st topic79_4_1 -pt None -u 0.0013513428799802052 > ./result_10chains/node79_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_2 -p 655 -st topic79_5_1 -pt None -u 0.01666197655395893 > ./result_10chains/node79_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_6_2 -p 710 -st topic79_6_1 -pt None -u 0.0441326290351486 > ./result_10chains/node79_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_7_2 -p 845 -st topic79_7_1 -pt None -u 0.015559930852620793 > ./result_10chains/node79_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_8_2 -p 968 -st topic79_8_1 -pt None -u 0.00019979649734241933 > ./result_10chains/node79_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_9_2 -p 998 -st topic79_9_1 -pt None -u 0.0104850221053326 > ./result_10chains/node79_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_0 -p 246 -st none -pt topic79_0_0 -u 0.0037472347418512353 > ./result_10chains/node79_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_0 -p 296 -st none -pt topic79_1_0 -u 0.012398973616737363 > ./result_10chains/node79_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_0 -p 370 -st none -pt topic79_2_0 -u 0.03412727897440904 > ./result_10chains/node79_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_0 -p 417 -st none -pt topic79_3_0 -u 0.044129507951378766 > ./result_10chains/node79_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_0 -p 544 -st none -pt topic79_4_0 -u 0.030817843431663605 > ./result_10chains/node79_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_0 -p 655 -st none -pt topic79_5_0 -u 0.03485867020385067 > ./result_10chains/node79_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_6_0 -p 710 -st none -pt topic79_6_0 -u 0.01054340260221115 > ./result_10chains/node79_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_7_0 -p 845 -st none -pt topic79_7_0 -u 0.00011965297904319161 > ./result_10chains/node79_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_8_0 -p 968 -st none -pt topic79_8_0 -u 0.02239597318826214 > ./result_10chains/node79_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_9_0 -p 998 -st none -pt topic79_9_0 -u 3.0714897531959606e-05 > ./result_10chains/node79_9_0.txt &
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
    "./result_10chains/node79_0_0.txt 90"
    "./result_10chains/node79_0_2.txt 90"
    "./result_10chains/node79_1_0.txt 89"
    "./result_10chains/node79_1_2.txt 89"
    "./result_10chains/node79_2_0.txt 88"
    "./result_10chains/node79_2_2.txt 88"
    "./result_10chains/node79_3_0.txt 87"
    "./result_10chains/node79_3_2.txt 87"
    "./result_10chains/node79_4_0.txt 86"
    "./result_10chains/node79_4_2.txt 86"
    "./result_10chains/node79_5_0.txt 85"
    "./result_10chains/node79_5_2.txt 85"
    "./result_10chains/node79_6_0.txt 84"
    "./result_10chains/node79_6_2.txt 84"
    "./result_10chains/node79_7_0.txt 83"
    "./result_10chains/node79_7_2.txt 83"
    "./result_10chains/node79_8_0.txt 82"
    "./result_10chains/node79_8_2.txt 82"
    "./result_10chains/node79_9_0.txt 81"
    "./result_10chains/node79_9_2.txt 81"
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
