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
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_2 -p 35 -st topic263_0_1 -pt None -u 0.0041147948170030535 > ./result_10chains/node263_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_2 -p 153 -st topic263_1_1 -pt None -u 0.02839037596289945 > ./result_10chains/node263_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_2 -p 175 -st topic263_2_1 -pt None -u 0.004276401247287287 > ./result_10chains/node263_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_2 -p 183 -st topic263_3_1 -pt None -u 0.013715630928791245 > ./result_10chains/node263_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_2 -p 424 -st topic263_4_1 -pt None -u 0.009260254806020995 > ./result_10chains/node263_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_2 -p 572 -st topic263_5_1 -pt None -u 0.004127061427748269 > ./result_10chains/node263_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_6_2 -p 596 -st topic263_6_1 -pt None -u 0.024169941272144085 > ./result_10chains/node263_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_7_2 -p 640 -st topic263_7_1 -pt None -u 0.032578763308129616 > ./result_10chains/node263_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_8_2 -p 883 -st topic263_8_1 -pt None -u 0.02377325188671202 > ./result_10chains/node263_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_9_2 -p 998 -st topic263_9_1 -pt None -u 0.0948045768237201 > ./result_10chains/node263_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_0 -p 35 -st none -pt topic263_0_0 -u 0.016015232542120894 > ./result_10chains/node263_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_0 -p 153 -st none -pt topic263_1_0 -u 0.04868027928580326 > ./result_10chains/node263_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_0 -p 175 -st none -pt topic263_2_0 -u 0.009767711991913619 > ./result_10chains/node263_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_0 -p 183 -st none -pt topic263_3_0 -u 0.00023598904330557335 > ./result_10chains/node263_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_0 -p 424 -st none -pt topic263_4_0 -u 0.004463360025536323 > ./result_10chains/node263_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_0 -p 572 -st none -pt topic263_5_0 -u 0.029462696447872416 > ./result_10chains/node263_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_6_0 -p 596 -st none -pt topic263_6_0 -u 0.03217554332958261 > ./result_10chains/node263_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_7_0 -p 640 -st none -pt topic263_7_0 -u 0.02181840322952222 > ./result_10chains/node263_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_8_0 -p 883 -st none -pt topic263_8_0 -u 0.013049544679858888 > ./result_10chains/node263_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node263_9_0 -p 998 -st none -pt topic263_9_0 -u 0.009185354272542134 > ./result_10chains/node263_9_0.txt &
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
    "./result_10chains/node263_0_0.txt 90"
    "./result_10chains/node263_0_2.txt 90"
    "./result_10chains/node263_1_0.txt 89"
    "./result_10chains/node263_1_2.txt 89"
    "./result_10chains/node263_2_0.txt 88"
    "./result_10chains/node263_2_2.txt 88"
    "./result_10chains/node263_3_0.txt 87"
    "./result_10chains/node263_3_2.txt 87"
    "./result_10chains/node263_4_0.txt 86"
    "./result_10chains/node263_4_2.txt 86"
    "./result_10chains/node263_5_0.txt 85"
    "./result_10chains/node263_5_2.txt 85"
    "./result_10chains/node263_6_0.txt 84"
    "./result_10chains/node263_6_2.txt 84"
    "./result_10chains/node263_7_0.txt 83"
    "./result_10chains/node263_7_2.txt 83"
    "./result_10chains/node263_8_0.txt 82"
    "./result_10chains/node263_8_2.txt 82"
    "./result_10chains/node263_9_0.txt 81"
    "./result_10chains/node263_9_2.txt 81"
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
