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
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_2 -p 79 -st topic152_0_1 -pt None -u 0.02602992239887686 > ./result_10chains/node152_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_2 -p 199 -st topic152_1_1 -pt None -u 0.04528591370131918 > ./result_10chains/node152_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_2 -p 347 -st topic152_2_1 -pt None -u 0.012498023433329175 > ./result_10chains/node152_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_2 -p 456 -st topic152_3_1 -pt None -u 0.00788523087361126 > ./result_10chains/node152_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_2 -p 489 -st topic152_4_1 -pt None -u 0.02760649427498313 > ./result_10chains/node152_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_2 -p 520 -st topic152_5_1 -pt None -u 0.007465039151287767 > ./result_10chains/node152_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_6_2 -p 610 -st topic152_6_1 -pt None -u 0.019720678395904412 > ./result_10chains/node152_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_7_2 -p 665 -st topic152_7_1 -pt None -u 0.05369345093981906 > ./result_10chains/node152_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_8_2 -p 947 -st topic152_8_1 -pt None -u 0.02758891872574697 > ./result_10chains/node152_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_9_2 -p 964 -st topic152_9_1 -pt None -u 0.01280501559973375 > ./result_10chains/node152_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_0 -p 79 -st none -pt topic152_0_0 -u 0.0019754697217260753 > ./result_10chains/node152_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_0 -p 199 -st none -pt topic152_1_0 -u 0.003937325059813035 > ./result_10chains/node152_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_0 -p 347 -st none -pt topic152_2_0 -u 0.016821402552428755 > ./result_10chains/node152_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_0 -p 456 -st none -pt topic152_3_0 -u 0.02486051675982398 > ./result_10chains/node152_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_0 -p 489 -st none -pt topic152_4_0 -u 0.0025547235521253264 > ./result_10chains/node152_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_0 -p 520 -st none -pt topic152_5_0 -u 0.0009438521424520452 > ./result_10chains/node152_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_6_0 -p 610 -st none -pt topic152_6_0 -u 0.007130672281585759 > ./result_10chains/node152_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_7_0 -p 665 -st none -pt topic152_7_0 -u 0.005947762932656642 > ./result_10chains/node152_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_8_0 -p 947 -st none -pt topic152_8_0 -u 0.007876586932246812 > ./result_10chains/node152_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_9_0 -p 964 -st none -pt topic152_9_0 -u 0.0023165871956702944 > ./result_10chains/node152_9_0.txt &
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
    "./result_10chains/node152_0_0.txt 90"
    "./result_10chains/node152_0_2.txt 90"
    "./result_10chains/node152_1_0.txt 89"
    "./result_10chains/node152_1_2.txt 89"
    "./result_10chains/node152_2_0.txt 88"
    "./result_10chains/node152_2_2.txt 88"
    "./result_10chains/node152_3_0.txt 87"
    "./result_10chains/node152_3_2.txt 87"
    "./result_10chains/node152_4_0.txt 86"
    "./result_10chains/node152_4_2.txt 86"
    "./result_10chains/node152_5_0.txt 85"
    "./result_10chains/node152_5_2.txt 85"
    "./result_10chains/node152_6_0.txt 84"
    "./result_10chains/node152_6_2.txt 84"
    "./result_10chains/node152_7_0.txt 83"
    "./result_10chains/node152_7_2.txt 83"
    "./result_10chains/node152_8_0.txt 82"
    "./result_10chains/node152_8_2.txt 82"
    "./result_10chains/node152_9_0.txt 81"
    "./result_10chains/node152_9_2.txt 81"
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
