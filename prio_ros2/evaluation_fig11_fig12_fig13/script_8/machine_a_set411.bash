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
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_2 -p 52 -st topic411_0_1 -pt None -u 0.06964316079156674 > ./result_8chains/node411_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_2 -p 312 -st topic411_1_1 -pt None -u 0.012435632664387297 > ./result_8chains/node411_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_2 -p 387 -st topic411_2_1 -pt None -u 0.006509274703412449 > ./result_8chains/node411_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_2 -p 397 -st topic411_3_1 -pt None -u 0.020711320254252402 > ./result_8chains/node411_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_2 -p 551 -st topic411_4_1 -pt None -u 0.002353243722125087 > ./result_8chains/node411_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_2 -p 797 -st topic411_5_1 -pt None -u 0.008301411484909232 > ./result_8chains/node411_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_6_2 -p 806 -st topic411_6_1 -pt None -u 0.005177590096065644 > ./result_8chains/node411_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_7_2 -p 822 -st topic411_7_1 -pt None -u 0.0035137881058707795 > ./result_8chains/node411_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_0 -p 52 -st none -pt topic411_0_0 -u 0.006785244791543965 > ./result_8chains/node411_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_0 -p 312 -st none -pt topic411_1_0 -u 0.0384194110313823 > ./result_8chains/node411_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_0 -p 387 -st none -pt topic411_2_0 -u 0.014584592949722863 > ./result_8chains/node411_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_0 -p 397 -st none -pt topic411_3_0 -u 0.03996610658971961 > ./result_8chains/node411_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_0 -p 551 -st none -pt topic411_4_0 -u 0.05956033530894514 > ./result_8chains/node411_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_0 -p 797 -st none -pt topic411_5_0 -u 0.0017906979086028674 > ./result_8chains/node411_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_6_0 -p 806 -st none -pt topic411_6_0 -u 0.014227165813774312 > ./result_8chains/node411_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_7_0 -p 822 -st none -pt topic411_7_0 -u 0.0015430741844996432 > ./result_8chains/node411_7_0.txt &
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
    "./result_8chains/node411_0_0.txt 90"
    "./result_8chains/node411_0_2.txt 90"
    "./result_8chains/node411_1_0.txt 89"
    "./result_8chains/node411_1_2.txt 89"
    "./result_8chains/node411_2_0.txt 88"
    "./result_8chains/node411_2_2.txt 88"
    "./result_8chains/node411_3_0.txt 87"
    "./result_8chains/node411_3_2.txt 87"
    "./result_8chains/node411_4_0.txt 86"
    "./result_8chains/node411_4_2.txt 86"
    "./result_8chains/node411_5_0.txt 85"
    "./result_8chains/node411_5_2.txt 85"
    "./result_8chains/node411_6_0.txt 84"
    "./result_8chains/node411_6_2.txt 84"
    "./result_8chains/node411_7_0.txt 83"
    "./result_8chains/node411_7_2.txt 83"
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
