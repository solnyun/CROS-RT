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
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_2 -p 26 -st topic249_0_1 -pt None -u 0.003278173163274112 > ./result_10chains/node249_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_2 -p 126 -st topic249_1_1 -pt None -u 0.009208656827921047 > ./result_10chains/node249_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_2 -p 241 -st topic249_2_1 -pt None -u 0.019340629917366903 > ./result_10chains/node249_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_2 -p 331 -st topic249_3_1 -pt None -u 0.009341382510695717 > ./result_10chains/node249_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_2 -p 342 -st topic249_4_1 -pt None -u 0.0004979856374169311 > ./result_10chains/node249_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_2 -p 390 -st topic249_5_1 -pt None -u 0.07219264389269908 > ./result_10chains/node249_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_6_2 -p 728 -st topic249_6_1 -pt None -u 0.0077680761983025814 > ./result_10chains/node249_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_7_2 -p 830 -st topic249_7_1 -pt None -u 0.016359169773069185 > ./result_10chains/node249_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_8_2 -p 858 -st topic249_8_1 -pt None -u 0.05069920092185326 > ./result_10chains/node249_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_9_2 -p 936 -st topic249_9_1 -pt None -u 0.007293584327277985 > ./result_10chains/node249_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_0 -p 26 -st none -pt topic249_0_0 -u 0.012025924033036373 > ./result_10chains/node249_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_0 -p 126 -st none -pt topic249_1_0 -u 0.001955766189852437 > ./result_10chains/node249_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_0 -p 241 -st none -pt topic249_2_0 -u 0.016764289887747363 > ./result_10chains/node249_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_0 -p 331 -st none -pt topic249_3_0 -u 0.007329404341211931 > ./result_10chains/node249_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_0 -p 342 -st none -pt topic249_4_0 -u 0.006558759311178386 > ./result_10chains/node249_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_0 -p 390 -st none -pt topic249_5_0 -u 0.015959069703219475 > ./result_10chains/node249_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_6_0 -p 728 -st none -pt topic249_6_0 -u 0.012027671270153584 > ./result_10chains/node249_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_7_0 -p 830 -st none -pt topic249_7_0 -u 0.007894471133619269 > ./result_10chains/node249_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_8_0 -p 858 -st none -pt topic249_8_0 -u 0.005501178276114543 > ./result_10chains/node249_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_9_0 -p 936 -st none -pt topic249_9_0 -u 0.026438712783518257 > ./result_10chains/node249_9_0.txt &
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
    "./result_10chains/node249_0_0.txt 90"
    "./result_10chains/node249_0_2.txt 90"
    "./result_10chains/node249_1_0.txt 89"
    "./result_10chains/node249_1_2.txt 89"
    "./result_10chains/node249_2_0.txt 88"
    "./result_10chains/node249_2_2.txt 88"
    "./result_10chains/node249_3_0.txt 87"
    "./result_10chains/node249_3_2.txt 87"
    "./result_10chains/node249_4_0.txt 86"
    "./result_10chains/node249_4_2.txt 86"
    "./result_10chains/node249_5_0.txt 85"
    "./result_10chains/node249_5_2.txt 85"
    "./result_10chains/node249_6_0.txt 84"
    "./result_10chains/node249_6_2.txt 84"
    "./result_10chains/node249_7_0.txt 83"
    "./result_10chains/node249_7_2.txt 83"
    "./result_10chains/node249_8_0.txt 82"
    "./result_10chains/node249_8_2.txt 82"
    "./result_10chains/node249_9_0.txt 81"
    "./result_10chains/node249_9_2.txt 81"
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
