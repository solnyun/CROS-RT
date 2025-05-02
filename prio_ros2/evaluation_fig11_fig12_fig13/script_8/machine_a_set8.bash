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
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_2 -p 61 -st topic8_0_1 -pt None -u 0.028866923348480455 > ./result_8chains/node8_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_2 -p 457 -st topic8_1_1 -pt None -u 0.062372039226290255 > ./result_8chains/node8_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_2 -p 683 -st topic8_2_1 -pt None -u 0.017088361013247844 > ./result_8chains/node8_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_2 -p 764 -st topic8_3_1 -pt None -u 0.041315462495366606 > ./result_8chains/node8_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_2 -p 852 -st topic8_4_1 -pt None -u 0.01788550983065257 > ./result_8chains/node8_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_2 -p 864 -st topic8_5_1 -pt None -u 0.03356233258089712 > ./result_8chains/node8_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_6_2 -p 900 -st topic8_6_1 -pt None -u 0.005528890623485487 > ./result_8chains/node8_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_7_2 -p 961 -st topic8_7_1 -pt None -u 0.049202085335085355 > ./result_8chains/node8_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_0_0 -p 61 -st none -pt topic8_0_0 -u 0.0020617222024115756 > ./result_8chains/node8_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_1_0 -p 457 -st none -pt topic8_1_0 -u 0.011730304847679729 > ./result_8chains/node8_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_2_0 -p 683 -st none -pt topic8_2_0 -u 0.01328450724452418 > ./result_8chains/node8_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_3_0 -p 764 -st none -pt topic8_3_0 -u 0.007941785647569699 > ./result_8chains/node8_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_4_0 -p 852 -st none -pt topic8_4_0 -u 0.014221172249531566 > ./result_8chains/node8_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_5_0 -p 864 -st none -pt topic8_5_0 -u 0.03612073628881468 > ./result_8chains/node8_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node8_6_0 -p 900 -st none -pt topic8_6_0 -u 0.012625850927846932 > ./result_8chains/node8_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node8_7_0 -p 961 -st none -pt topic8_7_0 -u 0.0011774480865106782 > ./result_8chains/node8_7_0.txt &
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
    "./result_8chains/node8_0_0.txt 90"
    "./result_8chains/node8_0_2.txt 90"
    "./result_8chains/node8_1_0.txt 89"
    "./result_8chains/node8_1_2.txt 89"
    "./result_8chains/node8_2_0.txt 88"
    "./result_8chains/node8_2_2.txt 88"
    "./result_8chains/node8_3_0.txt 87"
    "./result_8chains/node8_3_2.txt 87"
    "./result_8chains/node8_4_0.txt 86"
    "./result_8chains/node8_4_2.txt 86"
    "./result_8chains/node8_5_0.txt 85"
    "./result_8chains/node8_5_2.txt 85"
    "./result_8chains/node8_6_0.txt 84"
    "./result_8chains/node8_6_2.txt 84"
    "./result_8chains/node8_7_0.txt 83"
    "./result_8chains/node8_7_2.txt 83"
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
