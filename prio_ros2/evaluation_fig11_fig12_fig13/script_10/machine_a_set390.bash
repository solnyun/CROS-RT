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
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_2 -p 21 -st topic390_0_1 -pt None -u 0.03455523233310559 > ./result_10chains/node390_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_2 -p 123 -st topic390_1_1 -pt None -u 0.01805318281223861 > ./result_10chains/node390_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_2 -p 271 -st topic390_2_1 -pt None -u 0.012791295387591994 > ./result_10chains/node390_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_2 -p 279 -st topic390_3_1 -pt None -u 0.01040613911718652 > ./result_10chains/node390_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_2 -p 439 -st topic390_4_1 -pt None -u 0.024954590375302454 > ./result_10chains/node390_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_2 -p 451 -st topic390_5_1 -pt None -u 0.03907426658649232 > ./result_10chains/node390_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_6_2 -p 454 -st topic390_6_1 -pt None -u 0.016027982567284896 > ./result_10chains/node390_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_7_2 -p 878 -st topic390_7_1 -pt None -u 0.026561026156774623 > ./result_10chains/node390_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_8_2 -p 933 -st topic390_8_1 -pt None -u 0.0015084091452727613 > ./result_10chains/node390_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_9_2 -p 991 -st topic390_9_1 -pt None -u 0.014071264441513512 > ./result_10chains/node390_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_0 -p 21 -st none -pt topic390_0_0 -u 0.007635200727929781 > ./result_10chains/node390_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_0 -p 123 -st none -pt topic390_1_0 -u 0.014870478602023784 > ./result_10chains/node390_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_0 -p 271 -st none -pt topic390_2_0 -u 0.0016080122957041754 > ./result_10chains/node390_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_0 -p 279 -st none -pt topic390_3_0 -u 0.007351337369367328 > ./result_10chains/node390_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_0 -p 439 -st none -pt topic390_4_0 -u 0.018850251383655814 > ./result_10chains/node390_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_0 -p 451 -st none -pt topic390_5_0 -u 0.04047512471374215 > ./result_10chains/node390_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_6_0 -p 454 -st none -pt topic390_6_0 -u 0.010891669489461825 > ./result_10chains/node390_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_7_0 -p 878 -st none -pt topic390_7_0 -u 0.00870530943400323 > ./result_10chains/node390_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_8_0 -p 933 -st none -pt topic390_8_0 -u 0.018274886225750117 > ./result_10chains/node390_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_9_0 -p 991 -st none -pt topic390_9_0 -u 0.004891890533142693 > ./result_10chains/node390_9_0.txt &
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
    "./result_10chains/node390_0_0.txt 90"
    "./result_10chains/node390_0_2.txt 90"
    "./result_10chains/node390_1_0.txt 89"
    "./result_10chains/node390_1_2.txt 89"
    "./result_10chains/node390_2_0.txt 88"
    "./result_10chains/node390_2_2.txt 88"
    "./result_10chains/node390_3_0.txt 87"
    "./result_10chains/node390_3_2.txt 87"
    "./result_10chains/node390_4_0.txt 86"
    "./result_10chains/node390_4_2.txt 86"
    "./result_10chains/node390_5_0.txt 85"
    "./result_10chains/node390_5_2.txt 85"
    "./result_10chains/node390_6_0.txt 84"
    "./result_10chains/node390_6_2.txt 84"
    "./result_10chains/node390_7_0.txt 83"
    "./result_10chains/node390_7_2.txt 83"
    "./result_10chains/node390_8_0.txt 82"
    "./result_10chains/node390_8_2.txt 82"
    "./result_10chains/node390_9_0.txt 81"
    "./result_10chains/node390_9_2.txt 81"
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
