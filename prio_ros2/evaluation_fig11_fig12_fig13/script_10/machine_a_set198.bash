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
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_2 -p 151 -st topic198_0_1 -pt None -u 0.00933452088634934 > ./result_10chains/node198_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_2 -p 287 -st topic198_1_1 -pt None -u 0.007773423083164921 > ./result_10chains/node198_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_2 -p 305 -st topic198_2_1 -pt None -u 0.0008949507547954538 > ./result_10chains/node198_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_2 -p 363 -st topic198_3_1 -pt None -u 0.017271403042071254 > ./result_10chains/node198_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_2 -p 518 -st topic198_4_1 -pt None -u 0.03473263736178411 > ./result_10chains/node198_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_2 -p 533 -st topic198_5_1 -pt None -u 0.033565641082254016 > ./result_10chains/node198_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_6_2 -p 751 -st topic198_6_1 -pt None -u 0.013455471901012275 > ./result_10chains/node198_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_7_2 -p 794 -st topic198_7_1 -pt None -u 0.015926324429539035 > ./result_10chains/node198_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_8_2 -p 800 -st topic198_8_1 -pt None -u 0.0006109478001128238 > ./result_10chains/node198_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_9_2 -p 911 -st topic198_9_1 -pt None -u 0.02778632215671767 > ./result_10chains/node198_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_0 -p 151 -st none -pt topic198_0_0 -u 0.008897664435141062 > ./result_10chains/node198_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_0 -p 287 -st none -pt topic198_1_0 -u 0.018854134922123067 > ./result_10chains/node198_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_0 -p 305 -st none -pt topic198_2_0 -u 0.014956348194219427 > ./result_10chains/node198_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_0 -p 363 -st none -pt topic198_3_0 -u 0.008538447334764387 > ./result_10chains/node198_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_0 -p 518 -st none -pt topic198_4_0 -u 0.005354504591187803 > ./result_10chains/node198_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_0 -p 533 -st none -pt topic198_5_0 -u 0.0030183778131450123 > ./result_10chains/node198_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_6_0 -p 751 -st none -pt topic198_6_0 -u 0.020289721146027867 > ./result_10chains/node198_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_7_0 -p 794 -st none -pt topic198_7_0 -u 0.001256033645521376 > ./result_10chains/node198_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_8_0 -p 800 -st none -pt topic198_8_0 -u 0.005100056067754669 > ./result_10chains/node198_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_9_0 -p 911 -st none -pt topic198_9_0 -u 0.03699049044908226 > ./result_10chains/node198_9_0.txt &
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
    "./result_10chains/node198_0_0.txt 90"
    "./result_10chains/node198_0_2.txt 90"
    "./result_10chains/node198_1_0.txt 89"
    "./result_10chains/node198_1_2.txt 89"
    "./result_10chains/node198_2_0.txt 88"
    "./result_10chains/node198_2_2.txt 88"
    "./result_10chains/node198_3_0.txt 87"
    "./result_10chains/node198_3_2.txt 87"
    "./result_10chains/node198_4_0.txt 86"
    "./result_10chains/node198_4_2.txt 86"
    "./result_10chains/node198_5_0.txt 85"
    "./result_10chains/node198_5_2.txt 85"
    "./result_10chains/node198_6_0.txt 84"
    "./result_10chains/node198_6_2.txt 84"
    "./result_10chains/node198_7_0.txt 83"
    "./result_10chains/node198_7_2.txt 83"
    "./result_10chains/node198_8_0.txt 82"
    "./result_10chains/node198_8_2.txt 82"
    "./result_10chains/node198_9_0.txt 81"
    "./result_10chains/node198_9_2.txt 81"
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
