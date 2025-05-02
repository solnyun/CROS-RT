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
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_2 -p 360 -st topic193_0_1 -pt None -u 0.02654517922763261 > ./result_10chains/node193_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_2 -p 408 -st topic193_1_1 -pt None -u 0.05526327162082406 > ./result_10chains/node193_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_2 -p 490 -st topic193_2_1 -pt None -u 0.017742612659264134 > ./result_10chains/node193_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_2 -p 562 -st topic193_3_1 -pt None -u 0.007904050367336934 > ./result_10chains/node193_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_2 -p 683 -st topic193_4_1 -pt None -u 0.002205281505091722 > ./result_10chains/node193_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_2 -p 740 -st topic193_5_1 -pt None -u 0.009440445865473851 > ./result_10chains/node193_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_6_2 -p 779 -st topic193_6_1 -pt None -u 0.010076918443810062 > ./result_10chains/node193_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_7_2 -p 800 -st topic193_7_1 -pt None -u 0.04233621039129168 > ./result_10chains/node193_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_8_2 -p 864 -st topic193_8_1 -pt None -u 0.0026867972496257414 > ./result_10chains/node193_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_9_2 -p 868 -st topic193_9_1 -pt None -u 0.012377502930379924 > ./result_10chains/node193_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_0_0 -p 360 -st none -pt topic193_0_0 -u 0.008833985202938432 > ./result_10chains/node193_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_1_0 -p 408 -st none -pt topic193_1_0 -u 0.008616558804505292 > ./result_10chains/node193_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_2_0 -p 490 -st none -pt topic193_2_0 -u 0.010973140483317656 > ./result_10chains/node193_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_3_0 -p 562 -st none -pt topic193_3_0 -u 0.003909336092819515 > ./result_10chains/node193_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_4_0 -p 683 -st none -pt topic193_4_0 -u 0.02268453114296659 > ./result_10chains/node193_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_5_0 -p 740 -st none -pt topic193_5_0 -u 0.04690322404455233 > ./result_10chains/node193_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_6_0 -p 779 -st none -pt topic193_6_0 -u 0.009031280418710097 > ./result_10chains/node193_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_7_0 -p 800 -st none -pt topic193_7_0 -u 0.022854175339943494 > ./result_10chains/node193_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node193_8_0 -p 864 -st none -pt topic193_8_0 -u 0.01596222539994227 > ./result_10chains/node193_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node193_9_0 -p 868 -st none -pt topic193_9_0 -u 0.0241034182153746 > ./result_10chains/node193_9_0.txt &
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
    "./result_10chains/node193_0_0.txt 90"
    "./result_10chains/node193_0_2.txt 90"
    "./result_10chains/node193_1_0.txt 89"
    "./result_10chains/node193_1_2.txt 89"
    "./result_10chains/node193_2_0.txt 88"
    "./result_10chains/node193_2_2.txt 88"
    "./result_10chains/node193_3_0.txt 87"
    "./result_10chains/node193_3_2.txt 87"
    "./result_10chains/node193_4_0.txt 86"
    "./result_10chains/node193_4_2.txt 86"
    "./result_10chains/node193_5_0.txt 85"
    "./result_10chains/node193_5_2.txt 85"
    "./result_10chains/node193_6_0.txt 84"
    "./result_10chains/node193_6_2.txt 84"
    "./result_10chains/node193_7_0.txt 83"
    "./result_10chains/node193_7_2.txt 83"
    "./result_10chains/node193_8_0.txt 82"
    "./result_10chains/node193_8_2.txt 82"
    "./result_10chains/node193_9_0.txt 81"
    "./result_10chains/node193_9_2.txt 81"
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
