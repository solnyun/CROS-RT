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
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_2 -p 45 -st topic90_0_1 -pt None -u 0.035497003957378315 > ./result_8chains/node90_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_2 -p 198 -st topic90_1_1 -pt None -u 0.006093890568601101 > ./result_8chains/node90_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_2 -p 284 -st topic90_2_1 -pt None -u 0.006079987164655909 > ./result_8chains/node90_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_2 -p 414 -st topic90_3_1 -pt None -u 0.01841638040534138 > ./result_8chains/node90_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_2 -p 513 -st topic90_4_1 -pt None -u 0.033566546000471126 > ./result_8chains/node90_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_2 -p 538 -st topic90_5_1 -pt None -u 0.013692412608188986 > ./result_8chains/node90_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_6_2 -p 756 -st topic90_6_1 -pt None -u 0.05352802421458977 > ./result_8chains/node90_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_7_2 -p 835 -st topic90_7_1 -pt None -u 0.019738515221285533 > ./result_8chains/node90_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_0 -p 45 -st none -pt topic90_0_0 -u 0.03693562736164291 > ./result_8chains/node90_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_0 -p 198 -st none -pt topic90_1_0 -u 0.021441915428675185 > ./result_8chains/node90_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_0 -p 284 -st none -pt topic90_2_0 -u 0.005207990931017092 > ./result_8chains/node90_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_0 -p 414 -st none -pt topic90_3_0 -u 0.03327840838613805 > ./result_8chains/node90_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_0 -p 513 -st none -pt topic90_4_0 -u 0.0211386492269946 > ./result_8chains/node90_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_0 -p 538 -st none -pt topic90_5_0 -u 0.008775837024763561 > ./result_8chains/node90_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_6_0 -p 756 -st none -pt topic90_6_0 -u 0.019033473347886257 > ./result_8chains/node90_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node90_7_0 -p 835 -st none -pt topic90_7_0 -u 0.0015070617695585944 > ./result_8chains/node90_7_0.txt &
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
    "./result_8chains/node90_0_0.txt 90"
    "./result_8chains/node90_0_2.txt 90"
    "./result_8chains/node90_1_0.txt 89"
    "./result_8chains/node90_1_2.txt 89"
    "./result_8chains/node90_2_0.txt 88"
    "./result_8chains/node90_2_2.txt 88"
    "./result_8chains/node90_3_0.txt 87"
    "./result_8chains/node90_3_2.txt 87"
    "./result_8chains/node90_4_0.txt 86"
    "./result_8chains/node90_4_2.txt 86"
    "./result_8chains/node90_5_0.txt 85"
    "./result_8chains/node90_5_2.txt 85"
    "./result_8chains/node90_6_0.txt 84"
    "./result_8chains/node90_6_2.txt 84"
    "./result_8chains/node90_7_0.txt 83"
    "./result_8chains/node90_7_2.txt 83"
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
