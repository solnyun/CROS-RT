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
ros2 run evaluation_3_randomdag uunifast_node -n node136_0_2 -p 60 -st topic136_0_1 -pt None -u 0.012237504158056745 > ./result_10chains/node136_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_1_2 -p 70 -st topic136_1_1 -pt None -u 0.01668173975045495 > ./result_10chains/node136_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_2_2 -p 230 -st topic136_2_1 -pt None -u 0.04140767488613367 > ./result_10chains/node136_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_3_2 -p 316 -st topic136_3_1 -pt None -u 0.0007111218630029281 > ./result_10chains/node136_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_4_2 -p 570 -st topic136_4_1 -pt None -u 0.015281744090762273 > ./result_10chains/node136_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_5_2 -p 656 -st topic136_5_1 -pt None -u 0.029412387038822985 > ./result_10chains/node136_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_6_2 -p 749 -st topic136_6_1 -pt None -u 0.00021214537419769752 > ./result_10chains/node136_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_7_2 -p 934 -st topic136_7_1 -pt None -u 0.031135018021846428 > ./result_10chains/node136_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_8_2 -p 947 -st topic136_8_1 -pt None -u 0.01720836135205292 > ./result_10chains/node136_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_9_2 -p 995 -st topic136_9_1 -pt None -u 0.01686056110777173 > ./result_10chains/node136_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_0_0 -p 60 -st none -pt topic136_0_0 -u 0.015867135773821983 > ./result_10chains/node136_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_1_0 -p 70 -st none -pt topic136_1_0 -u 0.0067009441101216205 > ./result_10chains/node136_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_2_0 -p 230 -st none -pt topic136_2_0 -u 0.0264044837062542 > ./result_10chains/node136_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_3_0 -p 316 -st none -pt topic136_3_0 -u 0.005341980049032191 > ./result_10chains/node136_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_4_0 -p 570 -st none -pt topic136_4_0 -u 0.04897735149520516 > ./result_10chains/node136_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_5_0 -p 656 -st none -pt topic136_5_0 -u 0.0072932308445604055 > ./result_10chains/node136_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_6_0 -p 749 -st none -pt topic136_6_0 -u 0.006772916681911323 > ./result_10chains/node136_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_7_0 -p 934 -st none -pt topic136_7_0 -u 0.01710941404530275 > ./result_10chains/node136_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_8_0 -p 947 -st none -pt topic136_8_0 -u 0.08161201911465059 > ./result_10chains/node136_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_9_0 -p 995 -st none -pt topic136_9_0 -u 0.007872874411412854 > ./result_10chains/node136_9_0.txt &
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
    "./result_10chains/node136_0_0.txt 90"
    "./result_10chains/node136_0_2.txt 90"
    "./result_10chains/node136_1_0.txt 89"
    "./result_10chains/node136_1_2.txt 89"
    "./result_10chains/node136_2_0.txt 88"
    "./result_10chains/node136_2_2.txt 88"
    "./result_10chains/node136_3_0.txt 87"
    "./result_10chains/node136_3_2.txt 87"
    "./result_10chains/node136_4_0.txt 86"
    "./result_10chains/node136_4_2.txt 86"
    "./result_10chains/node136_5_0.txt 85"
    "./result_10chains/node136_5_2.txt 85"
    "./result_10chains/node136_6_0.txt 84"
    "./result_10chains/node136_6_2.txt 84"
    "./result_10chains/node136_7_0.txt 83"
    "./result_10chains/node136_7_2.txt 83"
    "./result_10chains/node136_8_0.txt 82"
    "./result_10chains/node136_8_2.txt 82"
    "./result_10chains/node136_9_0.txt 81"
    "./result_10chains/node136_9_2.txt 81"
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
