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
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_2 -p 16 -st topic389_0_1 -pt None -u 0.0240912148614173 > ./result_10chains/node389_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_2 -p 60 -st topic389_1_1 -pt None -u 0.016324296575284725 > ./result_10chains/node389_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_2 -p 209 -st topic389_2_1 -pt None -u 0.003222127003386699 > ./result_10chains/node389_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_2 -p 411 -st topic389_3_1 -pt None -u 0.02101682073431549 > ./result_10chains/node389_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_2 -p 508 -st topic389_4_1 -pt None -u 0.08188104039993224 > ./result_10chains/node389_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_2 -p 533 -st topic389_5_1 -pt None -u 0.0030857336103353727 > ./result_10chains/node389_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_6_2 -p 727 -st topic389_6_1 -pt None -u 0.030651211043159488 > ./result_10chains/node389_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_7_2 -p 738 -st topic389_7_1 -pt None -u 0.006274801482789888 > ./result_10chains/node389_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_8_2 -p 809 -st topic389_8_1 -pt None -u 0.02116064055249929 > ./result_10chains/node389_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_9_2 -p 923 -st topic389_9_1 -pt None -u 0.06111029367309688 > ./result_10chains/node389_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_0 -p 16 -st none -pt topic389_0_0 -u 0.006137766717072668 > ./result_10chains/node389_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_0 -p 60 -st none -pt topic389_1_0 -u 0.01937464155140961 > ./result_10chains/node389_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_0 -p 209 -st none -pt topic389_2_0 -u 0.003610783333255152 > ./result_10chains/node389_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_0 -p 411 -st none -pt topic389_3_0 -u 0.026018225604409084 > ./result_10chains/node389_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_0 -p 508 -st none -pt topic389_4_0 -u 0.015803498307189134 > ./result_10chains/node389_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_0 -p 533 -st none -pt topic389_5_0 -u 0.01736354733709633 > ./result_10chains/node389_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_6_0 -p 727 -st none -pt topic389_6_0 -u 0.002305353035200186 > ./result_10chains/node389_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_7_0 -p 738 -st none -pt topic389_7_0 -u 0.008333172696620234 > ./result_10chains/node389_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_8_0 -p 809 -st none -pt topic389_8_0 -u 0.02666961913865591 > ./result_10chains/node389_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_9_0 -p 923 -st none -pt topic389_9_0 -u 0.009846944699965554 > ./result_10chains/node389_9_0.txt &
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
    "./result_10chains/node389_0_0.txt 90"
    "./result_10chains/node389_0_2.txt 90"
    "./result_10chains/node389_1_0.txt 89"
    "./result_10chains/node389_1_2.txt 89"
    "./result_10chains/node389_2_0.txt 88"
    "./result_10chains/node389_2_2.txt 88"
    "./result_10chains/node389_3_0.txt 87"
    "./result_10chains/node389_3_2.txt 87"
    "./result_10chains/node389_4_0.txt 86"
    "./result_10chains/node389_4_2.txt 86"
    "./result_10chains/node389_5_0.txt 85"
    "./result_10chains/node389_5_2.txt 85"
    "./result_10chains/node389_6_0.txt 84"
    "./result_10chains/node389_6_2.txt 84"
    "./result_10chains/node389_7_0.txt 83"
    "./result_10chains/node389_7_2.txt 83"
    "./result_10chains/node389_8_0.txt 82"
    "./result_10chains/node389_8_2.txt 82"
    "./result_10chains/node389_9_0.txt 81"
    "./result_10chains/node389_9_2.txt 81"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
