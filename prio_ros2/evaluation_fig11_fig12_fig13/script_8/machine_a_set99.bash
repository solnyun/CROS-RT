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
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_2 -p 47 -st topic99_0_1 -pt None -u 0.022895568159877866 > ./result_8chains/node99_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_2 -p 71 -st topic99_1_1 -pt None -u 0.033464188340285805 > ./result_8chains/node99_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_2 -p 137 -st topic99_2_1 -pt None -u 0.006172347907927589 > ./result_8chains/node99_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_2 -p 209 -st topic99_3_1 -pt None -u 0.01711935392388292 > ./result_8chains/node99_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_2 -p 387 -st topic99_4_1 -pt None -u 0.002097557732784916 > ./result_8chains/node99_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_2 -p 595 -st topic99_5_1 -pt None -u 0.007234151380799234 > ./result_8chains/node99_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_6_2 -p 606 -st topic99_6_1 -pt None -u 0.0024396029493500004 > ./result_8chains/node99_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_7_2 -p 608 -st topic99_7_1 -pt None -u 0.01439611585525139 > ./result_8chains/node99_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_0 -p 47 -st none -pt topic99_0_0 -u 0.007923010829000654 > ./result_8chains/node99_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_0 -p 71 -st none -pt topic99_1_0 -u 0.02462326368670731 > ./result_8chains/node99_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_0 -p 137 -st none -pt topic99_2_0 -u 0.004390953235732908 > ./result_8chains/node99_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_0 -p 209 -st none -pt topic99_3_0 -u 0.03454637981543596 > ./result_8chains/node99_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_0 -p 387 -st none -pt topic99_4_0 -u 0.0451027549027225 > ./result_8chains/node99_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_0 -p 595 -st none -pt topic99_5_0 -u 0.006927667933297993 > ./result_8chains/node99_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_6_0 -p 606 -st none -pt topic99_6_0 -u 0.011805382606323675 > ./result_8chains/node99_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_7_0 -p 608 -st none -pt topic99_7_0 -u 0.012725087522722632 > ./result_8chains/node99_7_0.txt &
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
    "./result_8chains/node99_0_0.txt 90"
    "./result_8chains/node99_0_2.txt 90"
    "./result_8chains/node99_1_0.txt 89"
    "./result_8chains/node99_1_2.txt 89"
    "./result_8chains/node99_2_0.txt 88"
    "./result_8chains/node99_2_2.txt 88"
    "./result_8chains/node99_3_0.txt 87"
    "./result_8chains/node99_3_2.txt 87"
    "./result_8chains/node99_4_0.txt 86"
    "./result_8chains/node99_4_2.txt 86"
    "./result_8chains/node99_5_0.txt 85"
    "./result_8chains/node99_5_2.txt 85"
    "./result_8chains/node99_6_0.txt 84"
    "./result_8chains/node99_6_2.txt 84"
    "./result_8chains/node99_7_0.txt 83"
    "./result_8chains/node99_7_2.txt 83"
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
