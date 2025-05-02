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
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_2 -p 48 -st topic418_0_1 -pt None -u 0.01745249096627194 > ./result_8chains/node418_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_2 -p 79 -st topic418_1_1 -pt None -u 0.04586124879741238 > ./result_8chains/node418_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_2 -p 163 -st topic418_2_1 -pt None -u 0.012883899775795848 > ./result_8chains/node418_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_2 -p 425 -st topic418_3_1 -pt None -u 0.0025546706583664536 > ./result_8chains/node418_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_2 -p 475 -st topic418_4_1 -pt None -u 0.002313576048874 > ./result_8chains/node418_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_2 -p 515 -st topic418_5_1 -pt None -u 0.03541166532620346 > ./result_8chains/node418_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_6_2 -p 581 -st topic418_6_1 -pt None -u 0.0021453717020670088 > ./result_8chains/node418_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_7_2 -p 678 -st topic418_7_1 -pt None -u 0.019171411594881258 > ./result_8chains/node418_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_0 -p 48 -st none -pt topic418_0_0 -u 0.0034776955361653372 > ./result_8chains/node418_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_0 -p 79 -st none -pt topic418_1_0 -u 0.01895890125324662 > ./result_8chains/node418_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_0 -p 163 -st none -pt topic418_2_0 -u 0.019443062636202102 > ./result_8chains/node418_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_0 -p 425 -st none -pt topic418_3_0 -u 0.037453811333978126 > ./result_8chains/node418_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_0 -p 475 -st none -pt topic418_4_0 -u 0.03103340317152037 > ./result_8chains/node418_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_0 -p 515 -st none -pt topic418_5_0 -u 0.03880739796474217 > ./result_8chains/node418_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_6_0 -p 581 -st none -pt topic418_6_0 -u 0.05070576857736771 > ./result_8chains/node418_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_7_0 -p 678 -st none -pt topic418_7_0 -u 0.0017868333292214364 > ./result_8chains/node418_7_0.txt &
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
    "./result_8chains/node418_0_0.txt 90"
    "./result_8chains/node418_0_2.txt 90"
    "./result_8chains/node418_1_0.txt 89"
    "./result_8chains/node418_1_2.txt 89"
    "./result_8chains/node418_2_0.txt 88"
    "./result_8chains/node418_2_2.txt 88"
    "./result_8chains/node418_3_0.txt 87"
    "./result_8chains/node418_3_2.txt 87"
    "./result_8chains/node418_4_0.txt 86"
    "./result_8chains/node418_4_2.txt 86"
    "./result_8chains/node418_5_0.txt 85"
    "./result_8chains/node418_5_2.txt 85"
    "./result_8chains/node418_6_0.txt 84"
    "./result_8chains/node418_6_2.txt 84"
    "./result_8chains/node418_7_0.txt 83"
    "./result_8chains/node418_7_2.txt 83"
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
