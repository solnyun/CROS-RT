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
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_2 -p 15 -st topic128_0_1 -pt None -u 0.021210151939465127 > ./result_10chains/node128_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_2 -p 228 -st topic128_1_1 -pt None -u 0.01445011260443091 > ./result_10chains/node128_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_2 -p 488 -st topic128_2_1 -pt None -u 0.0005484494467767886 > ./result_10chains/node128_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_2 -p 508 -st topic128_3_1 -pt None -u 0.0007628402065626427 > ./result_10chains/node128_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_2 -p 524 -st topic128_4_1 -pt None -u 0.0027204116665766054 > ./result_10chains/node128_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_2 -p 545 -st topic128_5_1 -pt None -u 0.042679068109658325 > ./result_10chains/node128_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_6_2 -p 799 -st topic128_6_1 -pt None -u 0.008177569064631462 > ./result_10chains/node128_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_7_2 -p 827 -st topic128_7_1 -pt None -u 0.02254497137529736 > ./result_10chains/node128_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_8_2 -p 830 -st topic128_8_1 -pt None -u 0.00042684731650237395 > ./result_10chains/node128_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_9_2 -p 860 -st topic128_9_1 -pt None -u 0.02467832565012811 > ./result_10chains/node128_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_0 -p 15 -st none -pt topic128_0_0 -u 0.00726819970426934 > ./result_10chains/node128_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_0 -p 228 -st none -pt topic128_1_0 -u 0.0024868049985082297 > ./result_10chains/node128_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_0 -p 488 -st none -pt topic128_2_0 -u 0.02531851480267361 > ./result_10chains/node128_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_0 -p 508 -st none -pt topic128_3_0 -u 0.014600207555247546 > ./result_10chains/node128_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_0 -p 524 -st none -pt topic128_4_0 -u 0.015057071714467019 > ./result_10chains/node128_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_0 -p 545 -st none -pt topic128_5_0 -u 0.014950047153236001 > ./result_10chains/node128_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_6_0 -p 799 -st none -pt topic128_6_0 -u 0.020764283890781304 > ./result_10chains/node128_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_7_0 -p 827 -st none -pt topic128_7_0 -u 0.0027761620780770158 > ./result_10chains/node128_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_8_0 -p 830 -st none -pt topic128_8_0 -u 0.0031903812255395653 > ./result_10chains/node128_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_9_0 -p 860 -st none -pt topic128_9_0 -u 0.007820256208174059 > ./result_10chains/node128_9_0.txt &
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
    "./result_10chains/node128_0_0.txt 90"
    "./result_10chains/node128_0_2.txt 90"
    "./result_10chains/node128_1_0.txt 89"
    "./result_10chains/node128_1_2.txt 89"
    "./result_10chains/node128_2_0.txt 88"
    "./result_10chains/node128_2_2.txt 88"
    "./result_10chains/node128_3_0.txt 87"
    "./result_10chains/node128_3_2.txt 87"
    "./result_10chains/node128_4_0.txt 86"
    "./result_10chains/node128_4_2.txt 86"
    "./result_10chains/node128_5_0.txt 85"
    "./result_10chains/node128_5_2.txt 85"
    "./result_10chains/node128_6_0.txt 84"
    "./result_10chains/node128_6_2.txt 84"
    "./result_10chains/node128_7_0.txt 83"
    "./result_10chains/node128_7_2.txt 83"
    "./result_10chains/node128_8_0.txt 82"
    "./result_10chains/node128_8_2.txt 82"
    "./result_10chains/node128_9_0.txt 81"
    "./result_10chains/node128_9_2.txt 81"
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
