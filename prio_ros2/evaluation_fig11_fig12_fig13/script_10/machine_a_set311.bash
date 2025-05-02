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
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_2 -p 179 -st topic311_0_1 -pt None -u 0.03723868779904688 > ./result_10chains/node311_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_2 -p 372 -st topic311_1_1 -pt None -u 0.011344853009731592 > ./result_10chains/node311_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_2 -p 384 -st topic311_2_1 -pt None -u 0.005528361083800393 > ./result_10chains/node311_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_2 -p 427 -st topic311_3_1 -pt None -u 0.007210922968541589 > ./result_10chains/node311_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_2 -p 465 -st topic311_4_1 -pt None -u 0.009938329663168155 > ./result_10chains/node311_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_2 -p 570 -st topic311_5_1 -pt None -u 0.009582497664327672 > ./result_10chains/node311_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_6_2 -p 648 -st topic311_6_1 -pt None -u 0.004872763483265735 > ./result_10chains/node311_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_7_2 -p 777 -st topic311_7_1 -pt None -u 0.022364431388948253 > ./result_10chains/node311_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_8_2 -p 791 -st topic311_8_1 -pt None -u 0.001924266177157033 > ./result_10chains/node311_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_9_2 -p 928 -st topic311_9_1 -pt None -u 0.020043691879470124 > ./result_10chains/node311_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_0 -p 179 -st none -pt topic311_0_0 -u 0.0013878366979372392 > ./result_10chains/node311_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_0 -p 372 -st none -pt topic311_1_0 -u 0.03925206770602435 > ./result_10chains/node311_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_0 -p 384 -st none -pt topic311_2_0 -u 0.027309058738270664 > ./result_10chains/node311_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_0 -p 427 -st none -pt topic311_3_0 -u 0.018002393495454794 > ./result_10chains/node311_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_0 -p 465 -st none -pt topic311_4_0 -u 0.002773417472381079 > ./result_10chains/node311_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_0 -p 570 -st none -pt topic311_5_0 -u 0.0024021475669507297 > ./result_10chains/node311_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_6_0 -p 648 -st none -pt topic311_6_0 -u 0.010369838890854355 > ./result_10chains/node311_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_7_0 -p 777 -st none -pt topic311_7_0 -u 0.003154075764589509 > ./result_10chains/node311_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_8_0 -p 791 -st none -pt topic311_8_0 -u 0.01008792441716272 > ./result_10chains/node311_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_9_0 -p 928 -st none -pt topic311_9_0 -u 0.024526485007022522 > ./result_10chains/node311_9_0.txt &
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
    "./result_10chains/node311_0_0.txt 90"
    "./result_10chains/node311_0_2.txt 90"
    "./result_10chains/node311_1_0.txt 89"
    "./result_10chains/node311_1_2.txt 89"
    "./result_10chains/node311_2_0.txt 88"
    "./result_10chains/node311_2_2.txt 88"
    "./result_10chains/node311_3_0.txt 87"
    "./result_10chains/node311_3_2.txt 87"
    "./result_10chains/node311_4_0.txt 86"
    "./result_10chains/node311_4_2.txt 86"
    "./result_10chains/node311_5_0.txt 85"
    "./result_10chains/node311_5_2.txt 85"
    "./result_10chains/node311_6_0.txt 84"
    "./result_10chains/node311_6_2.txt 84"
    "./result_10chains/node311_7_0.txt 83"
    "./result_10chains/node311_7_2.txt 83"
    "./result_10chains/node311_8_0.txt 82"
    "./result_10chains/node311_8_2.txt 82"
    "./result_10chains/node311_9_0.txt 81"
    "./result_10chains/node311_9_2.txt 81"
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
