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
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_2 -p 66 -st topic250_0_1 -pt None -u 0.014144943821212619 > ./result_6chains/node250_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_2 -p 264 -st topic250_1_1 -pt None -u 1.856923018633827e-05 > ./result_6chains/node250_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_2 -p 265 -st topic250_2_1 -pt None -u 0.011497898755086472 > ./result_6chains/node250_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_2 -p 394 -st topic250_3_1 -pt None -u 0.02931736165008672 > ./result_6chains/node250_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_2 -p 597 -st topic250_4_1 -pt None -u 0.009327275012574458 > ./result_6chains/node250_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_2 -p 769 -st topic250_5_1 -pt None -u 0.018574108126590105 > ./result_6chains/node250_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_0 -p 66 -st none -pt topic250_0_0 -u 0.028954841916373764 > ./result_6chains/node250_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_0 -p 264 -st none -pt topic250_1_0 -u 0.0222607221593481 > ./result_6chains/node250_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_0 -p 265 -st none -pt topic250_2_0 -u 0.008516883907428385 > ./result_6chains/node250_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_0 -p 394 -st none -pt topic250_3_0 -u 0.011591252536582136 > ./result_6chains/node250_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_0 -p 597 -st none -pt topic250_4_0 -u 0.02775033723392517 > ./result_6chains/node250_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_0 -p 769 -st none -pt topic250_5_0 -u 0.0035782658842789736 > ./result_6chains/node250_5_0.txt &
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
    "./result_6chains/node250_0_0.txt 90"
    "./result_6chains/node250_0_2.txt 90"
    "./result_6chains/node250_1_0.txt 89"
    "./result_6chains/node250_1_2.txt 89"
    "./result_6chains/node250_2_0.txt 88"
    "./result_6chains/node250_2_2.txt 88"
    "./result_6chains/node250_3_0.txt 87"
    "./result_6chains/node250_3_2.txt 87"
    "./result_6chains/node250_4_0.txt 86"
    "./result_6chains/node250_4_2.txt 86"
    "./result_6chains/node250_5_0.txt 85"
    "./result_6chains/node250_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
