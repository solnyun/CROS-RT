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
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_2 -p 200 -st topic5_0_1 -pt None -u 0.019756331269753402 > ./result_8chains/node5_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_2 -p 255 -st topic5_1_1 -pt None -u 0.0016436417849934326 > ./result_8chains/node5_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_2 -p 270 -st topic5_2_1 -pt None -u 1.770309671944581e-05 > ./result_8chains/node5_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_2 -p 288 -st topic5_3_1 -pt None -u 0.03098557007333863 > ./result_8chains/node5_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_2 -p 491 -st topic5_4_1 -pt None -u 0.006669772652389799 > ./result_8chains/node5_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_2 -p 640 -st topic5_5_1 -pt None -u 0.04949659236026788 > ./result_8chains/node5_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_6_2 -p 819 -st topic5_6_1 -pt None -u 0.006966614188741463 > ./result_8chains/node5_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_7_2 -p 866 -st topic5_7_1 -pt None -u 0.0038091005346601076 > ./result_8chains/node5_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_0 -p 200 -st none -pt topic5_0_0 -u 0.013206571334031358 > ./result_8chains/node5_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_0 -p 255 -st none -pt topic5_1_0 -u 0.06548425299031424 > ./result_8chains/node5_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_0 -p 270 -st none -pt topic5_2_0 -u 0.022804999882600374 > ./result_8chains/node5_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_0 -p 288 -st none -pt topic5_3_0 -u 0.01779516554231142 > ./result_8chains/node5_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_0 -p 491 -st none -pt topic5_4_0 -u 0.004044301333660627 > ./result_8chains/node5_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_0 -p 640 -st none -pt topic5_5_0 -u 0.037755908148838696 > ./result_8chains/node5_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_6_0 -p 819 -st none -pt topic5_6_0 -u 0.0024118090377057144 > ./result_8chains/node5_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_7_0 -p 866 -st none -pt topic5_7_0 -u 0.02311673513880694 > ./result_8chains/node5_7_0.txt &
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
    "./result_8chains/node5_0_0.txt 90"
    "./result_8chains/node5_0_2.txt 90"
    "./result_8chains/node5_1_0.txt 89"
    "./result_8chains/node5_1_2.txt 89"
    "./result_8chains/node5_2_0.txt 88"
    "./result_8chains/node5_2_2.txt 88"
    "./result_8chains/node5_3_0.txt 87"
    "./result_8chains/node5_3_2.txt 87"
    "./result_8chains/node5_4_0.txt 86"
    "./result_8chains/node5_4_2.txt 86"
    "./result_8chains/node5_5_0.txt 85"
    "./result_8chains/node5_5_2.txt 85"
    "./result_8chains/node5_6_0.txt 84"
    "./result_8chains/node5_6_2.txt 84"
    "./result_8chains/node5_7_0.txt 83"
    "./result_8chains/node5_7_2.txt 83"
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
