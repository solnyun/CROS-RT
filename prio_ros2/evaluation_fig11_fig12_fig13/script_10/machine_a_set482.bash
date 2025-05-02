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
ros2 run evaluation_3_randomdag uunifast_node -n node482_0_2 -p 44 -st topic482_0_1 -pt None -u 0.016810492701192337 > ./result_10chains/node482_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_1_2 -p 94 -st topic482_1_1 -pt None -u 0.003584247633738824 > ./result_10chains/node482_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_2_2 -p 181 -st topic482_2_1 -pt None -u 0.0033915208094112415 > ./result_10chains/node482_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_3_2 -p 244 -st topic482_3_1 -pt None -u 0.022800929617075694 > ./result_10chains/node482_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_4_2 -p 399 -st topic482_4_1 -pt None -u 0.00227926165278175 > ./result_10chains/node482_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_5_2 -p 420 -st topic482_5_1 -pt None -u 0.014726844674880057 > ./result_10chains/node482_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_6_2 -p 450 -st topic482_6_1 -pt None -u 0.01886788711577668 > ./result_10chains/node482_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_7_2 -p 475 -st topic482_7_1 -pt None -u 0.019117877046844062 > ./result_10chains/node482_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_8_2 -p 757 -st topic482_8_1 -pt None -u 0.005430632932111237 > ./result_10chains/node482_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_9_2 -p 958 -st topic482_9_1 -pt None -u 0.007973759864460115 > ./result_10chains/node482_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_0_0 -p 44 -st none -pt topic482_0_0 -u 0.010101525933806588 > ./result_10chains/node482_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_1_0 -p 94 -st none -pt topic482_1_0 -u 0.00579024235270692 > ./result_10chains/node482_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_2_0 -p 181 -st none -pt topic482_2_0 -u 0.03228082835811985 > ./result_10chains/node482_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_3_0 -p 244 -st none -pt topic482_3_0 -u 0.06419396713388825 > ./result_10chains/node482_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_4_0 -p 399 -st none -pt topic482_4_0 -u 0.02379366894623197 > ./result_10chains/node482_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_5_0 -p 420 -st none -pt topic482_5_0 -u 0.022839880278227587 > ./result_10chains/node482_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_6_0 -p 450 -st none -pt topic482_6_0 -u 0.010221108425699094 > ./result_10chains/node482_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_7_0 -p 475 -st none -pt topic482_7_0 -u 0.025390071016717308 > ./result_10chains/node482_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_8_0 -p 757 -st none -pt topic482_8_0 -u 0.0026803408014644606 > ./result_10chains/node482_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_9_0 -p 958 -st none -pt topic482_9_0 -u 0.004439061259356995 > ./result_10chains/node482_9_0.txt &
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
    "./result_10chains/node482_0_0.txt 90"
    "./result_10chains/node482_0_2.txt 90"
    "./result_10chains/node482_1_0.txt 89"
    "./result_10chains/node482_1_2.txt 89"
    "./result_10chains/node482_2_0.txt 88"
    "./result_10chains/node482_2_2.txt 88"
    "./result_10chains/node482_3_0.txt 87"
    "./result_10chains/node482_3_2.txt 87"
    "./result_10chains/node482_4_0.txt 86"
    "./result_10chains/node482_4_2.txt 86"
    "./result_10chains/node482_5_0.txt 85"
    "./result_10chains/node482_5_2.txt 85"
    "./result_10chains/node482_6_0.txt 84"
    "./result_10chains/node482_6_2.txt 84"
    "./result_10chains/node482_7_0.txt 83"
    "./result_10chains/node482_7_2.txt 83"
    "./result_10chains/node482_8_0.txt 82"
    "./result_10chains/node482_8_2.txt 82"
    "./result_10chains/node482_9_0.txt 81"
    "./result_10chains/node482_9_2.txt 81"
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
