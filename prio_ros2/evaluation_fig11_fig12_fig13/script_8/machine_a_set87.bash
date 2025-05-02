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
ros2 run evaluation_3_randomdag uunifast_node -n node87_0_2 -p 105 -st topic87_0_1 -pt None -u 0.03883923603401124 > ./result_8chains/node87_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_1_2 -p 156 -st topic87_1_1 -pt None -u 0.021418597225511038 > ./result_8chains/node87_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_2_2 -p 282 -st topic87_2_1 -pt None -u 0.011823296030543912 > ./result_8chains/node87_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_3_2 -p 484 -st topic87_3_1 -pt None -u 0.003926394274472195 > ./result_8chains/node87_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_4_2 -p 523 -st topic87_4_1 -pt None -u 0.008749831344826056 > ./result_8chains/node87_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_5_2 -p 571 -st topic87_5_1 -pt None -u 0.0015769239628305592 > ./result_8chains/node87_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_6_2 -p 593 -st topic87_6_1 -pt None -u 0.010759154681464461 > ./result_8chains/node87_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_7_2 -p 971 -st topic87_7_1 -pt None -u 0.04286726835012832 > ./result_8chains/node87_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_0_0 -p 105 -st none -pt topic87_0_0 -u 0.00581573764350557 > ./result_8chains/node87_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_1_0 -p 156 -st none -pt topic87_1_0 -u 0.04454648010303763 > ./result_8chains/node87_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_2_0 -p 282 -st none -pt topic87_2_0 -u 0.04754420721540975 > ./result_8chains/node87_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_3_0 -p 484 -st none -pt topic87_3_0 -u 0.007403526799162924 > ./result_8chains/node87_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_4_0 -p 523 -st none -pt topic87_4_0 -u 0.07778323888527802 > ./result_8chains/node87_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_5_0 -p 571 -st none -pt topic87_5_0 -u 0.010237534150867728 > ./result_8chains/node87_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_6_0 -p 593 -st none -pt topic87_6_0 -u 0.0008149921657703979 > ./result_8chains/node87_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node87_7_0 -p 971 -st none -pt topic87_7_0 -u 0.017277532831701498 > ./result_8chains/node87_7_0.txt &
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
    "./result_8chains/node87_0_0.txt 90"
    "./result_8chains/node87_0_2.txt 90"
    "./result_8chains/node87_1_0.txt 89"
    "./result_8chains/node87_1_2.txt 89"
    "./result_8chains/node87_2_0.txt 88"
    "./result_8chains/node87_2_2.txt 88"
    "./result_8chains/node87_3_0.txt 87"
    "./result_8chains/node87_3_2.txt 87"
    "./result_8chains/node87_4_0.txt 86"
    "./result_8chains/node87_4_2.txt 86"
    "./result_8chains/node87_5_0.txt 85"
    "./result_8chains/node87_5_2.txt 85"
    "./result_8chains/node87_6_0.txt 84"
    "./result_8chains/node87_6_2.txt 84"
    "./result_8chains/node87_7_0.txt 83"
    "./result_8chains/node87_7_2.txt 83"
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
