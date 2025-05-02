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
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_2 -p 300 -st topic17_0_1 -pt None -u 0.007265563427853117 > ./result_8chains/node17_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_2 -p 351 -st topic17_1_1 -pt None -u 0.013408732441829274 > ./result_8chains/node17_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_2 -p 480 -st topic17_2_1 -pt None -u 0.03367910893702797 > ./result_8chains/node17_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_2 -p 579 -st topic17_3_1 -pt None -u 0.0415361326205172 > ./result_8chains/node17_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_2 -p 616 -st topic17_4_1 -pt None -u 0.005859646260460094 > ./result_8chains/node17_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_2 -p 651 -st topic17_5_1 -pt None -u 0.031600948795325504 > ./result_8chains/node17_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_6_2 -p 948 -st topic17_6_1 -pt None -u 0.008017963335964655 > ./result_8chains/node17_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_7_2 -p 950 -st topic17_7_1 -pt None -u 0.0045760700174256 > ./result_8chains/node17_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_0 -p 300 -st none -pt topic17_0_0 -u 0.03339903346326928 > ./result_8chains/node17_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_0 -p 351 -st none -pt topic17_1_0 -u 0.014370440202966461 > ./result_8chains/node17_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_0 -p 480 -st none -pt topic17_2_0 -u 0.01981901448396406 > ./result_8chains/node17_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_0 -p 579 -st none -pt topic17_3_0 -u 0.06925177162593388 > ./result_8chains/node17_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_0 -p 616 -st none -pt topic17_4_0 -u 0.0011563431772483312 > ./result_8chains/node17_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_0 -p 651 -st none -pt topic17_5_0 -u 0.0074202792109708815 > ./result_8chains/node17_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node17_6_0 -p 948 -st none -pt topic17_6_0 -u 0.032092662054114554 > ./result_8chains/node17_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node17_7_0 -p 950 -st none -pt topic17_7_0 -u 0.01837588067323124 > ./result_8chains/node17_7_0.txt &
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
    "./result_8chains/node17_0_0.txt 90"
    "./result_8chains/node17_0_2.txt 90"
    "./result_8chains/node17_1_0.txt 89"
    "./result_8chains/node17_1_2.txt 89"
    "./result_8chains/node17_2_0.txt 88"
    "./result_8chains/node17_2_2.txt 88"
    "./result_8chains/node17_3_0.txt 87"
    "./result_8chains/node17_3_2.txt 87"
    "./result_8chains/node17_4_0.txt 86"
    "./result_8chains/node17_4_2.txt 86"
    "./result_8chains/node17_5_0.txt 85"
    "./result_8chains/node17_5_2.txt 85"
    "./result_8chains/node17_6_0.txt 84"
    "./result_8chains/node17_6_2.txt 84"
    "./result_8chains/node17_7_0.txt 83"
    "./result_8chains/node17_7_2.txt 83"
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
