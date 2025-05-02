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
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_2 -p 21 -st topic178_0_1 -pt None -u 0.025701305212097625 > ./result_8chains/node178_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_2 -p 97 -st topic178_1_1 -pt None -u 0.059197857464429515 > ./result_8chains/node178_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_2 -p 219 -st topic178_2_1 -pt None -u 0.0063677985335697795 > ./result_8chains/node178_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_2 -p 257 -st topic178_3_1 -pt None -u 0.053906881572737875 > ./result_8chains/node178_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_2 -p 488 -st topic178_4_1 -pt None -u 0.027956191927070412 > ./result_8chains/node178_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_2 -p 602 -st topic178_5_1 -pt None -u 0.045315006609672914 > ./result_8chains/node178_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_6_2 -p 700 -st topic178_6_1 -pt None -u 0.013439735725030717 > ./result_8chains/node178_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_7_2 -p 858 -st topic178_7_1 -pt None -u 0.007527721541685856 > ./result_8chains/node178_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_0 -p 21 -st none -pt topic178_0_0 -u 0.030990244633187336 > ./result_8chains/node178_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_0 -p 97 -st none -pt topic178_1_0 -u 0.02750898805567814 > ./result_8chains/node178_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_0 -p 219 -st none -pt topic178_2_0 -u 0.004179700495333061 > ./result_8chains/node178_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_0 -p 257 -st none -pt topic178_3_0 -u 0.004186320647936503 > ./result_8chains/node178_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_0 -p 488 -st none -pt topic178_4_0 -u 0.004022779453852876 > ./result_8chains/node178_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_0 -p 602 -st none -pt topic178_5_0 -u 0.01594008755402404 > ./result_8chains/node178_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_6_0 -p 700 -st none -pt topic178_6_0 -u 0.023398275066623148 > ./result_8chains/node178_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_7_0 -p 858 -st none -pt topic178_7_0 -u 0.01095551803526116 > ./result_8chains/node178_7_0.txt &
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
    "./result_8chains/node178_0_0.txt 90"
    "./result_8chains/node178_0_2.txt 90"
    "./result_8chains/node178_1_0.txt 89"
    "./result_8chains/node178_1_2.txt 89"
    "./result_8chains/node178_2_0.txt 88"
    "./result_8chains/node178_2_2.txt 88"
    "./result_8chains/node178_3_0.txt 87"
    "./result_8chains/node178_3_2.txt 87"
    "./result_8chains/node178_4_0.txt 86"
    "./result_8chains/node178_4_2.txt 86"
    "./result_8chains/node178_5_0.txt 85"
    "./result_8chains/node178_5_2.txt 85"
    "./result_8chains/node178_6_0.txt 84"
    "./result_8chains/node178_6_2.txt 84"
    "./result_8chains/node178_7_0.txt 83"
    "./result_8chains/node178_7_2.txt 83"
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
