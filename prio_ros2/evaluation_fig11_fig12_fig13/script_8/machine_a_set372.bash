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
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_2 -p 123 -st topic372_0_1 -pt None -u 0.029077537166892597 > ./result_8chains/node372_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_2 -p 337 -st topic372_1_1 -pt None -u 0.001366214565570234 > ./result_8chains/node372_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_2 -p 346 -st topic372_2_1 -pt None -u 0.021597265960622503 > ./result_8chains/node372_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_2 -p 438 -st topic372_3_1 -pt None -u 0.011704542065201218 > ./result_8chains/node372_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_2 -p 674 -st topic372_4_1 -pt None -u 0.00994822959059341 > ./result_8chains/node372_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_2 -p 788 -st topic372_5_1 -pt None -u 0.005912304148488728 > ./result_8chains/node372_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_6_2 -p 884 -st topic372_6_1 -pt None -u 0.010182966051724245 > ./result_8chains/node372_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_7_2 -p 943 -st topic372_7_1 -pt None -u 0.0002241162701857629 > ./result_8chains/node372_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_0_0 -p 123 -st none -pt topic372_0_0 -u 0.09255238093922469 > ./result_8chains/node372_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_1_0 -p 337 -st none -pt topic372_1_0 -u 0.020237536887249608 > ./result_8chains/node372_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_2_0 -p 346 -st none -pt topic372_2_0 -u 0.013459284099897995 > ./result_8chains/node372_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_3_0 -p 438 -st none -pt topic372_3_0 -u 0.014252191584328056 > ./result_8chains/node372_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_4_0 -p 674 -st none -pt topic372_4_0 -u 0.010196564216363224 > ./result_8chains/node372_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_5_0 -p 788 -st none -pt topic372_5_0 -u 0.023503097056444044 > ./result_8chains/node372_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node372_6_0 -p 884 -st none -pt topic372_6_0 -u 0.023737747305815057 > ./result_8chains/node372_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node372_7_0 -p 943 -st none -pt topic372_7_0 -u 0.03439915139406595 > ./result_8chains/node372_7_0.txt &
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
    "./result_8chains/node372_0_0.txt 90"
    "./result_8chains/node372_0_2.txt 90"
    "./result_8chains/node372_1_0.txt 89"
    "./result_8chains/node372_1_2.txt 89"
    "./result_8chains/node372_2_0.txt 88"
    "./result_8chains/node372_2_2.txt 88"
    "./result_8chains/node372_3_0.txt 87"
    "./result_8chains/node372_3_2.txt 87"
    "./result_8chains/node372_4_0.txt 86"
    "./result_8chains/node372_4_2.txt 86"
    "./result_8chains/node372_5_0.txt 85"
    "./result_8chains/node372_5_2.txt 85"
    "./result_8chains/node372_6_0.txt 84"
    "./result_8chains/node372_6_2.txt 84"
    "./result_8chains/node372_7_0.txt 83"
    "./result_8chains/node372_7_2.txt 83"
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
