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
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_2 -p 22 -st topic353_0_1 -pt None -u 0.030829599010402386 > ./result_10chains/node353_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_2 -p 68 -st topic353_1_1 -pt None -u 0.010565903330165605 > ./result_10chains/node353_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_2 -p 146 -st topic353_2_1 -pt None -u 0.007948254373849772 > ./result_10chains/node353_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_2 -p 147 -st topic353_3_1 -pt None -u 0.026841483161517243 > ./result_10chains/node353_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_2 -p 328 -st topic353_4_1 -pt None -u 0.0064056992852958294 > ./result_10chains/node353_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_2 -p 531 -st topic353_5_1 -pt None -u 0.02671049981495663 > ./result_10chains/node353_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_6_2 -p 569 -st topic353_6_1 -pt None -u 0.000493301050051298 > ./result_10chains/node353_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_7_2 -p 711 -st topic353_7_1 -pt None -u 0.03502067747653828 > ./result_10chains/node353_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_8_2 -p 776 -st topic353_8_1 -pt None -u 0.004137930636648211 > ./result_10chains/node353_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_9_2 -p 921 -st topic353_9_1 -pt None -u 0.015645685513309842 > ./result_10chains/node353_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_0 -p 22 -st none -pt topic353_0_0 -u 0.002491858081017706 > ./result_10chains/node353_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_0 -p 68 -st none -pt topic353_1_0 -u 0.009386907928786548 > ./result_10chains/node353_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_0 -p 146 -st none -pt topic353_2_0 -u 0.0032215915457991517 > ./result_10chains/node353_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_0 -p 147 -st none -pt topic353_3_0 -u 0.06645707903388842 > ./result_10chains/node353_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_0 -p 328 -st none -pt topic353_4_0 -u 0.011141264676976875 > ./result_10chains/node353_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_0 -p 531 -st none -pt topic353_5_0 -u 0.015683471301910057 > ./result_10chains/node353_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_6_0 -p 569 -st none -pt topic353_6_0 -u 0.03506041261860099 > ./result_10chains/node353_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_7_0 -p 711 -st none -pt topic353_7_0 -u 0.008204507776705644 > ./result_10chains/node353_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_8_0 -p 776 -st none -pt topic353_8_0 -u 0.007766529244670306 > ./result_10chains/node353_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_9_0 -p 921 -st none -pt topic353_9_0 -u 0.02256758692222756 > ./result_10chains/node353_9_0.txt &
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
    "./result_10chains/node353_0_0.txt 90"
    "./result_10chains/node353_0_2.txt 90"
    "./result_10chains/node353_1_0.txt 89"
    "./result_10chains/node353_1_2.txt 89"
    "./result_10chains/node353_2_0.txt 88"
    "./result_10chains/node353_2_2.txt 88"
    "./result_10chains/node353_3_0.txt 87"
    "./result_10chains/node353_3_2.txt 87"
    "./result_10chains/node353_4_0.txt 86"
    "./result_10chains/node353_4_2.txt 86"
    "./result_10chains/node353_5_0.txt 85"
    "./result_10chains/node353_5_2.txt 85"
    "./result_10chains/node353_6_0.txt 84"
    "./result_10chains/node353_6_2.txt 84"
    "./result_10chains/node353_7_0.txt 83"
    "./result_10chains/node353_7_2.txt 83"
    "./result_10chains/node353_8_0.txt 82"
    "./result_10chains/node353_8_2.txt 82"
    "./result_10chains/node353_9_0.txt 81"
    "./result_10chains/node353_9_2.txt 81"
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
