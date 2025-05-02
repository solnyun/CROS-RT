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
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_2 -p 28 -st topic451_0_1 -pt None -u 0.015008550533389231 > ./result_10chains/node451_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_2 -p 96 -st topic451_1_1 -pt None -u 0.001467277127220279 > ./result_10chains/node451_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_2 -p 153 -st topic451_2_1 -pt None -u 0.004752202392871219 > ./result_10chains/node451_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_2 -p 209 -st topic451_3_1 -pt None -u 0.00904050419249014 > ./result_10chains/node451_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_2 -p 347 -st topic451_4_1 -pt None -u 0.008203545356406494 > ./result_10chains/node451_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_2 -p 425 -st topic451_5_1 -pt None -u 0.00862854285963334 > ./result_10chains/node451_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_6_2 -p 503 -st topic451_6_1 -pt None -u 0.024936891322922858 > ./result_10chains/node451_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_7_2 -p 520 -st topic451_7_1 -pt None -u 0.015660163914929907 > ./result_10chains/node451_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_8_2 -p 582 -st topic451_8_1 -pt None -u 0.01858458424038605 > ./result_10chains/node451_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_9_2 -p 961 -st topic451_9_1 -pt None -u 0.0004008429522072663 > ./result_10chains/node451_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_0_0 -p 28 -st none -pt topic451_0_0 -u 0.007570807542109093 > ./result_10chains/node451_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_1_0 -p 96 -st none -pt topic451_1_0 -u 0.0652779909123527 > ./result_10chains/node451_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_2_0 -p 153 -st none -pt topic451_2_0 -u 0.00025535074285287784 > ./result_10chains/node451_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_3_0 -p 209 -st none -pt topic451_3_0 -u 0.0028389587954403273 > ./result_10chains/node451_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_4_0 -p 347 -st none -pt topic451_4_0 -u 0.019578759708875848 > ./result_10chains/node451_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_5_0 -p 425 -st none -pt topic451_5_0 -u 0.04234151551516721 > ./result_10chains/node451_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_6_0 -p 503 -st none -pt topic451_6_0 -u 0.017043894116539116 > ./result_10chains/node451_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_7_0 -p 520 -st none -pt topic451_7_0 -u 0.00014817712288899 > ./result_10chains/node451_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node451_8_0 -p 582 -st none -pt topic451_8_0 -u 0.016921118231258893 > ./result_10chains/node451_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node451_9_0 -p 961 -st none -pt topic451_9_0 -u 0.008113325768149507 > ./result_10chains/node451_9_0.txt &
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
    "./result_10chains/node451_0_0.txt 90"
    "./result_10chains/node451_0_2.txt 90"
    "./result_10chains/node451_1_0.txt 89"
    "./result_10chains/node451_1_2.txt 89"
    "./result_10chains/node451_2_0.txt 88"
    "./result_10chains/node451_2_2.txt 88"
    "./result_10chains/node451_3_0.txt 87"
    "./result_10chains/node451_3_2.txt 87"
    "./result_10chains/node451_4_0.txt 86"
    "./result_10chains/node451_4_2.txt 86"
    "./result_10chains/node451_5_0.txt 85"
    "./result_10chains/node451_5_2.txt 85"
    "./result_10chains/node451_6_0.txt 84"
    "./result_10chains/node451_6_2.txt 84"
    "./result_10chains/node451_7_0.txt 83"
    "./result_10chains/node451_7_2.txt 83"
    "./result_10chains/node451_8_0.txt 82"
    "./result_10chains/node451_8_2.txt 82"
    "./result_10chains/node451_9_0.txt 81"
    "./result_10chains/node451_9_2.txt 81"
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
