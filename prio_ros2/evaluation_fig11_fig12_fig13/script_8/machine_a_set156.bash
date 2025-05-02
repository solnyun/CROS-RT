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
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_2 -p 172 -st topic156_0_1 -pt None -u 0.025465085375047547 > ./result_8chains/node156_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_2 -p 236 -st topic156_1_1 -pt None -u 0.00743204169302164 > ./result_8chains/node156_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_2 -p 417 -st topic156_2_1 -pt None -u 0.07508176802786676 > ./result_8chains/node156_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_2 -p 499 -st topic156_3_1 -pt None -u 0.030864996483924906 > ./result_8chains/node156_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_2 -p 511 -st topic156_4_1 -pt None -u 0.004801755124274637 > ./result_8chains/node156_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_2 -p 524 -st topic156_5_1 -pt None -u 0.014760891180959995 > ./result_8chains/node156_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_6_2 -p 725 -st topic156_6_1 -pt None -u 0.014250402166159123 > ./result_8chains/node156_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_7_2 -p 734 -st topic156_7_1 -pt None -u 0.06226456981335746 > ./result_8chains/node156_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_0 -p 172 -st none -pt topic156_0_0 -u 0.011920413823737819 > ./result_8chains/node156_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_0 -p 236 -st none -pt topic156_1_0 -u 0.01759184725501567 > ./result_8chains/node156_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_0 -p 417 -st none -pt topic156_2_0 -u 0.002018668410244173 > ./result_8chains/node156_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_0 -p 499 -st none -pt topic156_3_0 -u 0.035908345249774876 > ./result_8chains/node156_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_0 -p 511 -st none -pt topic156_4_0 -u 0.006616462582059196 > ./result_8chains/node156_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_0 -p 524 -st none -pt topic156_5_0 -u 0.01952633056647199 > ./result_8chains/node156_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_6_0 -p 725 -st none -pt topic156_6_0 -u 0.04602816184506055 > ./result_8chains/node156_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_7_0 -p 734 -st none -pt topic156_7_0 -u 0.013637764237918376 > ./result_8chains/node156_7_0.txt &
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
    "./result_8chains/node156_0_0.txt 90"
    "./result_8chains/node156_0_2.txt 90"
    "./result_8chains/node156_1_0.txt 89"
    "./result_8chains/node156_1_2.txt 89"
    "./result_8chains/node156_2_0.txt 88"
    "./result_8chains/node156_2_2.txt 88"
    "./result_8chains/node156_3_0.txt 87"
    "./result_8chains/node156_3_2.txt 87"
    "./result_8chains/node156_4_0.txt 86"
    "./result_8chains/node156_4_2.txt 86"
    "./result_8chains/node156_5_0.txt 85"
    "./result_8chains/node156_5_2.txt 85"
    "./result_8chains/node156_6_0.txt 84"
    "./result_8chains/node156_6_2.txt 84"
    "./result_8chains/node156_7_0.txt 83"
    "./result_8chains/node156_7_2.txt 83"
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
