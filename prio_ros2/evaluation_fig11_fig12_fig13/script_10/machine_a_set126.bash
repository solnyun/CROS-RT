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
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_2 -p 54 -st topic126_0_1 -pt None -u 0.008240537855646768 > ./result_10chains/node126_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_2 -p 141 -st topic126_1_1 -pt None -u 0.03094777263580306 > ./result_10chains/node126_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_2 -p 239 -st topic126_2_1 -pt None -u 0.0017457421590737487 > ./result_10chains/node126_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_2 -p 613 -st topic126_3_1 -pt None -u 0.012357003592471438 > ./result_10chains/node126_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_2 -p 615 -st topic126_4_1 -pt None -u 0.014995648983267273 > ./result_10chains/node126_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_2 -p 646 -st topic126_5_1 -pt None -u 0.0013721898963628132 > ./result_10chains/node126_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_6_2 -p 662 -st topic126_6_1 -pt None -u 0.025068639698347883 > ./result_10chains/node126_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_7_2 -p 832 -st topic126_7_1 -pt None -u 0.0031813686831546548 > ./result_10chains/node126_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_8_2 -p 933 -st topic126_8_1 -pt None -u 0.007041497412137549 > ./result_10chains/node126_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_9_2 -p 943 -st topic126_9_1 -pt None -u 0.006417408202369602 > ./result_10chains/node126_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_0 -p 54 -st none -pt topic126_0_0 -u 0.039835258928786754 > ./result_10chains/node126_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_0 -p 141 -st none -pt topic126_1_0 -u 0.002904049517599816 > ./result_10chains/node126_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_0 -p 239 -st none -pt topic126_2_0 -u 0.009997997054583208 > ./result_10chains/node126_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_0 -p 613 -st none -pt topic126_3_0 -u 0.011511462444722287 > ./result_10chains/node126_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_0 -p 615 -st none -pt topic126_4_0 -u 0.03721466757573533 > ./result_10chains/node126_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_0 -p 646 -st none -pt topic126_5_0 -u 0.008521214149383671 > ./result_10chains/node126_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_6_0 -p 662 -st none -pt topic126_6_0 -u 0.010774672241447264 > ./result_10chains/node126_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_7_0 -p 832 -st none -pt topic126_7_0 -u 0.03027319357374146 > ./result_10chains/node126_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_8_0 -p 933 -st none -pt topic126_8_0 -u 0.011325029172609063 > ./result_10chains/node126_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node126_9_0 -p 943 -st none -pt topic126_9_0 -u 0.00042377441199055975 > ./result_10chains/node126_9_0.txt &
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
    "./result_10chains/node126_0_0.txt 90"
    "./result_10chains/node126_0_2.txt 90"
    "./result_10chains/node126_1_0.txt 89"
    "./result_10chains/node126_1_2.txt 89"
    "./result_10chains/node126_2_0.txt 88"
    "./result_10chains/node126_2_2.txt 88"
    "./result_10chains/node126_3_0.txt 87"
    "./result_10chains/node126_3_2.txt 87"
    "./result_10chains/node126_4_0.txt 86"
    "./result_10chains/node126_4_2.txt 86"
    "./result_10chains/node126_5_0.txt 85"
    "./result_10chains/node126_5_2.txt 85"
    "./result_10chains/node126_6_0.txt 84"
    "./result_10chains/node126_6_2.txt 84"
    "./result_10chains/node126_7_0.txt 83"
    "./result_10chains/node126_7_2.txt 83"
    "./result_10chains/node126_8_0.txt 82"
    "./result_10chains/node126_8_2.txt 82"
    "./result_10chains/node126_9_0.txt 81"
    "./result_10chains/node126_9_2.txt 81"
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
