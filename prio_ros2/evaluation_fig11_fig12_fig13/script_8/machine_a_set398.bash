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
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_2 -p 10 -st topic398_0_1 -pt None -u 0.043315633428534284 > ./result_8chains/node398_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_2 -p 65 -st topic398_1_1 -pt None -u 0.003338038073642191 > ./result_8chains/node398_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_2 -p 533 -st topic398_2_1 -pt None -u 0.022467633096914186 > ./result_8chains/node398_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_2 -p 588 -st topic398_3_1 -pt None -u 0.020869288397580454 > ./result_8chains/node398_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_4_2 -p 629 -st topic398_4_1 -pt None -u 0.049800447471477216 > ./result_8chains/node398_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_5_2 -p 634 -st topic398_5_1 -pt None -u 0.010742718493063769 > ./result_8chains/node398_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_6_2 -p 946 -st topic398_6_1 -pt None -u 0.02316667217790959 > ./result_8chains/node398_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_7_2 -p 957 -st topic398_7_1 -pt None -u 0.009226570821138546 > ./result_8chains/node398_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_0 -p 10 -st none -pt topic398_0_0 -u 0.010338113662699266 > ./result_8chains/node398_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_0 -p 65 -st none -pt topic398_1_0 -u 0.03483853872048026 > ./result_8chains/node398_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_0 -p 533 -st none -pt topic398_2_0 -u 0.00818609713910562 > ./result_8chains/node398_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_0 -p 588 -st none -pt topic398_3_0 -u 0.006377004671268172 > ./result_8chains/node398_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_4_0 -p 629 -st none -pt topic398_4_0 -u 0.014069311711011362 > ./result_8chains/node398_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_5_0 -p 634 -st none -pt topic398_5_0 -u 0.0019458639815512768 > ./result_8chains/node398_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_6_0 -p 946 -st none -pt topic398_6_0 -u 0.007399974320295211 > ./result_8chains/node398_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_7_0 -p 957 -st none -pt topic398_7_0 -u 0.04368048398009406 > ./result_8chains/node398_7_0.txt &
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
    "./result_8chains/node398_0_0.txt 90"
    "./result_8chains/node398_0_2.txt 90"
    "./result_8chains/node398_1_0.txt 89"
    "./result_8chains/node398_1_2.txt 89"
    "./result_8chains/node398_2_0.txt 88"
    "./result_8chains/node398_2_2.txt 88"
    "./result_8chains/node398_3_0.txt 87"
    "./result_8chains/node398_3_2.txt 87"
    "./result_8chains/node398_4_0.txt 86"
    "./result_8chains/node398_4_2.txt 86"
    "./result_8chains/node398_5_0.txt 85"
    "./result_8chains/node398_5_2.txt 85"
    "./result_8chains/node398_6_0.txt 84"
    "./result_8chains/node398_6_2.txt 84"
    "./result_8chains/node398_7_0.txt 83"
    "./result_8chains/node398_7_2.txt 83"
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
