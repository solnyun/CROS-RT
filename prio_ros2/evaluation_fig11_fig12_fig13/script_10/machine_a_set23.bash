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
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_2 -p 135 -st topic23_0_1 -pt None -u 0.021997741753380373 > ./result_10chains/node23_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_2 -p 151 -st topic23_1_1 -pt None -u 0.02560999551771126 > ./result_10chains/node23_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_2 -p 199 -st topic23_2_1 -pt None -u 0.040118367455727055 > ./result_10chains/node23_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_2 -p 297 -st topic23_3_1 -pt None -u 0.02472003238395698 > ./result_10chains/node23_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_2 -p 485 -st topic23_4_1 -pt None -u 0.01380349730035027 > ./result_10chains/node23_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_2 -p 518 -st topic23_5_1 -pt None -u 0.018493651778739406 > ./result_10chains/node23_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_6_2 -p 548 -st topic23_6_1 -pt None -u 0.007186394878756219 > ./result_10chains/node23_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_7_2 -p 661 -st topic23_7_1 -pt None -u 0.02891140882181796 > ./result_10chains/node23_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_8_2 -p 849 -st topic23_8_1 -pt None -u 0.001585888942697275 > ./result_10chains/node23_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_9_2 -p 935 -st topic23_9_1 -pt None -u 0.011919619869172553 > ./result_10chains/node23_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_0 -p 135 -st none -pt topic23_0_0 -u 0.015417764318157057 > ./result_10chains/node23_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_0 -p 151 -st none -pt topic23_1_0 -u 0.008842755931914303 > ./result_10chains/node23_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_0 -p 199 -st none -pt topic23_2_0 -u 0.004030125935800155 > ./result_10chains/node23_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_0 -p 297 -st none -pt topic23_3_0 -u 0.02050934003857441 > ./result_10chains/node23_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_0 -p 485 -st none -pt topic23_4_0 -u 0.012684533470893267 > ./result_10chains/node23_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_0 -p 518 -st none -pt topic23_5_0 -u 0.0051194132112998 > ./result_10chains/node23_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_6_0 -p 548 -st none -pt topic23_6_0 -u 0.021015780524224037 > ./result_10chains/node23_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_7_0 -p 661 -st none -pt topic23_7_0 -u 0.002525309157624195 > ./result_10chains/node23_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node23_8_0 -p 849 -st none -pt topic23_8_0 -u 0.011988078940125213 > ./result_10chains/node23_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node23_9_0 -p 935 -st none -pt topic23_9_0 -u 0.03862496256567757 > ./result_10chains/node23_9_0.txt &
sleep 10
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
    "./result_10chains/node23_0_0.txt 90"
    "./result_10chains/node23_0_2.txt 90"
    "./result_10chains/node23_1_0.txt 89"
    "./result_10chains/node23_1_2.txt 89"
    "./result_10chains/node23_2_0.txt 88"
    "./result_10chains/node23_2_2.txt 88"
    "./result_10chains/node23_3_0.txt 87"
    "./result_10chains/node23_3_2.txt 87"
    "./result_10chains/node23_4_0.txt 86"
    "./result_10chains/node23_4_2.txt 86"
    "./result_10chains/node23_5_0.txt 85"
    "./result_10chains/node23_5_2.txt 85"
    "./result_10chains/node23_6_0.txt 84"
    "./result_10chains/node23_6_2.txt 84"
    "./result_10chains/node23_7_0.txt 83"
    "./result_10chains/node23_7_2.txt 83"
    "./result_10chains/node23_8_0.txt 82"
    "./result_10chains/node23_8_2.txt 82"
    "./result_10chains/node23_9_0.txt 81"
    "./result_10chains/node23_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
