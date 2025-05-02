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
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_2 -p 30 -st topic102_0_1 -pt None -u 0.0036941569625031923 > ./result_10chains/node102_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_2 -p 261 -st topic102_1_1 -pt None -u 0.045259267782149004 > ./result_10chains/node102_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_2 -p 403 -st topic102_2_1 -pt None -u 0.0012399300743478614 > ./result_10chains/node102_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_2 -p 564 -st topic102_3_1 -pt None -u 6.367412666030692e-05 > ./result_10chains/node102_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_2 -p 685 -st topic102_4_1 -pt None -u 0.02997275212503639 > ./result_10chains/node102_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_2 -p 715 -st topic102_5_1 -pt None -u 0.001369214785397116 > ./result_10chains/node102_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_6_2 -p 721 -st topic102_6_1 -pt None -u 0.014837824665105914 > ./result_10chains/node102_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_7_2 -p 730 -st topic102_7_1 -pt None -u 0.0017336001682784763 > ./result_10chains/node102_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_8_2 -p 841 -st topic102_8_1 -pt None -u 0.00689530441701889 > ./result_10chains/node102_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_9_2 -p 858 -st topic102_9_1 -pt None -u 0.007929204195202528 > ./result_10chains/node102_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_0 -p 30 -st none -pt topic102_0_0 -u 0.00023915581762612437 > ./result_10chains/node102_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_0 -p 261 -st none -pt topic102_1_0 -u 0.008335157737466514 > ./result_10chains/node102_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_0 -p 403 -st none -pt topic102_2_0 -u 0.07058369389942815 > ./result_10chains/node102_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_0 -p 564 -st none -pt topic102_3_0 -u 0.024996666942562806 > ./result_10chains/node102_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_0 -p 685 -st none -pt topic102_4_0 -u 0.00513612564981869 > ./result_10chains/node102_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_0 -p 715 -st none -pt topic102_5_0 -u 0.012436236038535525 > ./result_10chains/node102_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_6_0 -p 721 -st none -pt topic102_6_0 -u 0.020490447352675967 > ./result_10chains/node102_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_7_0 -p 730 -st none -pt topic102_7_0 -u 0.01326951713840993 > ./result_10chains/node102_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_8_0 -p 841 -st none -pt topic102_8_0 -u 0.0003846322673924235 > ./result_10chains/node102_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_9_0 -p 858 -st none -pt topic102_9_0 -u 0.044285611646128265 > ./result_10chains/node102_9_0.txt &
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
    "./result_10chains/node102_0_0.txt 90"
    "./result_10chains/node102_0_2.txt 90"
    "./result_10chains/node102_1_0.txt 89"
    "./result_10chains/node102_1_2.txt 89"
    "./result_10chains/node102_2_0.txt 88"
    "./result_10chains/node102_2_2.txt 88"
    "./result_10chains/node102_3_0.txt 87"
    "./result_10chains/node102_3_2.txt 87"
    "./result_10chains/node102_4_0.txt 86"
    "./result_10chains/node102_4_2.txt 86"
    "./result_10chains/node102_5_0.txt 85"
    "./result_10chains/node102_5_2.txt 85"
    "./result_10chains/node102_6_0.txt 84"
    "./result_10chains/node102_6_2.txt 84"
    "./result_10chains/node102_7_0.txt 83"
    "./result_10chains/node102_7_2.txt 83"
    "./result_10chains/node102_8_0.txt 82"
    "./result_10chains/node102_8_2.txt 82"
    "./result_10chains/node102_9_0.txt 81"
    "./result_10chains/node102_9_2.txt 81"
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
