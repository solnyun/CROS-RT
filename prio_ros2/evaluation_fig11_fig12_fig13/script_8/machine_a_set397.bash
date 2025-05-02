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
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_2 -p 82 -st topic397_0_1 -pt None -u 0.0014881438412969183 > ./result_8chains/node397_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_2 -p 215 -st topic397_1_1 -pt None -u 0.026360105265627376 > ./result_8chains/node397_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_2 -p 378 -st topic397_2_1 -pt None -u 0.009906316393902936 > ./result_8chains/node397_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_2 -p 571 -st topic397_3_1 -pt None -u 0.012297294482979892 > ./result_8chains/node397_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_2 -p 689 -st topic397_4_1 -pt None -u 0.02050427570180771 > ./result_8chains/node397_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_2 -p 840 -st topic397_5_1 -pt None -u 0.0348022771103363 > ./result_8chains/node397_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_6_2 -p 895 -st topic397_6_1 -pt None -u 0.003093609756076504 > ./result_8chains/node397_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_7_2 -p 923 -st topic397_7_1 -pt None -u 0.029487577752086887 > ./result_8chains/node397_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_0 -p 82 -st none -pt topic397_0_0 -u 0.05069099024292767 > ./result_8chains/node397_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_0 -p 215 -st none -pt topic397_1_0 -u 0.007541844745526938 > ./result_8chains/node397_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_0 -p 378 -st none -pt topic397_2_0 -u 0.036875131352213375 > ./result_8chains/node397_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_0 -p 571 -st none -pt topic397_3_0 -u 0.012487304547719957 > ./result_8chains/node397_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_0 -p 689 -st none -pt topic397_4_0 -u 0.05427001976120677 > ./result_8chains/node397_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_0 -p 840 -st none -pt topic397_5_0 -u 0.03170650524004395 > ./result_8chains/node397_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_6_0 -p 895 -st none -pt topic397_6_0 -u 0.015686648512162338 > ./result_8chains/node397_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_7_0 -p 923 -st none -pt topic397_7_0 -u 0.018005559985305987 > ./result_8chains/node397_7_0.txt &
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
    "./result_8chains/node397_0_0.txt 90"
    "./result_8chains/node397_0_2.txt 90"
    "./result_8chains/node397_1_0.txt 89"
    "./result_8chains/node397_1_2.txt 89"
    "./result_8chains/node397_2_0.txt 88"
    "./result_8chains/node397_2_2.txt 88"
    "./result_8chains/node397_3_0.txt 87"
    "./result_8chains/node397_3_2.txt 87"
    "./result_8chains/node397_4_0.txt 86"
    "./result_8chains/node397_4_2.txt 86"
    "./result_8chains/node397_5_0.txt 85"
    "./result_8chains/node397_5_2.txt 85"
    "./result_8chains/node397_6_0.txt 84"
    "./result_8chains/node397_6_2.txt 84"
    "./result_8chains/node397_7_0.txt 83"
    "./result_8chains/node397_7_2.txt 83"
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
