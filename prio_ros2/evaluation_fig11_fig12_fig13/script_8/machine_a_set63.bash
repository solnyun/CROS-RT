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
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_2 -p 154 -st topic63_0_1 -pt None -u 0.030732133609769674 > ./result_8chains/node63_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_2 -p 235 -st topic63_1_1 -pt None -u 0.028008716209035722 > ./result_8chains/node63_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_2 -p 328 -st topic63_2_1 -pt None -u 0.007709441062939804 > ./result_8chains/node63_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_2 -p 417 -st topic63_3_1 -pt None -u 0.04211292255090043 > ./result_8chains/node63_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_2 -p 524 -st topic63_4_1 -pt None -u 0.019574760151229137 > ./result_8chains/node63_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_2 -p 681 -st topic63_5_1 -pt None -u 0.0547139096300181 > ./result_8chains/node63_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_6_2 -p 978 -st topic63_6_1 -pt None -u 0.006449353529916366 > ./result_8chains/node63_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_7_2 -p 984 -st topic63_7_1 -pt None -u 0.002573668768469324 > ./result_8chains/node63_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_0 -p 154 -st none -pt topic63_0_0 -u 0.00923077148445317 > ./result_8chains/node63_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_0 -p 235 -st none -pt topic63_1_0 -u 0.009867295737014226 > ./result_8chains/node63_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_0 -p 328 -st none -pt topic63_2_0 -u 0.02009037114883283 > ./result_8chains/node63_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_0 -p 417 -st none -pt topic63_3_0 -u 0.01622857887361212 > ./result_8chains/node63_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_0 -p 524 -st none -pt topic63_4_0 -u 0.0007422948509387683 > ./result_8chains/node63_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_0 -p 681 -st none -pt topic63_5_0 -u 0.0029626702202839583 > ./result_8chains/node63_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_6_0 -p 978 -st none -pt topic63_6_0 -u 0.027290670126496885 > ./result_8chains/node63_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_7_0 -p 984 -st none -pt topic63_7_0 -u 0.06804234790199296 > ./result_8chains/node63_7_0.txt &
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
    "./result_8chains/node63_0_0.txt 90"
    "./result_8chains/node63_0_2.txt 90"
    "./result_8chains/node63_1_0.txt 89"
    "./result_8chains/node63_1_2.txt 89"
    "./result_8chains/node63_2_0.txt 88"
    "./result_8chains/node63_2_2.txt 88"
    "./result_8chains/node63_3_0.txt 87"
    "./result_8chains/node63_3_2.txt 87"
    "./result_8chains/node63_4_0.txt 86"
    "./result_8chains/node63_4_2.txt 86"
    "./result_8chains/node63_5_0.txt 85"
    "./result_8chains/node63_5_2.txt 85"
    "./result_8chains/node63_6_0.txt 84"
    "./result_8chains/node63_6_2.txt 84"
    "./result_8chains/node63_7_0.txt 83"
    "./result_8chains/node63_7_2.txt 83"
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
