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
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_2 -p 199 -st topic172_0_1 -pt None -u 0.0008762832106384288 > ./result_8chains/node172_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_2 -p 241 -st topic172_1_1 -pt None -u 0.0021244000990075507 > ./result_8chains/node172_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_2 -p 265 -st topic172_2_1 -pt None -u 0.03829888856208136 > ./result_8chains/node172_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_2 -p 398 -st topic172_3_1 -pt None -u 0.011139863205471945 > ./result_8chains/node172_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_2 -p 652 -st topic172_4_1 -pt None -u 0.04669042671860357 > ./result_8chains/node172_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_2 -p 780 -st topic172_5_1 -pt None -u 0.029897080514171975 > ./result_8chains/node172_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_6_2 -p 910 -st topic172_6_1 -pt None -u 0.005866022954753573 > ./result_8chains/node172_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_7_2 -p 936 -st topic172_7_1 -pt None -u 0.0038060350306381857 > ./result_8chains/node172_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_0 -p 199 -st none -pt topic172_0_0 -u 0.038587396054311385 > ./result_8chains/node172_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_0 -p 241 -st none -pt topic172_1_0 -u 0.002786595005622061 > ./result_8chains/node172_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_0 -p 265 -st none -pt topic172_2_0 -u 0.008238796117282787 > ./result_8chains/node172_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_0 -p 398 -st none -pt topic172_3_0 -u 0.0005863000438098842 > ./result_8chains/node172_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_0 -p 652 -st none -pt topic172_4_0 -u 0.042001885190681654 > ./result_8chains/node172_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_0 -p 780 -st none -pt topic172_5_0 -u 0.01167407225436673 > ./result_8chains/node172_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_6_0 -p 910 -st none -pt topic172_6_0 -u 0.03250627849143037 > ./result_8chains/node172_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node172_7_0 -p 936 -st none -pt topic172_7_0 -u 0.035001738892891016 > ./result_8chains/node172_7_0.txt &
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
    "./result_8chains/node172_0_0.txt 90"
    "./result_8chains/node172_0_2.txt 90"
    "./result_8chains/node172_1_0.txt 89"
    "./result_8chains/node172_1_2.txt 89"
    "./result_8chains/node172_2_0.txt 88"
    "./result_8chains/node172_2_2.txt 88"
    "./result_8chains/node172_3_0.txt 87"
    "./result_8chains/node172_3_2.txt 87"
    "./result_8chains/node172_4_0.txt 86"
    "./result_8chains/node172_4_2.txt 86"
    "./result_8chains/node172_5_0.txt 85"
    "./result_8chains/node172_5_2.txt 85"
    "./result_8chains/node172_6_0.txt 84"
    "./result_8chains/node172_6_2.txt 84"
    "./result_8chains/node172_7_0.txt 83"
    "./result_8chains/node172_7_2.txt 83"
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
