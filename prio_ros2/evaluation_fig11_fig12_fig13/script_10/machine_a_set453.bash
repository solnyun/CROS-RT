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
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_2 -p 13 -st topic453_0_1 -pt None -u 0.00879011332766233 > ./result_10chains/node453_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_2 -p 142 -st topic453_1_1 -pt None -u 0.02137306904188463 > ./result_10chains/node453_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_2 -p 167 -st topic453_2_1 -pt None -u 0.015921205584774722 > ./result_10chains/node453_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_2 -p 191 -st topic453_3_1 -pt None -u 0.03302335942075618 > ./result_10chains/node453_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_2 -p 441 -st topic453_4_1 -pt None -u 0.039757619375562214 > ./result_10chains/node453_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_2 -p 455 -st topic453_5_1 -pt None -u 0.017030103807585795 > ./result_10chains/node453_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_6_2 -p 512 -st topic453_6_1 -pt None -u 0.026928505032597555 > ./result_10chains/node453_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_7_2 -p 685 -st topic453_7_1 -pt None -u 0.037928752981074565 > ./result_10chains/node453_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_8_2 -p 839 -st topic453_8_1 -pt None -u 0.006909755097842155 > ./result_10chains/node453_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_9_2 -p 846 -st topic453_9_1 -pt None -u 3.590458478100137e-05 > ./result_10chains/node453_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_0 -p 13 -st none -pt topic453_0_0 -u 0.036862068909779944 > ./result_10chains/node453_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_0 -p 142 -st none -pt topic453_1_0 -u 0.01253485508498453 > ./result_10chains/node453_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_0 -p 167 -st none -pt topic453_2_0 -u 0.014570240609644458 > ./result_10chains/node453_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_0 -p 191 -st none -pt topic453_3_0 -u 0.020886484406057337 > ./result_10chains/node453_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_0 -p 441 -st none -pt topic453_4_0 -u 0.020175276095907857 > ./result_10chains/node453_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_0 -p 455 -st none -pt topic453_5_0 -u 0.002146655234072259 > ./result_10chains/node453_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_6_0 -p 512 -st none -pt topic453_6_0 -u 0.003447652084204611 > ./result_10chains/node453_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_7_0 -p 685 -st none -pt topic453_7_0 -u 0.026215665150831458 > ./result_10chains/node453_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_8_0 -p 839 -st none -pt topic453_8_0 -u 0.05011802212059577 > ./result_10chains/node453_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_9_0 -p 846 -st none -pt topic453_9_0 -u 0.012494835300722026 > ./result_10chains/node453_9_0.txt &
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
    "./result_10chains/node453_0_0.txt 90"
    "./result_10chains/node453_0_2.txt 90"
    "./result_10chains/node453_1_0.txt 89"
    "./result_10chains/node453_1_2.txt 89"
    "./result_10chains/node453_2_0.txt 88"
    "./result_10chains/node453_2_2.txt 88"
    "./result_10chains/node453_3_0.txt 87"
    "./result_10chains/node453_3_2.txt 87"
    "./result_10chains/node453_4_0.txt 86"
    "./result_10chains/node453_4_2.txt 86"
    "./result_10chains/node453_5_0.txt 85"
    "./result_10chains/node453_5_2.txt 85"
    "./result_10chains/node453_6_0.txt 84"
    "./result_10chains/node453_6_2.txt 84"
    "./result_10chains/node453_7_0.txt 83"
    "./result_10chains/node453_7_2.txt 83"
    "./result_10chains/node453_8_0.txt 82"
    "./result_10chains/node453_8_2.txt 82"
    "./result_10chains/node453_9_0.txt 81"
    "./result_10chains/node453_9_2.txt 81"
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
