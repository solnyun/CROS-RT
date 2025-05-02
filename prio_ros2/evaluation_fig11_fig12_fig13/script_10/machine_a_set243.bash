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
ros2 run evaluation_3_randomdag uunifast_node -n node243_0_2 -p 10 -st topic243_0_1 -pt None -u 0.024082070349179252 > ./result_10chains/node243_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_1_2 -p 122 -st topic243_1_1 -pt None -u 0.024692684457501002 > ./result_10chains/node243_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_2_2 -p 185 -st topic243_2_1 -pt None -u 0.00681930039815043 > ./result_10chains/node243_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_3_2 -p 285 -st topic243_3_1 -pt None -u 0.011372335261290556 > ./result_10chains/node243_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_4_2 -p 367 -st topic243_4_1 -pt None -u 0.0022861575266268086 > ./result_10chains/node243_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_5_2 -p 456 -st topic243_5_1 -pt None -u 0.02433204791250282 > ./result_10chains/node243_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_6_2 -p 647 -st topic243_6_1 -pt None -u 0.030825860136324434 > ./result_10chains/node243_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_7_2 -p 828 -st topic243_7_1 -pt None -u 0.013867667842464432 > ./result_10chains/node243_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_8_2 -p 830 -st topic243_8_1 -pt None -u 0.08102670302027398 > ./result_10chains/node243_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_9_2 -p 869 -st topic243_9_1 -pt None -u 0.01175941860187705 > ./result_10chains/node243_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_0_0 -p 10 -st none -pt topic243_0_0 -u 0.0017676499352196617 > ./result_10chains/node243_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_1_0 -p 122 -st none -pt topic243_1_0 -u 8.20241140941369e-05 > ./result_10chains/node243_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_2_0 -p 185 -st none -pt topic243_2_0 -u 0.021483370327629314 > ./result_10chains/node243_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_3_0 -p 285 -st none -pt topic243_3_0 -u 0.0014089397188681851 > ./result_10chains/node243_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_4_0 -p 367 -st none -pt topic243_4_0 -u 0.01207055663473533 > ./result_10chains/node243_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_5_0 -p 456 -st none -pt topic243_5_0 -u 0.011295471940173218 > ./result_10chains/node243_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_6_0 -p 647 -st none -pt topic243_6_0 -u 0.018842689172021643 > ./result_10chains/node243_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_7_0 -p 828 -st none -pt topic243_7_0 -u 0.003055290542542527 > ./result_10chains/node243_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node243_8_0 -p 830 -st none -pt topic243_8_0 -u 0.020728502815337058 > ./result_10chains/node243_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node243_9_0 -p 869 -st none -pt topic243_9_0 -u 0.001455170615356799 > ./result_10chains/node243_9_0.txt &
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
    "./result_10chains/node243_0_0.txt 90"
    "./result_10chains/node243_0_2.txt 90"
    "./result_10chains/node243_1_0.txt 89"
    "./result_10chains/node243_1_2.txt 89"
    "./result_10chains/node243_2_0.txt 88"
    "./result_10chains/node243_2_2.txt 88"
    "./result_10chains/node243_3_0.txt 87"
    "./result_10chains/node243_3_2.txt 87"
    "./result_10chains/node243_4_0.txt 86"
    "./result_10chains/node243_4_2.txt 86"
    "./result_10chains/node243_5_0.txt 85"
    "./result_10chains/node243_5_2.txt 85"
    "./result_10chains/node243_6_0.txt 84"
    "./result_10chains/node243_6_2.txt 84"
    "./result_10chains/node243_7_0.txt 83"
    "./result_10chains/node243_7_2.txt 83"
    "./result_10chains/node243_8_0.txt 82"
    "./result_10chains/node243_8_2.txt 82"
    "./result_10chains/node243_9_0.txt 81"
    "./result_10chains/node243_9_2.txt 81"
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
