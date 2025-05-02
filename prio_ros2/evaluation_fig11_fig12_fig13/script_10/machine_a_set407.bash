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
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_2 -p 129 -st topic407_0_1 -pt None -u 0.006073035028237028 > ./result_10chains/node407_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_2 -p 211 -st topic407_1_1 -pt None -u 0.003930211226588487 > ./result_10chains/node407_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_2 -p 355 -st topic407_2_1 -pt None -u 0.003368058541399155 > ./result_10chains/node407_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_2 -p 496 -st topic407_3_1 -pt None -u 0.004297965020435113 > ./result_10chains/node407_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_2 -p 758 -st topic407_4_1 -pt None -u 0.023216845216850884 > ./result_10chains/node407_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_2 -p 834 -st topic407_5_1 -pt None -u 0.0036555792794193964 > ./result_10chains/node407_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_6_2 -p 878 -st topic407_6_1 -pt None -u 0.010922585882686894 > ./result_10chains/node407_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_7_2 -p 882 -st topic407_7_1 -pt None -u 0.007500784568032479 > ./result_10chains/node407_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_8_2 -p 905 -st topic407_8_1 -pt None -u 0.051526537961454 > ./result_10chains/node407_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_9_2 -p 949 -st topic407_9_1 -pt None -u 0.002174891917707224 > ./result_10chains/node407_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_0 -p 129 -st none -pt topic407_0_0 -u 0.019310635338299187 > ./result_10chains/node407_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_0 -p 211 -st none -pt topic407_1_0 -u 0.06985883667869697 > ./result_10chains/node407_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_0 -p 355 -st none -pt topic407_2_0 -u 0.00696205889497431 > ./result_10chains/node407_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_0 -p 496 -st none -pt topic407_3_0 -u 0.05301687188993848 > ./result_10chains/node407_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_0 -p 758 -st none -pt topic407_4_0 -u 0.015195172417376557 > ./result_10chains/node407_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_0 -p 834 -st none -pt topic407_5_0 -u 0.02387739679119183 > ./result_10chains/node407_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_6_0 -p 878 -st none -pt topic407_6_0 -u 0.005529063392904404 > ./result_10chains/node407_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_7_0 -p 882 -st none -pt topic407_7_0 -u 0.041754983277093205 > ./result_10chains/node407_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_8_0 -p 905 -st none -pt topic407_8_0 -u 0.006710951747242372 > ./result_10chains/node407_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_9_0 -p 949 -st none -pt topic407_9_0 -u 0.0029268256619807195 > ./result_10chains/node407_9_0.txt &
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
    "./result_10chains/node407_0_0.txt 90"
    "./result_10chains/node407_0_2.txt 90"
    "./result_10chains/node407_1_0.txt 89"
    "./result_10chains/node407_1_2.txt 89"
    "./result_10chains/node407_2_0.txt 88"
    "./result_10chains/node407_2_2.txt 88"
    "./result_10chains/node407_3_0.txt 87"
    "./result_10chains/node407_3_2.txt 87"
    "./result_10chains/node407_4_0.txt 86"
    "./result_10chains/node407_4_2.txt 86"
    "./result_10chains/node407_5_0.txt 85"
    "./result_10chains/node407_5_2.txt 85"
    "./result_10chains/node407_6_0.txt 84"
    "./result_10chains/node407_6_2.txt 84"
    "./result_10chains/node407_7_0.txt 83"
    "./result_10chains/node407_7_2.txt 83"
    "./result_10chains/node407_8_0.txt 82"
    "./result_10chains/node407_8_2.txt 82"
    "./result_10chains/node407_9_0.txt 81"
    "./result_10chains/node407_9_2.txt 81"
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
