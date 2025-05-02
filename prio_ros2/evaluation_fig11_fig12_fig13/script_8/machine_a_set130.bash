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
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_2 -p 30 -st topic130_0_1 -pt None -u 0.041404169312597994 > ./result_8chains/node130_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_2 -p 209 -st topic130_1_1 -pt None -u 0.0008307449809790146 > ./result_8chains/node130_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_2 -p 463 -st topic130_2_1 -pt None -u 0.028628150338487535 > ./result_8chains/node130_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_2 -p 529 -st topic130_3_1 -pt None -u 0.01568538569437511 > ./result_8chains/node130_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_2 -p 737 -st topic130_4_1 -pt None -u 0.07743916046365043 > ./result_8chains/node130_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_2 -p 766 -st topic130_5_1 -pt None -u 0.005540153996447611 > ./result_8chains/node130_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_6_2 -p 802 -st topic130_6_1 -pt None -u 0.030992986002554804 > ./result_8chains/node130_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_7_2 -p 973 -st topic130_7_1 -pt None -u 0.03572632357506758 > ./result_8chains/node130_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_0 -p 30 -st none -pt topic130_0_0 -u 0.007817801506051214 > ./result_8chains/node130_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_0 -p 209 -st none -pt topic130_1_0 -u 0.05217324292619013 > ./result_8chains/node130_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_0 -p 463 -st none -pt topic130_2_0 -u 0.00850040263491847 > ./result_8chains/node130_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_0 -p 529 -st none -pt topic130_3_0 -u 0.006828326271605845 > ./result_8chains/node130_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_0 -p 737 -st none -pt topic130_4_0 -u 0.01311431608630026 > ./result_8chains/node130_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_0 -p 766 -st none -pt topic130_5_0 -u 0.02542732231039066 > ./result_8chains/node130_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_6_0 -p 802 -st none -pt topic130_6_0 -u 0.04117941125968627 > ./result_8chains/node130_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_7_0 -p 973 -st none -pt topic130_7_0 -u 0.011236718083304467 > ./result_8chains/node130_7_0.txt &
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
    "./result_8chains/node130_0_0.txt 90"
    "./result_8chains/node130_0_2.txt 90"
    "./result_8chains/node130_1_0.txt 89"
    "./result_8chains/node130_1_2.txt 89"
    "./result_8chains/node130_2_0.txt 88"
    "./result_8chains/node130_2_2.txt 88"
    "./result_8chains/node130_3_0.txt 87"
    "./result_8chains/node130_3_2.txt 87"
    "./result_8chains/node130_4_0.txt 86"
    "./result_8chains/node130_4_2.txt 86"
    "./result_8chains/node130_5_0.txt 85"
    "./result_8chains/node130_5_2.txt 85"
    "./result_8chains/node130_6_0.txt 84"
    "./result_8chains/node130_6_2.txt 84"
    "./result_8chains/node130_7_0.txt 83"
    "./result_8chains/node130_7_2.txt 83"
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
