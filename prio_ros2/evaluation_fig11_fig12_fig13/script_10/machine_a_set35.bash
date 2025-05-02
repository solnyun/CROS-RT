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
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_2 -p 34 -st topic35_0_1 -pt None -u 0.04029516927696414 > ./result_10chains/node35_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_2 -p 43 -st topic35_1_1 -pt None -u 0.024563371629226893 > ./result_10chains/node35_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_2 -p 203 -st topic35_2_1 -pt None -u 0.0004986305709716032 > ./result_10chains/node35_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_2 -p 234 -st topic35_3_1 -pt None -u 0.02619396689358222 > ./result_10chains/node35_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_2 -p 301 -st topic35_4_1 -pt None -u 0.01923955241879266 > ./result_10chains/node35_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_2 -p 372 -st topic35_5_1 -pt None -u 0.008396690930053519 > ./result_10chains/node35_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_6_2 -p 514 -st topic35_6_1 -pt None -u 0.0028938186263508248 > ./result_10chains/node35_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_7_2 -p 582 -st topic35_7_1 -pt None -u 0.003545743155212791 > ./result_10chains/node35_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_8_2 -p 855 -st topic35_8_1 -pt None -u 0.0042025774723395415 > ./result_10chains/node35_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_9_2 -p 942 -st topic35_9_1 -pt None -u 0.01927093250966422 > ./result_10chains/node35_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_0_0 -p 34 -st none -pt topic35_0_0 -u 0.009805458161362524 > ./result_10chains/node35_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_1_0 -p 43 -st none -pt topic35_1_0 -u 0.010940878705690493 > ./result_10chains/node35_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_2_0 -p 203 -st none -pt topic35_2_0 -u 0.0032295961055103795 > ./result_10chains/node35_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_3_0 -p 234 -st none -pt topic35_3_0 -u 0.00048484664326392535 > ./result_10chains/node35_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_4_0 -p 301 -st none -pt topic35_4_0 -u 0.04916304556689405 > ./result_10chains/node35_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_5_0 -p 372 -st none -pt topic35_5_0 -u 0.001023244855354155 > ./result_10chains/node35_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_6_0 -p 514 -st none -pt topic35_6_0 -u 0.08723632001791884 > ./result_10chains/node35_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_7_0 -p 582 -st none -pt topic35_7_0 -u 0.01324063533724136 > ./result_10chains/node35_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node35_8_0 -p 855 -st none -pt topic35_8_0 -u 0.03160752127239308 > ./result_10chains/node35_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node35_9_0 -p 942 -st none -pt topic35_9_0 -u 0.045346566430357844 > ./result_10chains/node35_9_0.txt &
sleep 10
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
    "./result_10chains/node35_0_0.txt 90"
    "./result_10chains/node35_0_2.txt 90"
    "./result_10chains/node35_1_0.txt 89"
    "./result_10chains/node35_1_2.txt 89"
    "./result_10chains/node35_2_0.txt 88"
    "./result_10chains/node35_2_2.txt 88"
    "./result_10chains/node35_3_0.txt 87"
    "./result_10chains/node35_3_2.txt 87"
    "./result_10chains/node35_4_0.txt 86"
    "./result_10chains/node35_4_2.txt 86"
    "./result_10chains/node35_5_0.txt 85"
    "./result_10chains/node35_5_2.txt 85"
    "./result_10chains/node35_6_0.txt 84"
    "./result_10chains/node35_6_2.txt 84"
    "./result_10chains/node35_7_0.txt 83"
    "./result_10chains/node35_7_2.txt 83"
    "./result_10chains/node35_8_0.txt 82"
    "./result_10chains/node35_8_2.txt 82"
    "./result_10chains/node35_9_0.txt 81"
    "./result_10chains/node35_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
