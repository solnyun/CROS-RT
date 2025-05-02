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
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_2 -p 51 -st topic26_0_1 -pt None -u 0.027139201297226634 > ./result_10chains/node26_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_2 -p 219 -st topic26_1_1 -pt None -u 0.017829736153357645 > ./result_10chains/node26_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_2 -p 248 -st topic26_2_1 -pt None -u 0.012464722097017267 > ./result_10chains/node26_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_2 -p 548 -st topic26_3_1 -pt None -u 0.055252961981151316 > ./result_10chains/node26_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_2 -p 607 -st topic26_4_1 -pt None -u 0.0241740626835783 > ./result_10chains/node26_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_2 -p 611 -st topic26_5_1 -pt None -u 0.007842212223591716 > ./result_10chains/node26_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_6_2 -p 696 -st topic26_6_1 -pt None -u 0.011952844162732512 > ./result_10chains/node26_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_7_2 -p 905 -st topic26_7_1 -pt None -u 0.03533653489743274 > ./result_10chains/node26_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_8_2 -p 938 -st topic26_8_1 -pt None -u 0.01697203816468501 > ./result_10chains/node26_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_9_2 -p 949 -st topic26_9_1 -pt None -u 0.039452680135737536 > ./result_10chains/node26_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_0 -p 51 -st none -pt topic26_0_0 -u 0.03455413964153681 > ./result_10chains/node26_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_0 -p 219 -st none -pt topic26_1_0 -u 0.00014439346658390306 > ./result_10chains/node26_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_0 -p 248 -st none -pt topic26_2_0 -u 0.01492905836848435 > ./result_10chains/node26_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_0 -p 548 -st none -pt topic26_3_0 -u 0.0029701256909985263 > ./result_10chains/node26_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_0 -p 607 -st none -pt topic26_4_0 -u 0.0014306987849203034 > ./result_10chains/node26_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_0 -p 611 -st none -pt topic26_5_0 -u 0.007522558508167798 > ./result_10chains/node26_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_6_0 -p 696 -st none -pt topic26_6_0 -u 0.005950756408988789 > ./result_10chains/node26_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_7_0 -p 905 -st none -pt topic26_7_0 -u 0.018907156352531262 > ./result_10chains/node26_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_8_0 -p 938 -st none -pt topic26_8_0 -u 0.0007769062665907711 > ./result_10chains/node26_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_9_0 -p 949 -st none -pt topic26_9_0 -u 0.037786630521752185 > ./result_10chains/node26_9_0.txt &
sleep 10
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
    "./result_10chains/node26_0_0.txt 90"
    "./result_10chains/node26_0_2.txt 90"
    "./result_10chains/node26_1_0.txt 89"
    "./result_10chains/node26_1_2.txt 89"
    "./result_10chains/node26_2_0.txt 88"
    "./result_10chains/node26_2_2.txt 88"
    "./result_10chains/node26_3_0.txt 87"
    "./result_10chains/node26_3_2.txt 87"
    "./result_10chains/node26_4_0.txt 86"
    "./result_10chains/node26_4_2.txt 86"
    "./result_10chains/node26_5_0.txt 85"
    "./result_10chains/node26_5_2.txt 85"
    "./result_10chains/node26_6_0.txt 84"
    "./result_10chains/node26_6_2.txt 84"
    "./result_10chains/node26_7_0.txt 83"
    "./result_10chains/node26_7_2.txt 83"
    "./result_10chains/node26_8_0.txt 82"
    "./result_10chains/node26_8_2.txt 82"
    "./result_10chains/node26_9_0.txt 81"
    "./result_10chains/node26_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
