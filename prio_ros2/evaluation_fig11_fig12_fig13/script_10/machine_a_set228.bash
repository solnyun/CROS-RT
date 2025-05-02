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
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_2 -p 220 -st topic228_0_1 -pt None -u 0.03238645284778602 > ./result_10chains/node228_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_2 -p 290 -st topic228_1_1 -pt None -u 0.010413643564936126 > ./result_10chains/node228_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_2 -p 302 -st topic228_2_1 -pt None -u 0.015600126544258741 > ./result_10chains/node228_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_2 -p 428 -st topic228_3_1 -pt None -u 0.02160641152456594 > ./result_10chains/node228_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_2 -p 498 -st topic228_4_1 -pt None -u 0.00023813874756850595 > ./result_10chains/node228_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_2 -p 638 -st topic228_5_1 -pt None -u 0.0149824234115489 > ./result_10chains/node228_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_6_2 -p 786 -st topic228_6_1 -pt None -u 0.04254305362188868 > ./result_10chains/node228_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_7_2 -p 815 -st topic228_7_1 -pt None -u 0.012056778324054288 > ./result_10chains/node228_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_8_2 -p 836 -st topic228_8_1 -pt None -u 0.0170699021851866 > ./result_10chains/node228_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_9_2 -p 932 -st topic228_9_1 -pt None -u 0.03688438507187411 > ./result_10chains/node228_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_0 -p 220 -st none -pt topic228_0_0 -u 0.0013214833681744476 > ./result_10chains/node228_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_0 -p 290 -st none -pt topic228_1_0 -u 0.02888158102791738 > ./result_10chains/node228_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_0 -p 302 -st none -pt topic228_2_0 -u 0.021599213616015522 > ./result_10chains/node228_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_0 -p 428 -st none -pt topic228_3_0 -u 0.019042011879186638 > ./result_10chains/node228_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_0 -p 498 -st none -pt topic228_4_0 -u 0.0028790193048885415 > ./result_10chains/node228_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_0 -p 638 -st none -pt topic228_5_0 -u 0.050461703290735516 > ./result_10chains/node228_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_6_0 -p 786 -st none -pt topic228_6_0 -u 0.002544441537322417 > ./result_10chains/node228_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_7_0 -p 815 -st none -pt topic228_7_0 -u 0.008725436813281084 > ./result_10chains/node228_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_8_0 -p 836 -st none -pt topic228_8_0 -u 0.023793829795188 > ./result_10chains/node228_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_9_0 -p 932 -st none -pt topic228_9_0 -u 0.0046822987003085625 > ./result_10chains/node228_9_0.txt &
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
    "./result_10chains/node228_0_0.txt 90"
    "./result_10chains/node228_0_2.txt 90"
    "./result_10chains/node228_1_0.txt 89"
    "./result_10chains/node228_1_2.txt 89"
    "./result_10chains/node228_2_0.txt 88"
    "./result_10chains/node228_2_2.txt 88"
    "./result_10chains/node228_3_0.txt 87"
    "./result_10chains/node228_3_2.txt 87"
    "./result_10chains/node228_4_0.txt 86"
    "./result_10chains/node228_4_2.txt 86"
    "./result_10chains/node228_5_0.txt 85"
    "./result_10chains/node228_5_2.txt 85"
    "./result_10chains/node228_6_0.txt 84"
    "./result_10chains/node228_6_2.txt 84"
    "./result_10chains/node228_7_0.txt 83"
    "./result_10chains/node228_7_2.txt 83"
    "./result_10chains/node228_8_0.txt 82"
    "./result_10chains/node228_8_2.txt 82"
    "./result_10chains/node228_9_0.txt 81"
    "./result_10chains/node228_9_2.txt 81"
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
