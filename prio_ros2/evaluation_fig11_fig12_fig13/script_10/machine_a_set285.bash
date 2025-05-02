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
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_2 -p 42 -st topic285_0_1 -pt None -u 0.00878347622177067 > ./result_10chains/node285_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_2 -p 52 -st topic285_1_1 -pt None -u 0.005709149766254584 > ./result_10chains/node285_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_2 -p 273 -st topic285_2_1 -pt None -u 0.025008541279494367 > ./result_10chains/node285_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_2 -p 326 -st topic285_3_1 -pt None -u 0.018218002141970058 > ./result_10chains/node285_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_2 -p 355 -st topic285_4_1 -pt None -u 0.05026282557714984 > ./result_10chains/node285_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_2 -p 362 -st topic285_5_1 -pt None -u 0.05208441306018985 > ./result_10chains/node285_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_6_2 -p 397 -st topic285_6_1 -pt None -u 0.0037810848496283023 > ./result_10chains/node285_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_7_2 -p 552 -st topic285_7_1 -pt None -u 0.011074296908292813 > ./result_10chains/node285_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_8_2 -p 621 -st topic285_8_1 -pt None -u 0.04313156604601202 > ./result_10chains/node285_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_9_2 -p 854 -st topic285_9_1 -pt None -u 0.017276834712595276 > ./result_10chains/node285_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_0 -p 42 -st none -pt topic285_0_0 -u 0.015802495556310803 > ./result_10chains/node285_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_0 -p 52 -st none -pt topic285_1_0 -u 0.006334333680924176 > ./result_10chains/node285_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_0 -p 273 -st none -pt topic285_2_0 -u 0.0014949969413784459 > ./result_10chains/node285_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_0 -p 326 -st none -pt topic285_3_0 -u 0.0022172717379224105 > ./result_10chains/node285_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_0 -p 355 -st none -pt topic285_4_0 -u 0.00028127389890986176 > ./result_10chains/node285_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_0 -p 362 -st none -pt topic285_5_0 -u 0.031232133759958314 > ./result_10chains/node285_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_6_0 -p 397 -st none -pt topic285_6_0 -u 0.00496638278085304 > ./result_10chains/node285_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_7_0 -p 552 -st none -pt topic285_7_0 -u 0.030380533479197613 > ./result_10chains/node285_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_8_0 -p 621 -st none -pt topic285_8_0 -u 0.005300004759865959 > ./result_10chains/node285_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_9_0 -p 854 -st none -pt topic285_9_0 -u 0.0074779063271351726 > ./result_10chains/node285_9_0.txt &
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
    "./result_10chains/node285_0_0.txt 90"
    "./result_10chains/node285_0_2.txt 90"
    "./result_10chains/node285_1_0.txt 89"
    "./result_10chains/node285_1_2.txt 89"
    "./result_10chains/node285_2_0.txt 88"
    "./result_10chains/node285_2_2.txt 88"
    "./result_10chains/node285_3_0.txt 87"
    "./result_10chains/node285_3_2.txt 87"
    "./result_10chains/node285_4_0.txt 86"
    "./result_10chains/node285_4_2.txt 86"
    "./result_10chains/node285_5_0.txt 85"
    "./result_10chains/node285_5_2.txt 85"
    "./result_10chains/node285_6_0.txt 84"
    "./result_10chains/node285_6_2.txt 84"
    "./result_10chains/node285_7_0.txt 83"
    "./result_10chains/node285_7_2.txt 83"
    "./result_10chains/node285_8_0.txt 82"
    "./result_10chains/node285_8_2.txt 82"
    "./result_10chains/node285_9_0.txt 81"
    "./result_10chains/node285_9_2.txt 81"
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
