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
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_2 -p 172 -st topic280_0_1 -pt None -u 0.07097427719770949 > ./result_8chains/node280_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_2 -p 250 -st topic280_1_1 -pt None -u 0.004583396086199676 > ./result_8chains/node280_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_2 -p 321 -st topic280_2_1 -pt None -u 0.023323370464224863 > ./result_8chains/node280_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_2 -p 640 -st topic280_3_1 -pt None -u 0.005380370509431576 > ./result_8chains/node280_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_2 -p 724 -st topic280_4_1 -pt None -u 0.007906801622999518 > ./result_8chains/node280_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_2 -p 786 -st topic280_5_1 -pt None -u 0.001071671728029383 > ./result_8chains/node280_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_6_2 -p 950 -st topic280_6_1 -pt None -u 0.0069535512666759995 > ./result_8chains/node280_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_7_2 -p 972 -st topic280_7_1 -pt None -u 0.006421393309875492 > ./result_8chains/node280_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_0_0 -p 172 -st none -pt topic280_0_0 -u 0.03973159747543903 > ./result_8chains/node280_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_1_0 -p 250 -st none -pt topic280_1_0 -u 0.027960336380554285 > ./result_8chains/node280_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_2_0 -p 321 -st none -pt topic280_2_0 -u 0.0016756753383858625 > ./result_8chains/node280_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_3_0 -p 640 -st none -pt topic280_3_0 -u 0.021283744234865037 > ./result_8chains/node280_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_4_0 -p 724 -st none -pt topic280_4_0 -u 0.040428351558702585 > ./result_8chains/node280_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_5_0 -p 786 -st none -pt topic280_5_0 -u 0.004829246484391689 > ./result_8chains/node280_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node280_6_0 -p 950 -st none -pt topic280_6_0 -u 0.003545452838776317 > ./result_8chains/node280_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node280_7_0 -p 972 -st none -pt topic280_7_0 -u 0.005030717881491967 > ./result_8chains/node280_7_0.txt &
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
    "./result_8chains/node280_0_0.txt 90"
    "./result_8chains/node280_0_2.txt 90"
    "./result_8chains/node280_1_0.txt 89"
    "./result_8chains/node280_1_2.txt 89"
    "./result_8chains/node280_2_0.txt 88"
    "./result_8chains/node280_2_2.txt 88"
    "./result_8chains/node280_3_0.txt 87"
    "./result_8chains/node280_3_2.txt 87"
    "./result_8chains/node280_4_0.txt 86"
    "./result_8chains/node280_4_2.txt 86"
    "./result_8chains/node280_5_0.txt 85"
    "./result_8chains/node280_5_2.txt 85"
    "./result_8chains/node280_6_0.txt 84"
    "./result_8chains/node280_6_2.txt 84"
    "./result_8chains/node280_7_0.txt 83"
    "./result_8chains/node280_7_2.txt 83"
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
