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
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_2 -p 224 -st topic199_0_1 -pt None -u 0.003620685486190822 > ./result_10chains/node199_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_2 -p 297 -st topic199_1_1 -pt None -u 0.01796884643876795 > ./result_10chains/node199_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_2 -p 355 -st topic199_2_1 -pt None -u 0.004644558666899445 > ./result_10chains/node199_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_2 -p 378 -st topic199_3_1 -pt None -u 0.0014778999315489538 > ./result_10chains/node199_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_2 -p 525 -st topic199_4_1 -pt None -u 0.0026668722556868196 > ./result_10chains/node199_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_2 -p 546 -st topic199_5_1 -pt None -u 0.007901274046487411 > ./result_10chains/node199_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_6_2 -p 578 -st topic199_6_1 -pt None -u 0.04193150181186078 > ./result_10chains/node199_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_7_2 -p 756 -st topic199_7_1 -pt None -u 0.017377013606945838 > ./result_10chains/node199_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_8_2 -p 856 -st topic199_8_1 -pt None -u 0.003387605536155913 > ./result_10chains/node199_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_9_2 -p 916 -st topic199_9_1 -pt None -u 0.001953342575252646 > ./result_10chains/node199_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_0 -p 224 -st none -pt topic199_0_0 -u 0.019450538160071307 > ./result_10chains/node199_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_0 -p 297 -st none -pt topic199_1_0 -u 0.024178997764091437 > ./result_10chains/node199_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_0 -p 355 -st none -pt topic199_2_0 -u 0.03798675859749029 > ./result_10chains/node199_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_0 -p 378 -st none -pt topic199_3_0 -u 0.010824124605874175 > ./result_10chains/node199_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_0 -p 525 -st none -pt topic199_4_0 -u 0.021463569553198003 > ./result_10chains/node199_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_0 -p 546 -st none -pt topic199_5_0 -u 0.014920700603950204 > ./result_10chains/node199_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_6_0 -p 578 -st none -pt topic199_6_0 -u 0.008308429776183679 > ./result_10chains/node199_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_7_0 -p 756 -st none -pt topic199_7_0 -u 0.017946010553037656 > ./result_10chains/node199_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_8_0 -p 856 -st none -pt topic199_8_0 -u 0.041354153953079384 > ./result_10chains/node199_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node199_9_0 -p 916 -st none -pt topic199_9_0 -u 0.00349976929831481 > ./result_10chains/node199_9_0.txt &
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
    "./result_10chains/node199_0_0.txt 90"
    "./result_10chains/node199_0_2.txt 90"
    "./result_10chains/node199_1_0.txt 89"
    "./result_10chains/node199_1_2.txt 89"
    "./result_10chains/node199_2_0.txt 88"
    "./result_10chains/node199_2_2.txt 88"
    "./result_10chains/node199_3_0.txt 87"
    "./result_10chains/node199_3_2.txt 87"
    "./result_10chains/node199_4_0.txt 86"
    "./result_10chains/node199_4_2.txt 86"
    "./result_10chains/node199_5_0.txt 85"
    "./result_10chains/node199_5_2.txt 85"
    "./result_10chains/node199_6_0.txt 84"
    "./result_10chains/node199_6_2.txt 84"
    "./result_10chains/node199_7_0.txt 83"
    "./result_10chains/node199_7_2.txt 83"
    "./result_10chains/node199_8_0.txt 82"
    "./result_10chains/node199_8_2.txt 82"
    "./result_10chains/node199_9_0.txt 81"
    "./result_10chains/node199_9_2.txt 81"
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
