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
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_2 -p 75 -st topic189_0_1 -pt None -u 0.016212050934931888 > ./result_8chains/node189_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_2 -p 150 -st topic189_1_1 -pt None -u 0.0437001876358164 > ./result_8chains/node189_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_2 -p 277 -st topic189_2_1 -pt None -u 0.020009010331693333 > ./result_8chains/node189_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_2 -p 307 -st topic189_3_1 -pt None -u 0.022232822532411184 > ./result_8chains/node189_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_2 -p 324 -st topic189_4_1 -pt None -u 0.021626545324091404 > ./result_8chains/node189_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_2 -p 357 -st topic189_5_1 -pt None -u 0.019508475701440153 > ./result_8chains/node189_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_6_2 -p 565 -st topic189_6_1 -pt None -u 0.001717152205943269 > ./result_8chains/node189_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_7_2 -p 707 -st topic189_7_1 -pt None -u 0.019067617216046242 > ./result_8chains/node189_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_0_0 -p 75 -st none -pt topic189_0_0 -u 0.07794855311731952 > ./result_8chains/node189_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_1_0 -p 150 -st none -pt topic189_1_0 -u 0.03363491916086225 > ./result_8chains/node189_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_2_0 -p 277 -st none -pt topic189_2_0 -u 0.003345350449365625 > ./result_8chains/node189_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_3_0 -p 307 -st none -pt topic189_3_0 -u 0.011980765168869423 > ./result_8chains/node189_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_4_0 -p 324 -st none -pt topic189_4_0 -u 0.0011475105802433994 > ./result_8chains/node189_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_5_0 -p 357 -st none -pt topic189_5_0 -u 0.008754712479784932 > ./result_8chains/node189_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node189_6_0 -p 565 -st none -pt topic189_6_0 -u 0.029698890851726098 > ./result_8chains/node189_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node189_7_0 -p 707 -st none -pt topic189_7_0 -u 0.002159684367116093 > ./result_8chains/node189_7_0.txt &
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
    "./result_8chains/node189_0_0.txt 90"
    "./result_8chains/node189_0_2.txt 90"
    "./result_8chains/node189_1_0.txt 89"
    "./result_8chains/node189_1_2.txt 89"
    "./result_8chains/node189_2_0.txt 88"
    "./result_8chains/node189_2_2.txt 88"
    "./result_8chains/node189_3_0.txt 87"
    "./result_8chains/node189_3_2.txt 87"
    "./result_8chains/node189_4_0.txt 86"
    "./result_8chains/node189_4_2.txt 86"
    "./result_8chains/node189_5_0.txt 85"
    "./result_8chains/node189_5_2.txt 85"
    "./result_8chains/node189_6_0.txt 84"
    "./result_8chains/node189_6_2.txt 84"
    "./result_8chains/node189_7_0.txt 83"
    "./result_8chains/node189_7_2.txt 83"
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
