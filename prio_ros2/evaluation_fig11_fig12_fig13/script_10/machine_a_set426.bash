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
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_2 -p 159 -st topic426_0_1 -pt None -u 0.02018408272558725 > ./result_10chains/node426_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_2 -p 207 -st topic426_1_1 -pt None -u 0.03868236377945622 > ./result_10chains/node426_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_2 -p 231 -st topic426_2_1 -pt None -u 0.0063974916309036955 > ./result_10chains/node426_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_2 -p 242 -st topic426_3_1 -pt None -u 0.004081177255748691 > ./result_10chains/node426_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_2 -p 481 -st topic426_4_1 -pt None -u 0.037702041352305427 > ./result_10chains/node426_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_2 -p 645 -st topic426_5_1 -pt None -u 0.012014198748484195 > ./result_10chains/node426_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_6_2 -p 764 -st topic426_6_1 -pt None -u 0.014706547095476558 > ./result_10chains/node426_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_7_2 -p 810 -st topic426_7_1 -pt None -u 0.029208736559266743 > ./result_10chains/node426_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_8_2 -p 943 -st topic426_8_1 -pt None -u 0.010439944380511879 > ./result_10chains/node426_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_9_2 -p 986 -st topic426_9_1 -pt None -u 0.03452368761121337 > ./result_10chains/node426_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_0 -p 159 -st none -pt topic426_0_0 -u 0.0064450202144260005 > ./result_10chains/node426_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_0 -p 207 -st none -pt topic426_1_0 -u 0.014527149548650864 > ./result_10chains/node426_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_0 -p 231 -st none -pt topic426_2_0 -u 0.012871240683438145 > ./result_10chains/node426_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_0 -p 242 -st none -pt topic426_3_0 -u 0.0031677549377564507 > ./result_10chains/node426_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_0 -p 481 -st none -pt topic426_4_0 -u 0.004949349783793078 > ./result_10chains/node426_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_0 -p 645 -st none -pt topic426_5_0 -u 0.05070419846824947 > ./result_10chains/node426_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_6_0 -p 764 -st none -pt topic426_6_0 -u 0.00869791950437862 > ./result_10chains/node426_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_7_0 -p 810 -st none -pt topic426_7_0 -u 0.03780325450964386 > ./result_10chains/node426_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_8_0 -p 943 -st none -pt topic426_8_0 -u 0.009412281599569985 > ./result_10chains/node426_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_9_0 -p 986 -st none -pt topic426_9_0 -u 0.003910877104304926 > ./result_10chains/node426_9_0.txt &
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
    "./result_10chains/node426_0_0.txt 90"
    "./result_10chains/node426_0_2.txt 90"
    "./result_10chains/node426_1_0.txt 89"
    "./result_10chains/node426_1_2.txt 89"
    "./result_10chains/node426_2_0.txt 88"
    "./result_10chains/node426_2_2.txt 88"
    "./result_10chains/node426_3_0.txt 87"
    "./result_10chains/node426_3_2.txt 87"
    "./result_10chains/node426_4_0.txt 86"
    "./result_10chains/node426_4_2.txt 86"
    "./result_10chains/node426_5_0.txt 85"
    "./result_10chains/node426_5_2.txt 85"
    "./result_10chains/node426_6_0.txt 84"
    "./result_10chains/node426_6_2.txt 84"
    "./result_10chains/node426_7_0.txt 83"
    "./result_10chains/node426_7_2.txt 83"
    "./result_10chains/node426_8_0.txt 82"
    "./result_10chains/node426_8_2.txt 82"
    "./result_10chains/node426_9_0.txt 81"
    "./result_10chains/node426_9_2.txt 81"
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
