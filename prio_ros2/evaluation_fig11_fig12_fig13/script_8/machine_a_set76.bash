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
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_2 -p 288 -st topic76_0_1 -pt None -u 0.003657180786015124 > ./result_8chains/node76_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_2 -p 436 -st topic76_1_1 -pt None -u 0.014355824759732072 > ./result_8chains/node76_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_2 -p 482 -st topic76_2_1 -pt None -u 0.015358338895872126 > ./result_8chains/node76_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_2 -p 698 -st topic76_3_1 -pt None -u 0.05966499761105215 > ./result_8chains/node76_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_2 -p 709 -st topic76_4_1 -pt None -u 0.009880531715093094 > ./result_8chains/node76_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_2 -p 780 -st topic76_5_1 -pt None -u 0.008907583304726421 > ./result_8chains/node76_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_6_2 -p 943 -st topic76_6_1 -pt None -u 0.03663690925492713 > ./result_8chains/node76_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_7_2 -p 961 -st topic76_7_1 -pt None -u 0.004280133233338211 > ./result_8chains/node76_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_0_0 -p 288 -st none -pt topic76_0_0 -u 0.0010368335370815607 > ./result_8chains/node76_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_1_0 -p 436 -st none -pt topic76_1_0 -u 0.03353528604310879 > ./result_8chains/node76_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_2_0 -p 482 -st none -pt topic76_2_0 -u 0.0011663381506163417 > ./result_8chains/node76_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_3_0 -p 698 -st none -pt topic76_3_0 -u 0.08124632322349995 > ./result_8chains/node76_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_4_0 -p 709 -st none -pt topic76_4_0 -u 0.03173824340812134 > ./result_8chains/node76_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_5_0 -p 780 -st none -pt topic76_5_0 -u 0.002842687840869662 > ./result_8chains/node76_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node76_6_0 -p 943 -st none -pt topic76_6_0 -u 0.02408137545993813 > ./result_8chains/node76_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node76_7_0 -p 961 -st none -pt topic76_7_0 -u 0.038922284605143284 > ./result_8chains/node76_7_0.txt &
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
    "./result_8chains/node76_0_0.txt 90"
    "./result_8chains/node76_0_2.txt 90"
    "./result_8chains/node76_1_0.txt 89"
    "./result_8chains/node76_1_2.txt 89"
    "./result_8chains/node76_2_0.txt 88"
    "./result_8chains/node76_2_2.txt 88"
    "./result_8chains/node76_3_0.txt 87"
    "./result_8chains/node76_3_2.txt 87"
    "./result_8chains/node76_4_0.txt 86"
    "./result_8chains/node76_4_2.txt 86"
    "./result_8chains/node76_5_0.txt 85"
    "./result_8chains/node76_5_2.txt 85"
    "./result_8chains/node76_6_0.txt 84"
    "./result_8chains/node76_6_2.txt 84"
    "./result_8chains/node76_7_0.txt 83"
    "./result_8chains/node76_7_2.txt 83"
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
