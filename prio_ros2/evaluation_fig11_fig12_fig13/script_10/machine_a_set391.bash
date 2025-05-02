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
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_2 -p 13 -st topic391_0_1 -pt None -u 0.0013494340584975784 > ./result_10chains/node391_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_2 -p 218 -st topic391_1_1 -pt None -u 0.007178119860234977 > ./result_10chains/node391_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_2 -p 260 -st topic391_2_1 -pt None -u 0.001415719447878161 > ./result_10chains/node391_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_2 -p 375 -st topic391_3_1 -pt None -u 0.012177194167470595 > ./result_10chains/node391_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_2 -p 452 -st topic391_4_1 -pt None -u 0.04580723848567564 > ./result_10chains/node391_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_2 -p 665 -st topic391_5_1 -pt None -u 0.0064509687778065705 > ./result_10chains/node391_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_6_2 -p 698 -st topic391_6_1 -pt None -u 0.0075752323941074284 > ./result_10chains/node391_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_7_2 -p 717 -st topic391_7_1 -pt None -u 0.0030345822191326643 > ./result_10chains/node391_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_8_2 -p 980 -st topic391_8_1 -pt None -u 0.012151571835882925 > ./result_10chains/node391_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_9_2 -p 983 -st topic391_9_1 -pt None -u 0.010100881366469812 > ./result_10chains/node391_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_0 -p 13 -st none -pt topic391_0_0 -u 0.022334584471705943 > ./result_10chains/node391_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_0 -p 218 -st none -pt topic391_1_0 -u 0.0032989447810169437 > ./result_10chains/node391_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_0 -p 260 -st none -pt topic391_2_0 -u 0.00027497524710251575 > ./result_10chains/node391_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_0 -p 375 -st none -pt topic391_3_0 -u 0.0330435843479881 > ./result_10chains/node391_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_0 -p 452 -st none -pt topic391_4_0 -u 0.0036049420866585136 > ./result_10chains/node391_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_0 -p 665 -st none -pt topic391_5_0 -u 0.0328232277903045 > ./result_10chains/node391_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_6_0 -p 698 -st none -pt topic391_6_0 -u 0.0117387849835566 > ./result_10chains/node391_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_7_0 -p 717 -st none -pt topic391_7_0 -u 0.00041844130641058297 > ./result_10chains/node391_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_8_0 -p 980 -st none -pt topic391_8_0 -u 0.024805667965952807 > ./result_10chains/node391_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_9_0 -p 983 -st none -pt topic391_9_0 -u 0.029457643236556478 > ./result_10chains/node391_9_0.txt &
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
    "./result_10chains/node391_0_0.txt 90"
    "./result_10chains/node391_0_2.txt 90"
    "./result_10chains/node391_1_0.txt 89"
    "./result_10chains/node391_1_2.txt 89"
    "./result_10chains/node391_2_0.txt 88"
    "./result_10chains/node391_2_2.txt 88"
    "./result_10chains/node391_3_0.txt 87"
    "./result_10chains/node391_3_2.txt 87"
    "./result_10chains/node391_4_0.txt 86"
    "./result_10chains/node391_4_2.txt 86"
    "./result_10chains/node391_5_0.txt 85"
    "./result_10chains/node391_5_2.txt 85"
    "./result_10chains/node391_6_0.txt 84"
    "./result_10chains/node391_6_2.txt 84"
    "./result_10chains/node391_7_0.txt 83"
    "./result_10chains/node391_7_2.txt 83"
    "./result_10chains/node391_8_0.txt 82"
    "./result_10chains/node391_8_2.txt 82"
    "./result_10chains/node391_9_0.txt 81"
    "./result_10chains/node391_9_2.txt 81"
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
