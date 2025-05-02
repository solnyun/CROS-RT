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
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_2 -p 321 -st topic267_0_1 -pt None -u 0.0020948059781318307 > ./result_8chains/node267_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_2 -p 330 -st topic267_1_1 -pt None -u 0.006963269712998266 > ./result_8chains/node267_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_2 -p 339 -st topic267_2_1 -pt None -u 0.05608239622202843 > ./result_8chains/node267_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_2 -p 344 -st topic267_3_1 -pt None -u 0.007951611864615848 > ./result_8chains/node267_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_2 -p 784 -st topic267_4_1 -pt None -u 0.0006277916451417898 > ./result_8chains/node267_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_2 -p 851 -st topic267_5_1 -pt None -u 0.010146273593866523 > ./result_8chains/node267_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_6_2 -p 900 -st topic267_6_1 -pt None -u 0.034652920044477786 > ./result_8chains/node267_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_7_2 -p 977 -st topic267_7_1 -pt None -u 0.01954170946596151 > ./result_8chains/node267_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_0 -p 321 -st none -pt topic267_0_0 -u 0.0332697053227915 > ./result_8chains/node267_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_0 -p 330 -st none -pt topic267_1_0 -u 1.9192339275442283e-05 > ./result_8chains/node267_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_0 -p 339 -st none -pt topic267_2_0 -u 0.011603188445840185 > ./result_8chains/node267_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_0 -p 344 -st none -pt topic267_3_0 -u 0.002636854634600616 > ./result_8chains/node267_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_0 -p 784 -st none -pt topic267_4_0 -u 0.06027993107164395 > ./result_8chains/node267_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_0 -p 851 -st none -pt topic267_5_0 -u 0.01188239747371786 > ./result_8chains/node267_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_6_0 -p 900 -st none -pt topic267_6_0 -u 0.04181828576467335 > ./result_8chains/node267_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_7_0 -p 977 -st none -pt topic267_7_0 -u 0.05195573014794339 > ./result_8chains/node267_7_0.txt &
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
    "./result_8chains/node267_0_0.txt 90"
    "./result_8chains/node267_0_2.txt 90"
    "./result_8chains/node267_1_0.txt 89"
    "./result_8chains/node267_1_2.txt 89"
    "./result_8chains/node267_2_0.txt 88"
    "./result_8chains/node267_2_2.txt 88"
    "./result_8chains/node267_3_0.txt 87"
    "./result_8chains/node267_3_2.txt 87"
    "./result_8chains/node267_4_0.txt 86"
    "./result_8chains/node267_4_2.txt 86"
    "./result_8chains/node267_5_0.txt 85"
    "./result_8chains/node267_5_2.txt 85"
    "./result_8chains/node267_6_0.txt 84"
    "./result_8chains/node267_6_2.txt 84"
    "./result_8chains/node267_7_0.txt 83"
    "./result_8chains/node267_7_2.txt 83"
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
