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
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_2 -p 37 -st topic118_0_1 -pt None -u 0.031998816231902594 > ./result_8chains/node118_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_2 -p 198 -st topic118_1_1 -pt None -u 0.03248902945555299 > ./result_8chains/node118_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_2 -p 298 -st topic118_2_1 -pt None -u 0.005069200810295327 > ./result_8chains/node118_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_2 -p 441 -st topic118_3_1 -pt None -u 0.013781462840354364 > ./result_8chains/node118_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_2 -p 675 -st topic118_4_1 -pt None -u 0.011953139459134593 > ./result_8chains/node118_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_2 -p 756 -st topic118_5_1 -pt None -u 0.005931774079354288 > ./result_8chains/node118_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_6_2 -p 768 -st topic118_6_1 -pt None -u 0.012402351137095119 > ./result_8chains/node118_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_7_2 -p 960 -st topic118_7_1 -pt None -u 0.013433043507866303 > ./result_8chains/node118_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_0 -p 37 -st none -pt topic118_0_0 -u 0.061139732591397156 > ./result_8chains/node118_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_0 -p 198 -st none -pt topic118_1_0 -u 0.01763085278814902 > ./result_8chains/node118_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_0 -p 298 -st none -pt topic118_2_0 -u 0.022362394254988538 > ./result_8chains/node118_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_0 -p 441 -st none -pt topic118_3_0 -u 0.0027003221988176618 > ./result_8chains/node118_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_0 -p 675 -st none -pt topic118_4_0 -u 0.03775470196648634 > ./result_8chains/node118_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_0 -p 756 -st none -pt topic118_5_0 -u 0.003503701735384654 > ./result_8chains/node118_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_6_0 -p 768 -st none -pt topic118_6_0 -u 0.016073310302728627 > ./result_8chains/node118_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_7_0 -p 960 -st none -pt topic118_7_0 -u 0.0016445368998896717 > ./result_8chains/node118_7_0.txt &
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
    "./result_8chains/node118_0_0.txt 90"
    "./result_8chains/node118_0_2.txt 90"
    "./result_8chains/node118_1_0.txt 89"
    "./result_8chains/node118_1_2.txt 89"
    "./result_8chains/node118_2_0.txt 88"
    "./result_8chains/node118_2_2.txt 88"
    "./result_8chains/node118_3_0.txt 87"
    "./result_8chains/node118_3_2.txt 87"
    "./result_8chains/node118_4_0.txt 86"
    "./result_8chains/node118_4_2.txt 86"
    "./result_8chains/node118_5_0.txt 85"
    "./result_8chains/node118_5_2.txt 85"
    "./result_8chains/node118_6_0.txt 84"
    "./result_8chains/node118_6_2.txt 84"
    "./result_8chains/node118_7_0.txt 83"
    "./result_8chains/node118_7_2.txt 83"
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
