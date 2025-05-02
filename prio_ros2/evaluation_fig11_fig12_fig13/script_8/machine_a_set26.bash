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
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_2 -p 116 -st topic26_0_1 -pt None -u 0.006077034242303658 > ./result_8chains/node26_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_2 -p 404 -st topic26_1_1 -pt None -u 0.08404431529184897 > ./result_8chains/node26_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_2 -p 524 -st topic26_2_1 -pt None -u 0.008414432618358392 > ./result_8chains/node26_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_2 -p 642 -st topic26_3_1 -pt None -u 0.01786913645397875 > ./result_8chains/node26_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_2 -p 786 -st topic26_4_1 -pt None -u 0.009830979967065306 > ./result_8chains/node26_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_2 -p 844 -st topic26_5_1 -pt None -u 0.0009117433526177054 > ./result_8chains/node26_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_6_2 -p 937 -st topic26_6_1 -pt None -u 0.014709670154456886 > ./result_8chains/node26_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_7_2 -p 944 -st topic26_7_1 -pt None -u 0.06409621114986334 > ./result_8chains/node26_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_0_0 -p 116 -st none -pt topic26_0_0 -u 0.0017787930958618747 > ./result_8chains/node26_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_1_0 -p 404 -st none -pt topic26_1_0 -u 0.005253275222462661 > ./result_8chains/node26_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_2_0 -p 524 -st none -pt topic26_2_0 -u 0.013355714994958634 > ./result_8chains/node26_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_3_0 -p 642 -st none -pt topic26_3_0 -u 0.012420845664761426 > ./result_8chains/node26_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_4_0 -p 786 -st none -pt topic26_4_0 -u 0.04397037252083469 > ./result_8chains/node26_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_5_0 -p 844 -st none -pt topic26_5_0 -u 0.013889296751339264 > ./result_8chains/node26_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node26_6_0 -p 937 -st none -pt topic26_6_0 -u 0.034969692941095656 > ./result_8chains/node26_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node26_7_0 -p 944 -st none -pt topic26_7_0 -u 0.007728225882325884 > ./result_8chains/node26_7_0.txt &
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
    "./result_8chains/node26_0_0.txt 90"
    "./result_8chains/node26_0_2.txt 90"
    "./result_8chains/node26_1_0.txt 89"
    "./result_8chains/node26_1_2.txt 89"
    "./result_8chains/node26_2_0.txt 88"
    "./result_8chains/node26_2_2.txt 88"
    "./result_8chains/node26_3_0.txt 87"
    "./result_8chains/node26_3_2.txt 87"
    "./result_8chains/node26_4_0.txt 86"
    "./result_8chains/node26_4_2.txt 86"
    "./result_8chains/node26_5_0.txt 85"
    "./result_8chains/node26_5_2.txt 85"
    "./result_8chains/node26_6_0.txt 84"
    "./result_8chains/node26_6_2.txt 84"
    "./result_8chains/node26_7_0.txt 83"
    "./result_8chains/node26_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
