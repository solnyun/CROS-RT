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
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_2 -p 19 -st topic403_0_1 -pt None -u 0.015171827294380824 > ./result_10chains/node403_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_2 -p 155 -st topic403_1_1 -pt None -u 0.019789539015286406 > ./result_10chains/node403_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_2 -p 267 -st topic403_2_1 -pt None -u 0.030893542233115245 > ./result_10chains/node403_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_2 -p 296 -st topic403_3_1 -pt None -u 0.00010775250802008696 > ./result_10chains/node403_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_2 -p 441 -st topic403_4_1 -pt None -u 0.015340351438248356 > ./result_10chains/node403_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_2 -p 739 -st topic403_5_1 -pt None -u 0.016252991333718103 > ./result_10chains/node403_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_6_2 -p 744 -st topic403_6_1 -pt None -u 0.005411842371712383 > ./result_10chains/node403_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_7_2 -p 943 -st topic403_7_1 -pt None -u 0.013431874660573759 > ./result_10chains/node403_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_8_2 -p 967 -st topic403_8_1 -pt None -u 0.0021763370971421975 > ./result_10chains/node403_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_9_2 -p 999 -st topic403_9_1 -pt None -u 0.03871135522280557 > ./result_10chains/node403_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_0 -p 19 -st none -pt topic403_0_0 -u 0.04370332031683771 > ./result_10chains/node403_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_0 -p 155 -st none -pt topic403_1_0 -u 0.03698806338044908 > ./result_10chains/node403_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_0 -p 267 -st none -pt topic403_2_0 -u 0.003276759427797593 > ./result_10chains/node403_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_0 -p 296 -st none -pt topic403_3_0 -u 0.006743244674921045 > ./result_10chains/node403_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_0 -p 441 -st none -pt topic403_4_0 -u 0.0028267015194836653 > ./result_10chains/node403_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_0 -p 739 -st none -pt topic403_5_0 -u 0.031376615642649486 > ./result_10chains/node403_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_6_0 -p 744 -st none -pt topic403_6_0 -u 0.020581571105961316 > ./result_10chains/node403_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_7_0 -p 943 -st none -pt topic403_7_0 -u 0.051337518099845436 > ./result_10chains/node403_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_8_0 -p 967 -st none -pt topic403_8_0 -u 0.02436616197624565 > ./result_10chains/node403_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_9_0 -p 999 -st none -pt topic403_9_0 -u 0.000748587956865894 > ./result_10chains/node403_9_0.txt &
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
    "./result_10chains/node403_0_0.txt 90"
    "./result_10chains/node403_0_2.txt 90"
    "./result_10chains/node403_1_0.txt 89"
    "./result_10chains/node403_1_2.txt 89"
    "./result_10chains/node403_2_0.txt 88"
    "./result_10chains/node403_2_2.txt 88"
    "./result_10chains/node403_3_0.txt 87"
    "./result_10chains/node403_3_2.txt 87"
    "./result_10chains/node403_4_0.txt 86"
    "./result_10chains/node403_4_2.txt 86"
    "./result_10chains/node403_5_0.txt 85"
    "./result_10chains/node403_5_2.txt 85"
    "./result_10chains/node403_6_0.txt 84"
    "./result_10chains/node403_6_2.txt 84"
    "./result_10chains/node403_7_0.txt 83"
    "./result_10chains/node403_7_2.txt 83"
    "./result_10chains/node403_8_0.txt 82"
    "./result_10chains/node403_8_2.txt 82"
    "./result_10chains/node403_9_0.txt 81"
    "./result_10chains/node403_9_2.txt 81"
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
