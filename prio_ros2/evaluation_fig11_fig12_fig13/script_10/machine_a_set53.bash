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
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_2 -p 199 -st topic53_0_1 -pt None -u 0.04025065630466823 > ./result_10chains/node53_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_2 -p 220 -st topic53_1_1 -pt None -u 0.003921471728987158 > ./result_10chains/node53_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_2 -p 283 -st topic53_2_1 -pt None -u 0.019429805328543548 > ./result_10chains/node53_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_2 -p 330 -st topic53_3_1 -pt None -u 0.058938931131187366 > ./result_10chains/node53_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_2 -p 545 -st topic53_4_1 -pt None -u 0.00016235369600933747 > ./result_10chains/node53_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_2 -p 571 -st topic53_5_1 -pt None -u 0.0034715706636673227 > ./result_10chains/node53_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_6_2 -p 704 -st topic53_6_1 -pt None -u 5.7820134135216916e-05 > ./result_10chains/node53_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_7_2 -p 802 -st topic53_7_1 -pt None -u 0.007452892550152884 > ./result_10chains/node53_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_8_2 -p 833 -st topic53_8_1 -pt None -u 0.016646247569291756 > ./result_10chains/node53_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_9_2 -p 917 -st topic53_9_1 -pt None -u 0.0078062186671778964 > ./result_10chains/node53_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_0_0 -p 199 -st none -pt topic53_0_0 -u 0.026188520225670642 > ./result_10chains/node53_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_1_0 -p 220 -st none -pt topic53_1_0 -u 0.00422280226165378 > ./result_10chains/node53_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_2_0 -p 283 -st none -pt topic53_2_0 -u 0.00046858633120172577 > ./result_10chains/node53_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_3_0 -p 330 -st none -pt topic53_3_0 -u 0.009214352000409542 > ./result_10chains/node53_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_4_0 -p 545 -st none -pt topic53_4_0 -u 0.022656726478898687 > ./result_10chains/node53_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_5_0 -p 571 -st none -pt topic53_5_0 -u 0.018328451087360087 > ./result_10chains/node53_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_6_0 -p 704 -st none -pt topic53_6_0 -u 0.04137164248720257 > ./result_10chains/node53_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_7_0 -p 802 -st none -pt topic53_7_0 -u 0.0025455881640930045 > ./result_10chains/node53_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node53_8_0 -p 833 -st none -pt topic53_8_0 -u 0.022405980914075238 > ./result_10chains/node53_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node53_9_0 -p 917 -st none -pt topic53_9_0 -u 0.03689752910950448 > ./result_10chains/node53_9_0.txt &
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
    "./result_10chains/node53_0_0.txt 90"
    "./result_10chains/node53_0_2.txt 90"
    "./result_10chains/node53_1_0.txt 89"
    "./result_10chains/node53_1_2.txt 89"
    "./result_10chains/node53_2_0.txt 88"
    "./result_10chains/node53_2_2.txt 88"
    "./result_10chains/node53_3_0.txt 87"
    "./result_10chains/node53_3_2.txt 87"
    "./result_10chains/node53_4_0.txt 86"
    "./result_10chains/node53_4_2.txt 86"
    "./result_10chains/node53_5_0.txt 85"
    "./result_10chains/node53_5_2.txt 85"
    "./result_10chains/node53_6_0.txt 84"
    "./result_10chains/node53_6_2.txt 84"
    "./result_10chains/node53_7_0.txt 83"
    "./result_10chains/node53_7_2.txt 83"
    "./result_10chains/node53_8_0.txt 82"
    "./result_10chains/node53_8_2.txt 82"
    "./result_10chains/node53_9_0.txt 81"
    "./result_10chains/node53_9_2.txt 81"
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
