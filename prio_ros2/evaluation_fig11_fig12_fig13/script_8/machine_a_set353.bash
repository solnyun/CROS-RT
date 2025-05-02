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
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_2 -p 224 -st topic353_0_1 -pt None -u 0.005197089267662436 > ./result_8chains/node353_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_2 -p 280 -st topic353_1_1 -pt None -u 0.059202088141011355 > ./result_8chains/node353_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_2 -p 306 -st topic353_2_1 -pt None -u 0.002468518661448982 > ./result_8chains/node353_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_2 -p 345 -st topic353_3_1 -pt None -u 0.012995058577256718 > ./result_8chains/node353_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_2 -p 497 -st topic353_4_1 -pt None -u 0.018152433979930716 > ./result_8chains/node353_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_2 -p 538 -st topic353_5_1 -pt None -u 0.027644330192278896 > ./result_8chains/node353_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_6_2 -p 775 -st topic353_6_1 -pt None -u 0.06573498273083986 > ./result_8chains/node353_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_7_2 -p 901 -st topic353_7_1 -pt None -u 0.005247543220322846 > ./result_8chains/node353_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_0_0 -p 224 -st none -pt topic353_0_0 -u 0.05096720445190184 > ./result_8chains/node353_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_1_0 -p 280 -st none -pt topic353_1_0 -u 0.0074234252340917295 > ./result_8chains/node353_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_2_0 -p 306 -st none -pt topic353_2_0 -u 0.0038221356081151736 > ./result_8chains/node353_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_3_0 -p 345 -st none -pt topic353_3_0 -u 0.012323691268447096 > ./result_8chains/node353_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_4_0 -p 497 -st none -pt topic353_4_0 -u 0.008164223486150118 > ./result_8chains/node353_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_5_0 -p 538 -st none -pt topic353_5_0 -u 0.027554040146475778 > ./result_8chains/node353_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node353_6_0 -p 775 -st none -pt topic353_6_0 -u 0.0027906686938551223 > ./result_8chains/node353_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node353_7_0 -p 901 -st none -pt topic353_7_0 -u 0.0029511638041506624 > ./result_8chains/node353_7_0.txt &
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
    "./result_8chains/node353_0_0.txt 90"
    "./result_8chains/node353_0_2.txt 90"
    "./result_8chains/node353_1_0.txt 89"
    "./result_8chains/node353_1_2.txt 89"
    "./result_8chains/node353_2_0.txt 88"
    "./result_8chains/node353_2_2.txt 88"
    "./result_8chains/node353_3_0.txt 87"
    "./result_8chains/node353_3_2.txt 87"
    "./result_8chains/node353_4_0.txt 86"
    "./result_8chains/node353_4_2.txt 86"
    "./result_8chains/node353_5_0.txt 85"
    "./result_8chains/node353_5_2.txt 85"
    "./result_8chains/node353_6_0.txt 84"
    "./result_8chains/node353_6_2.txt 84"
    "./result_8chains/node353_7_0.txt 83"
    "./result_8chains/node353_7_2.txt 83"
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
