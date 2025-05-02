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
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_2 -p 112 -st topic377_0_1 -pt None -u 0.007175110030479992 > ./result_8chains/node377_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_2 -p 166 -st topic377_1_1 -pt None -u 0.018998780543337312 > ./result_8chains/node377_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_2 -p 247 -st topic377_2_1 -pt None -u 0.053053017060881946 > ./result_8chains/node377_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_2 -p 275 -st topic377_3_1 -pt None -u 0.02749018991517227 > ./result_8chains/node377_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_2 -p 382 -st topic377_4_1 -pt None -u 0.02422086195480061 > ./result_8chains/node377_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_2 -p 450 -st topic377_5_1 -pt None -u 0.020723044814872776 > ./result_8chains/node377_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_6_2 -p 482 -st topic377_6_1 -pt None -u 0.012910411489836376 > ./result_8chains/node377_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_7_2 -p 834 -st topic377_7_1 -pt None -u 0.05829361533288916 > ./result_8chains/node377_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_0 -p 112 -st none -pt topic377_0_0 -u 0.018922411673121697 > ./result_8chains/node377_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_0 -p 166 -st none -pt topic377_1_0 -u 0.0010012937752004736 > ./result_8chains/node377_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_0 -p 247 -st none -pt topic377_2_0 -u 0.022779335054044614 > ./result_8chains/node377_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_0 -p 275 -st none -pt topic377_3_0 -u 0.0423273955523259 > ./result_8chains/node377_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_0 -p 382 -st none -pt topic377_4_0 -u 0.004301830273215568 > ./result_8chains/node377_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_0 -p 450 -st none -pt topic377_5_0 -u 0.040191792335808996 > ./result_8chains/node377_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_6_0 -p 482 -st none -pt topic377_6_0 -u 0.035219931278701835 > ./result_8chains/node377_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_7_0 -p 834 -st none -pt topic377_7_0 -u 0.02232502872335127 > ./result_8chains/node377_7_0.txt &
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
    "./result_8chains/node377_0_0.txt 90"
    "./result_8chains/node377_0_2.txt 90"
    "./result_8chains/node377_1_0.txt 89"
    "./result_8chains/node377_1_2.txt 89"
    "./result_8chains/node377_2_0.txt 88"
    "./result_8chains/node377_2_2.txt 88"
    "./result_8chains/node377_3_0.txt 87"
    "./result_8chains/node377_3_2.txt 87"
    "./result_8chains/node377_4_0.txt 86"
    "./result_8chains/node377_4_2.txt 86"
    "./result_8chains/node377_5_0.txt 85"
    "./result_8chains/node377_5_2.txt 85"
    "./result_8chains/node377_6_0.txt 84"
    "./result_8chains/node377_6_2.txt 84"
    "./result_8chains/node377_7_0.txt 83"
    "./result_8chains/node377_7_2.txt 83"
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
