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
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_2 -p 101 -st topic143_0_1 -pt None -u 0.02463535194035954 > ./result_8chains/node143_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_2 -p 251 -st topic143_1_1 -pt None -u 0.026895745300810625 > ./result_8chains/node143_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_2 -p 280 -st topic143_2_1 -pt None -u 0.024004038670607464 > ./result_8chains/node143_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_2 -p 323 -st topic143_3_1 -pt None -u 0.01032255334986018 > ./result_8chains/node143_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_2 -p 651 -st topic143_4_1 -pt None -u 0.008550967998316061 > ./result_8chains/node143_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_2 -p 869 -st topic143_5_1 -pt None -u 0.017742018993753994 > ./result_8chains/node143_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_6_2 -p 884 -st topic143_6_1 -pt None -u 0.00374590172951772 > ./result_8chains/node143_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_7_2 -p 994 -st topic143_7_1 -pt None -u 0.00029902020216625714 > ./result_8chains/node143_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_0 -p 101 -st none -pt topic143_0_0 -u 0.014439292907484358 > ./result_8chains/node143_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_0 -p 251 -st none -pt topic143_1_0 -u 0.07928969176955142 > ./result_8chains/node143_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_0 -p 280 -st none -pt topic143_2_0 -u 0.03041478067017389 > ./result_8chains/node143_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_0 -p 323 -st none -pt topic143_3_0 -u 0.01180514061994059 > ./result_8chains/node143_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_0 -p 651 -st none -pt topic143_4_0 -u 0.012589416053659958 > ./result_8chains/node143_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_0 -p 869 -st none -pt topic143_5_0 -u 0.005173414160655587 > ./result_8chains/node143_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_6_0 -p 884 -st none -pt topic143_6_0 -u 0.0011245037797755764 > ./result_8chains/node143_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_7_0 -p 994 -st none -pt topic143_7_0 -u 0.03474563798166326 > ./result_8chains/node143_7_0.txt &
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
    "./result_8chains/node143_0_0.txt 90"
    "./result_8chains/node143_0_2.txt 90"
    "./result_8chains/node143_1_0.txt 89"
    "./result_8chains/node143_1_2.txt 89"
    "./result_8chains/node143_2_0.txt 88"
    "./result_8chains/node143_2_2.txt 88"
    "./result_8chains/node143_3_0.txt 87"
    "./result_8chains/node143_3_2.txt 87"
    "./result_8chains/node143_4_0.txt 86"
    "./result_8chains/node143_4_2.txt 86"
    "./result_8chains/node143_5_0.txt 85"
    "./result_8chains/node143_5_2.txt 85"
    "./result_8chains/node143_6_0.txt 84"
    "./result_8chains/node143_6_2.txt 84"
    "./result_8chains/node143_7_0.txt 83"
    "./result_8chains/node143_7_2.txt 83"
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
