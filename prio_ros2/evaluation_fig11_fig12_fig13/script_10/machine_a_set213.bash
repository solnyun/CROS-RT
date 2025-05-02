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
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_2 -p 203 -st topic213_0_1 -pt None -u 0.012333009983227616 > ./result_10chains/node213_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_2 -p 347 -st topic213_1_1 -pt None -u 0.011551096197442712 > ./result_10chains/node213_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_2 -p 431 -st topic213_2_1 -pt None -u 0.010328905737521377 > ./result_10chains/node213_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_2 -p 508 -st topic213_3_1 -pt None -u 0.00517657641545205 > ./result_10chains/node213_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_2 -p 535 -st topic213_4_1 -pt None -u 0.0011683303618629237 > ./result_10chains/node213_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_2 -p 580 -st topic213_5_1 -pt None -u 0.030392331407266743 > ./result_10chains/node213_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_6_2 -p 590 -st topic213_6_1 -pt None -u 0.00042384792715943753 > ./result_10chains/node213_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_7_2 -p 717 -st topic213_7_1 -pt None -u 0.04986785823351779 > ./result_10chains/node213_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_8_2 -p 719 -st topic213_8_1 -pt None -u 0.00034619620712816185 > ./result_10chains/node213_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_9_2 -p 821 -st topic213_9_1 -pt None -u 0.03919124663090949 > ./result_10chains/node213_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_0_0 -p 203 -st none -pt topic213_0_0 -u 0.023599352981403088 > ./result_10chains/node213_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_1_0 -p 347 -st none -pt topic213_1_0 -u 0.003120594388407172 > ./result_10chains/node213_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_2_0 -p 431 -st none -pt topic213_2_0 -u 0.02169102849636939 > ./result_10chains/node213_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_3_0 -p 508 -st none -pt topic213_3_0 -u 0.021421457046487014 > ./result_10chains/node213_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_4_0 -p 535 -st none -pt topic213_4_0 -u 0.01983997709028351 > ./result_10chains/node213_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_5_0 -p 580 -st none -pt topic213_5_0 -u 0.013997753260591217 > ./result_10chains/node213_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_6_0 -p 590 -st none -pt topic213_6_0 -u 0.011414651093087425 > ./result_10chains/node213_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_7_0 -p 717 -st none -pt topic213_7_0 -u 0.025601088793939075 > ./result_10chains/node213_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node213_8_0 -p 719 -st none -pt topic213_8_0 -u 0.001714185114206207 > ./result_10chains/node213_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node213_9_0 -p 821 -st none -pt topic213_9_0 -u 0.009421034643460585 > ./result_10chains/node213_9_0.txt &
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
    "./result_10chains/node213_0_0.txt 90"
    "./result_10chains/node213_0_2.txt 90"
    "./result_10chains/node213_1_0.txt 89"
    "./result_10chains/node213_1_2.txt 89"
    "./result_10chains/node213_2_0.txt 88"
    "./result_10chains/node213_2_2.txt 88"
    "./result_10chains/node213_3_0.txt 87"
    "./result_10chains/node213_3_2.txt 87"
    "./result_10chains/node213_4_0.txt 86"
    "./result_10chains/node213_4_2.txt 86"
    "./result_10chains/node213_5_0.txt 85"
    "./result_10chains/node213_5_2.txt 85"
    "./result_10chains/node213_6_0.txt 84"
    "./result_10chains/node213_6_2.txt 84"
    "./result_10chains/node213_7_0.txt 83"
    "./result_10chains/node213_7_2.txt 83"
    "./result_10chains/node213_8_0.txt 82"
    "./result_10chains/node213_8_2.txt 82"
    "./result_10chains/node213_9_0.txt 81"
    "./result_10chains/node213_9_2.txt 81"
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
