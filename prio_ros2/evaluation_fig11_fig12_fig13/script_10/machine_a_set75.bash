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
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_2 -p 10 -st topic75_0_1 -pt None -u 0.008397911328059615 > ./result_10chains/node75_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_2 -p 22 -st topic75_1_1 -pt None -u 0.0027799431560587284 > ./result_10chains/node75_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_2 -p 44 -st topic75_2_1 -pt None -u 0.010595427355620857 > ./result_10chains/node75_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_2 -p 73 -st topic75_3_1 -pt None -u 0.03542440051717971 > ./result_10chains/node75_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_2 -p 345 -st topic75_4_1 -pt None -u 0.045534968776704016 > ./result_10chains/node75_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_2 -p 608 -st topic75_5_1 -pt None -u 0.0038604587516000988 > ./result_10chains/node75_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_6_2 -p 761 -st topic75_6_1 -pt None -u 0.007016527368467529 > ./result_10chains/node75_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_7_2 -p 860 -st topic75_7_1 -pt None -u 0.006854675315340633 > ./result_10chains/node75_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_8_2 -p 899 -st topic75_8_1 -pt None -u 0.01469280609667236 > ./result_10chains/node75_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_9_2 -p 991 -st topic75_9_1 -pt None -u 0.00765049872915255 > ./result_10chains/node75_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_0 -p 10 -st none -pt topic75_0_0 -u 0.01582387436151267 > ./result_10chains/node75_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_0 -p 22 -st none -pt topic75_1_0 -u 0.01671785339231807 > ./result_10chains/node75_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_0 -p 44 -st none -pt topic75_2_0 -u 0.04301005916114364 > ./result_10chains/node75_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_0 -p 73 -st none -pt topic75_3_0 -u 0.01510698430562507 > ./result_10chains/node75_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_0 -p 345 -st none -pt topic75_4_0 -u 0.004143345867290371 > ./result_10chains/node75_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_0 -p 608 -st none -pt topic75_5_0 -u 0.03386092722987885 > ./result_10chains/node75_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_6_0 -p 761 -st none -pt topic75_6_0 -u 0.003677703652261055 > ./result_10chains/node75_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_7_0 -p 860 -st none -pt topic75_7_0 -u 0.030396783147575226 > ./result_10chains/node75_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_8_0 -p 899 -st none -pt topic75_8_0 -u 0.005545472626641262 > ./result_10chains/node75_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node75_9_0 -p 991 -st none -pt topic75_9_0 -u 0.016844771754198375 > ./result_10chains/node75_9_0.txt &
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
    "./result_10chains/node75_0_0.txt 90"
    "./result_10chains/node75_0_2.txt 90"
    "./result_10chains/node75_1_0.txt 89"
    "./result_10chains/node75_1_2.txt 89"
    "./result_10chains/node75_2_0.txt 88"
    "./result_10chains/node75_2_2.txt 88"
    "./result_10chains/node75_3_0.txt 87"
    "./result_10chains/node75_3_2.txt 87"
    "./result_10chains/node75_4_0.txt 86"
    "./result_10chains/node75_4_2.txt 86"
    "./result_10chains/node75_5_0.txt 85"
    "./result_10chains/node75_5_2.txt 85"
    "./result_10chains/node75_6_0.txt 84"
    "./result_10chains/node75_6_2.txt 84"
    "./result_10chains/node75_7_0.txt 83"
    "./result_10chains/node75_7_2.txt 83"
    "./result_10chains/node75_8_0.txt 82"
    "./result_10chains/node75_8_2.txt 82"
    "./result_10chains/node75_9_0.txt 81"
    "./result_10chains/node75_9_2.txt 81"
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
