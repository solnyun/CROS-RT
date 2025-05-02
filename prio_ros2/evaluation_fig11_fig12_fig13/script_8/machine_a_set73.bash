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
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_2 -p 152 -st topic73_0_1 -pt None -u 0.008842629496103038 > ./result_8chains/node73_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_2 -p 181 -st topic73_1_1 -pt None -u 0.023400907466356757 > ./result_8chains/node73_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_2 -p 223 -st topic73_2_1 -pt None -u 0.01949813536668263 > ./result_8chains/node73_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_2 -p 536 -st topic73_3_1 -pt None -u 0.010605418477475204 > ./result_8chains/node73_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_2 -p 826 -st topic73_4_1 -pt None -u 0.013607527052441698 > ./result_8chains/node73_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_2 -p 850 -st topic73_5_1 -pt None -u 0.00640128749719536 > ./result_8chains/node73_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_6_2 -p 885 -st topic73_6_1 -pt None -u 0.012251827066799753 > ./result_8chains/node73_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_7_2 -p 972 -st topic73_7_1 -pt None -u 0.07049594897710484 > ./result_8chains/node73_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_0_0 -p 152 -st none -pt topic73_0_0 -u 0.009261194669375361 > ./result_8chains/node73_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_1_0 -p 181 -st none -pt topic73_1_0 -u 0.12159061273696042 > ./result_8chains/node73_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_2_0 -p 223 -st none -pt topic73_2_0 -u 0.005703386789760567 > ./result_8chains/node73_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_3_0 -p 536 -st none -pt topic73_3_0 -u 0.0014590771490672616 > ./result_8chains/node73_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_4_0 -p 826 -st none -pt topic73_4_0 -u 0.03883876992949262 > ./result_8chains/node73_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_5_0 -p 850 -st none -pt topic73_5_0 -u 0.03486060406438865 > ./result_8chains/node73_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node73_6_0 -p 885 -st none -pt topic73_6_0 -u 0.002283787825456962 > ./result_8chains/node73_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node73_7_0 -p 972 -st none -pt topic73_7_0 -u 0.00035842887364956333 > ./result_8chains/node73_7_0.txt &
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
    "./result_8chains/node73_0_0.txt 90"
    "./result_8chains/node73_0_2.txt 90"
    "./result_8chains/node73_1_0.txt 89"
    "./result_8chains/node73_1_2.txt 89"
    "./result_8chains/node73_2_0.txt 88"
    "./result_8chains/node73_2_2.txt 88"
    "./result_8chains/node73_3_0.txt 87"
    "./result_8chains/node73_3_2.txt 87"
    "./result_8chains/node73_4_0.txt 86"
    "./result_8chains/node73_4_2.txt 86"
    "./result_8chains/node73_5_0.txt 85"
    "./result_8chains/node73_5_2.txt 85"
    "./result_8chains/node73_6_0.txt 84"
    "./result_8chains/node73_6_2.txt 84"
    "./result_8chains/node73_7_0.txt 83"
    "./result_8chains/node73_7_2.txt 83"
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
