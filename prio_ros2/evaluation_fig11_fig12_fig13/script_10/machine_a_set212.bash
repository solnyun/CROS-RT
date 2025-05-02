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
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_2 -p 51 -st topic212_0_1 -pt None -u 0.019408545012598033 > ./result_10chains/node212_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_2 -p 55 -st topic212_1_1 -pt None -u 0.00032244014995180814 > ./result_10chains/node212_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_2 -p 190 -st topic212_2_1 -pt None -u 0.0040069565103004745 > ./result_10chains/node212_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_2 -p 262 -st topic212_3_1 -pt None -u 0.007726514914527305 > ./result_10chains/node212_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_2 -p 269 -st topic212_4_1 -pt None -u 0.001984524726523107 > ./result_10chains/node212_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_2 -p 468 -st topic212_5_1 -pt None -u 0.02773641481757716 > ./result_10chains/node212_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_6_2 -p 623 -st topic212_6_1 -pt None -u 0.006372250032809834 > ./result_10chains/node212_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_7_2 -p 679 -st topic212_7_1 -pt None -u 0.006041581348236957 > ./result_10chains/node212_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_8_2 -p 756 -st topic212_8_1 -pt None -u 0.01317235175228438 > ./result_10chains/node212_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_9_2 -p 936 -st topic212_9_1 -pt None -u 0.0035532077527025393 > ./result_10chains/node212_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_0 -p 51 -st none -pt topic212_0_0 -u 0.004160006720828391 > ./result_10chains/node212_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_0 -p 55 -st none -pt topic212_1_0 -u 0.021298228670188712 > ./result_10chains/node212_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_0 -p 190 -st none -pt topic212_2_0 -u 0.04744646804983099 > ./result_10chains/node212_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_0 -p 262 -st none -pt topic212_3_0 -u 0.005437097690204673 > ./result_10chains/node212_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_0 -p 269 -st none -pt topic212_4_0 -u 0.01896112869304145 > ./result_10chains/node212_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_0 -p 468 -st none -pt topic212_5_0 -u 0.047661341638323584 > ./result_10chains/node212_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_6_0 -p 623 -st none -pt topic212_6_0 -u 0.000830403320520201 > ./result_10chains/node212_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_7_0 -p 679 -st none -pt topic212_7_0 -u 0.014442112684073138 > ./result_10chains/node212_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_8_0 -p 756 -st none -pt topic212_8_0 -u 0.06919716741311004 > ./result_10chains/node212_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_9_0 -p 936 -st none -pt topic212_9_0 -u 0.04027972426174432 > ./result_10chains/node212_9_0.txt &
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
    "./result_10chains/node212_0_0.txt 90"
    "./result_10chains/node212_0_2.txt 90"
    "./result_10chains/node212_1_0.txt 89"
    "./result_10chains/node212_1_2.txt 89"
    "./result_10chains/node212_2_0.txt 88"
    "./result_10chains/node212_2_2.txt 88"
    "./result_10chains/node212_3_0.txt 87"
    "./result_10chains/node212_3_2.txt 87"
    "./result_10chains/node212_4_0.txt 86"
    "./result_10chains/node212_4_2.txt 86"
    "./result_10chains/node212_5_0.txt 85"
    "./result_10chains/node212_5_2.txt 85"
    "./result_10chains/node212_6_0.txt 84"
    "./result_10chains/node212_6_2.txt 84"
    "./result_10chains/node212_7_0.txt 83"
    "./result_10chains/node212_7_2.txt 83"
    "./result_10chains/node212_8_0.txt 82"
    "./result_10chains/node212_8_2.txt 82"
    "./result_10chains/node212_9_0.txt 81"
    "./result_10chains/node212_9_2.txt 81"
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
