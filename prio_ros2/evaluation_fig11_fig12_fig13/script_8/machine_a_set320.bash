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
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_2 -p 99 -st topic320_0_1 -pt None -u 0.01717839913045527 > ./result_8chains/node320_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_2 -p 389 -st topic320_1_1 -pt None -u 0.004673224446671731 > ./result_8chains/node320_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_2 -p 649 -st topic320_2_1 -pt None -u 0.003692692750687565 > ./result_8chains/node320_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_2 -p 873 -st topic320_3_1 -pt None -u 0.029291691310434326 > ./result_8chains/node320_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_2 -p 908 -st topic320_4_1 -pt None -u 0.03300994347051325 > ./result_8chains/node320_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_2 -p 910 -st topic320_5_1 -pt None -u 0.001056250541913828 > ./result_8chains/node320_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_6_2 -p 969 -st topic320_6_1 -pt None -u 0.03302627454859713 > ./result_8chains/node320_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_7_2 -p 990 -st topic320_7_1 -pt None -u 0.004266145364999567 > ./result_8chains/node320_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_0 -p 99 -st none -pt topic320_0_0 -u 0.005888300492607856 > ./result_8chains/node320_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_0 -p 389 -st none -pt topic320_1_0 -u 0.0021893102211787974 > ./result_8chains/node320_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_0 -p 649 -st none -pt topic320_2_0 -u 0.0008067356567534323 > ./result_8chains/node320_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_0 -p 873 -st none -pt topic320_3_0 -u 0.011713415070326694 > ./result_8chains/node320_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_0 -p 908 -st none -pt topic320_4_0 -u 0.0051529081106436725 > ./result_8chains/node320_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_0 -p 910 -st none -pt topic320_5_0 -u 0.0018360867265255765 > ./result_8chains/node320_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_6_0 -p 969 -st none -pt topic320_6_0 -u 0.00956244207892537 > ./result_8chains/node320_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_7_0 -p 990 -st none -pt topic320_7_0 -u 0.013944608086235856 > ./result_8chains/node320_7_0.txt &
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
    "./result_8chains/node320_0_0.txt 90"
    "./result_8chains/node320_0_2.txt 90"
    "./result_8chains/node320_1_0.txt 89"
    "./result_8chains/node320_1_2.txt 89"
    "./result_8chains/node320_2_0.txt 88"
    "./result_8chains/node320_2_2.txt 88"
    "./result_8chains/node320_3_0.txt 87"
    "./result_8chains/node320_3_2.txt 87"
    "./result_8chains/node320_4_0.txt 86"
    "./result_8chains/node320_4_2.txt 86"
    "./result_8chains/node320_5_0.txt 85"
    "./result_8chains/node320_5_2.txt 85"
    "./result_8chains/node320_6_0.txt 84"
    "./result_8chains/node320_6_2.txt 84"
    "./result_8chains/node320_7_0.txt 83"
    "./result_8chains/node320_7_2.txt 83"
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
