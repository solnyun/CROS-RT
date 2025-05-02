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
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_2 -p 243 -st topic142_0_1 -pt None -u 0.001048719275393295 > ./result_10chains/node142_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_2 -p 293 -st topic142_1_1 -pt None -u 0.00788270387272294 > ./result_10chains/node142_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_2 -p 588 -st topic142_2_1 -pt None -u 0.004787225875006906 > ./result_10chains/node142_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_2 -p 686 -st topic142_3_1 -pt None -u 0.006292080760802676 > ./result_10chains/node142_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_2 -p 713 -st topic142_4_1 -pt None -u 0.02037960892559193 > ./result_10chains/node142_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_2 -p 739 -st topic142_5_1 -pt None -u 0.001282120300962919 > ./result_10chains/node142_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_6_2 -p 836 -st topic142_6_1 -pt None -u 0.033465592612013983 > ./result_10chains/node142_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_7_2 -p 856 -st topic142_7_1 -pt None -u 0.0172810831798087 > ./result_10chains/node142_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_8_2 -p 873 -st topic142_8_1 -pt None -u 0.005010326665930834 > ./result_10chains/node142_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_9_2 -p 905 -st topic142_9_1 -pt None -u 0.046036277448377794 > ./result_10chains/node142_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_0 -p 243 -st none -pt topic142_0_0 -u 0.027351500914786442 > ./result_10chains/node142_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_0 -p 293 -st none -pt topic142_1_0 -u 0.001215299216121457 > ./result_10chains/node142_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_0 -p 588 -st none -pt topic142_2_0 -u 0.020364151476161718 > ./result_10chains/node142_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_0 -p 686 -st none -pt topic142_3_0 -u 0.004441055011298711 > ./result_10chains/node142_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_0 -p 713 -st none -pt topic142_4_0 -u 0.0022984515689438156 > ./result_10chains/node142_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_0 -p 739 -st none -pt topic142_5_0 -u 0.002633581732543633 > ./result_10chains/node142_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_6_0 -p 836 -st none -pt topic142_6_0 -u 0.005797202931289713 > ./result_10chains/node142_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_7_0 -p 856 -st none -pt topic142_7_0 -u 0.010915929071450003 > ./result_10chains/node142_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_8_0 -p 873 -st none -pt topic142_8_0 -u 0.002247266261762984 > ./result_10chains/node142_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_9_0 -p 905 -st none -pt topic142_9_0 -u 0.02443224347873193 > ./result_10chains/node142_9_0.txt &
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
    "./result_10chains/node142_0_0.txt 90"
    "./result_10chains/node142_0_2.txt 90"
    "./result_10chains/node142_1_0.txt 89"
    "./result_10chains/node142_1_2.txt 89"
    "./result_10chains/node142_2_0.txt 88"
    "./result_10chains/node142_2_2.txt 88"
    "./result_10chains/node142_3_0.txt 87"
    "./result_10chains/node142_3_2.txt 87"
    "./result_10chains/node142_4_0.txt 86"
    "./result_10chains/node142_4_2.txt 86"
    "./result_10chains/node142_5_0.txt 85"
    "./result_10chains/node142_5_2.txt 85"
    "./result_10chains/node142_6_0.txt 84"
    "./result_10chains/node142_6_2.txt 84"
    "./result_10chains/node142_7_0.txt 83"
    "./result_10chains/node142_7_2.txt 83"
    "./result_10chains/node142_8_0.txt 82"
    "./result_10chains/node142_8_2.txt 82"
    "./result_10chains/node142_9_0.txt 81"
    "./result_10chains/node142_9_2.txt 81"
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
