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
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_2 -p 35 -st topic105_0_1 -pt None -u 0.060725829544905574 > ./result_8chains/node105_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_2 -p 138 -st topic105_1_1 -pt None -u 0.014288021606768286 > ./result_8chains/node105_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_2 -p 233 -st topic105_2_1 -pt None -u 0.0010382291924305176 > ./result_8chains/node105_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_2 -p 284 -st topic105_3_1 -pt None -u 0.014349955941749593 > ./result_8chains/node105_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_2 -p 610 -st topic105_4_1 -pt None -u 0.009507395970128396 > ./result_8chains/node105_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_2 -p 641 -st topic105_5_1 -pt None -u 0.04660018195116533 > ./result_8chains/node105_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_6_2 -p 955 -st topic105_6_1 -pt None -u 0.012170738101528931 > ./result_8chains/node105_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_7_2 -p 975 -st topic105_7_1 -pt None -u 0.014128014484006106 > ./result_8chains/node105_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_0 -p 35 -st none -pt topic105_0_0 -u 0.02400503442998414 > ./result_8chains/node105_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_0 -p 138 -st none -pt topic105_1_0 -u 0.005272412027990059 > ./result_8chains/node105_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_0 -p 233 -st none -pt topic105_2_0 -u 0.0024602746870668324 > ./result_8chains/node105_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_0 -p 284 -st none -pt topic105_3_0 -u 0.0026787055277404104 > ./result_8chains/node105_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_0 -p 610 -st none -pt topic105_4_0 -u 0.001157171881007446 > ./result_8chains/node105_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_0 -p 641 -st none -pt topic105_5_0 -u 0.04044682290580476 > ./result_8chains/node105_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_6_0 -p 955 -st none -pt topic105_6_0 -u 0.06748298028458177 > ./result_8chains/node105_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_7_0 -p 975 -st none -pt topic105_7_0 -u 0.018522773449163095 > ./result_8chains/node105_7_0.txt &
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
    "./result_8chains/node105_0_0.txt 90"
    "./result_8chains/node105_0_2.txt 90"
    "./result_8chains/node105_1_0.txt 89"
    "./result_8chains/node105_1_2.txt 89"
    "./result_8chains/node105_2_0.txt 88"
    "./result_8chains/node105_2_2.txt 88"
    "./result_8chains/node105_3_0.txt 87"
    "./result_8chains/node105_3_2.txt 87"
    "./result_8chains/node105_4_0.txt 86"
    "./result_8chains/node105_4_2.txt 86"
    "./result_8chains/node105_5_0.txt 85"
    "./result_8chains/node105_5_2.txt 85"
    "./result_8chains/node105_6_0.txt 84"
    "./result_8chains/node105_6_2.txt 84"
    "./result_8chains/node105_7_0.txt 83"
    "./result_8chains/node105_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
