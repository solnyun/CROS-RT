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
ros2 run evaluation_3_randomdag uunifast_node -n node341_0_2 -p 34 -st topic341_0_1 -pt None -u 0.018080489710395276 > ./result_10chains/node341_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_1_2 -p 55 -st topic341_1_1 -pt None -u 0.001624476394074259 > ./result_10chains/node341_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_2_2 -p 343 -st topic341_2_1 -pt None -u 0.001946119879627839 > ./result_10chains/node341_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_3_2 -p 347 -st topic341_3_1 -pt None -u 0.06752368642590983 > ./result_10chains/node341_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_4_2 -p 427 -st topic341_4_1 -pt None -u 0.004096181884213179 > ./result_10chains/node341_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_5_2 -p 469 -st topic341_5_1 -pt None -u 0.005034393198492054 > ./result_10chains/node341_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_6_2 -p 816 -st topic341_6_1 -pt None -u 0.00916353655887793 > ./result_10chains/node341_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_7_2 -p 827 -st topic341_7_1 -pt None -u 0.03172329683657053 > ./result_10chains/node341_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_8_2 -p 875 -st topic341_8_1 -pt None -u 0.012405975893301101 > ./result_10chains/node341_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_9_2 -p 942 -st topic341_9_1 -pt None -u 0.0026286174329906826 > ./result_10chains/node341_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_0_0 -p 34 -st none -pt topic341_0_0 -u 0.011102829995635832 > ./result_10chains/node341_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_1_0 -p 55 -st none -pt topic341_1_0 -u 0.043969455814747704 > ./result_10chains/node341_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_2_0 -p 343 -st none -pt topic341_2_0 -u 0.020168737993624175 > ./result_10chains/node341_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_3_0 -p 347 -st none -pt topic341_3_0 -u 0.0006324875826586029 > ./result_10chains/node341_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_4_0 -p 427 -st none -pt topic341_4_0 -u 0.006384215479291189 > ./result_10chains/node341_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_5_0 -p 469 -st none -pt topic341_5_0 -u 0.02441599590212501 > ./result_10chains/node341_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_6_0 -p 816 -st none -pt topic341_6_0 -u 0.0014163728989014523 > ./result_10chains/node341_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_7_0 -p 827 -st none -pt topic341_7_0 -u 0.0008073978530955261 > ./result_10chains/node341_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node341_8_0 -p 875 -st none -pt topic341_8_0 -u 0.006368718582136723 > ./result_10chains/node341_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node341_9_0 -p 942 -st none -pt topic341_9_0 -u 0.006169001525486965 > ./result_10chains/node341_9_0.txt &
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
    "./result_10chains/node341_0_0.txt 90"
    "./result_10chains/node341_0_2.txt 90"
    "./result_10chains/node341_1_0.txt 89"
    "./result_10chains/node341_1_2.txt 89"
    "./result_10chains/node341_2_0.txt 88"
    "./result_10chains/node341_2_2.txt 88"
    "./result_10chains/node341_3_0.txt 87"
    "./result_10chains/node341_3_2.txt 87"
    "./result_10chains/node341_4_0.txt 86"
    "./result_10chains/node341_4_2.txt 86"
    "./result_10chains/node341_5_0.txt 85"
    "./result_10chains/node341_5_2.txt 85"
    "./result_10chains/node341_6_0.txt 84"
    "./result_10chains/node341_6_2.txt 84"
    "./result_10chains/node341_7_0.txt 83"
    "./result_10chains/node341_7_2.txt 83"
    "./result_10chains/node341_8_0.txt 82"
    "./result_10chains/node341_8_2.txt 82"
    "./result_10chains/node341_9_0.txt 81"
    "./result_10chains/node341_9_2.txt 81"
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
