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
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_2 -p 122 -st topic105_0_1 -pt None -u 0.013689650457336222 > ./result_10chains/node105_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_2 -p 133 -st topic105_1_1 -pt None -u 0.0013725823497454659 > ./result_10chains/node105_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_2 -p 199 -st topic105_2_1 -pt None -u 0.003670682247138124 > ./result_10chains/node105_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_2 -p 382 -st topic105_3_1 -pt None -u 0.023732880581789795 > ./result_10chains/node105_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_2 -p 450 -st topic105_4_1 -pt None -u 0.020008896221323014 > ./result_10chains/node105_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_2 -p 544 -st topic105_5_1 -pt None -u 0.01905621824412415 > ./result_10chains/node105_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_6_2 -p 610 -st topic105_6_1 -pt None -u 0.004495445022389022 > ./result_10chains/node105_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_7_2 -p 626 -st topic105_7_1 -pt None -u 0.028665259360456052 > ./result_10chains/node105_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_8_2 -p 657 -st topic105_8_1 -pt None -u 0.022851361992270402 > ./result_10chains/node105_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_9_2 -p 913 -st topic105_9_1 -pt None -u 0.008311668629201147 > ./result_10chains/node105_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_0 -p 122 -st none -pt topic105_0_0 -u 0.032597242458048015 > ./result_10chains/node105_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_0 -p 133 -st none -pt topic105_1_0 -u 0.00787167435447289 > ./result_10chains/node105_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_0 -p 199 -st none -pt topic105_2_0 -u 0.001268704945642296 > ./result_10chains/node105_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_0 -p 382 -st none -pt topic105_3_0 -u 0.005978300410434234 > ./result_10chains/node105_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_0 -p 450 -st none -pt topic105_4_0 -u 0.007784527102543959 > ./result_10chains/node105_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_0 -p 544 -st none -pt topic105_5_0 -u 0.005452970432646309 > ./result_10chains/node105_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_6_0 -p 610 -st none -pt topic105_6_0 -u 0.011425874711159884 > ./result_10chains/node105_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_7_0 -p 626 -st none -pt topic105_7_0 -u 0.009222897949594494 > ./result_10chains/node105_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_8_0 -p 657 -st none -pt topic105_8_0 -u 0.017399006063474443 > ./result_10chains/node105_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_9_0 -p 913 -st none -pt topic105_9_0 -u 0.004867517473873106 > ./result_10chains/node105_9_0.txt &
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
    "./result_10chains/node105_0_0.txt 90"
    "./result_10chains/node105_0_2.txt 90"
    "./result_10chains/node105_1_0.txt 89"
    "./result_10chains/node105_1_2.txt 89"
    "./result_10chains/node105_2_0.txt 88"
    "./result_10chains/node105_2_2.txt 88"
    "./result_10chains/node105_3_0.txt 87"
    "./result_10chains/node105_3_2.txt 87"
    "./result_10chains/node105_4_0.txt 86"
    "./result_10chains/node105_4_2.txt 86"
    "./result_10chains/node105_5_0.txt 85"
    "./result_10chains/node105_5_2.txt 85"
    "./result_10chains/node105_6_0.txt 84"
    "./result_10chains/node105_6_2.txt 84"
    "./result_10chains/node105_7_0.txt 83"
    "./result_10chains/node105_7_2.txt 83"
    "./result_10chains/node105_8_0.txt 82"
    "./result_10chains/node105_8_2.txt 82"
    "./result_10chains/node105_9_0.txt 81"
    "./result_10chains/node105_9_2.txt 81"
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
