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
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_2 -p 44 -st topic319_0_1 -pt None -u 0.05626375126058453 > ./result_8chains/node319_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_2 -p 60 -st topic319_1_1 -pt None -u 0.034089170298452764 > ./result_8chains/node319_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_2 -p 250 -st topic319_2_1 -pt None -u 0.043881082131309534 > ./result_8chains/node319_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_2 -p 329 -st topic319_3_1 -pt None -u 0.0008024391800377784 > ./result_8chains/node319_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_2 -p 461 -st topic319_4_1 -pt None -u 0.032943378776862736 > ./result_8chains/node319_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_2 -p 602 -st topic319_5_1 -pt None -u 0.02039893243459967 > ./result_8chains/node319_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_6_2 -p 691 -st topic319_6_1 -pt None -u 0.045376420640600684 > ./result_8chains/node319_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_7_2 -p 999 -st topic319_7_1 -pt None -u 0.0167952828725993 > ./result_8chains/node319_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_0_0 -p 44 -st none -pt topic319_0_0 -u 0.019213507899727866 > ./result_8chains/node319_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_1_0 -p 60 -st none -pt topic319_1_0 -u 0.04752367864580076 > ./result_8chains/node319_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_2_0 -p 250 -st none -pt topic319_2_0 -u 0.0036625647321433807 > ./result_8chains/node319_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_3_0 -p 329 -st none -pt topic319_3_0 -u 0.010407315199057021 > ./result_8chains/node319_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_4_0 -p 461 -st none -pt topic319_4_0 -u 0.02540828229383285 > ./result_8chains/node319_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_5_0 -p 602 -st none -pt topic319_5_0 -u 0.006392932540955576 > ./result_8chains/node319_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node319_6_0 -p 691 -st none -pt topic319_6_0 -u 0.018096391691514085 > ./result_8chains/node319_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node319_7_0 -p 999 -st none -pt topic319_7_0 -u 0.04258845756358655 > ./result_8chains/node319_7_0.txt &
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
    "./result_8chains/node319_0_0.txt 90"
    "./result_8chains/node319_0_2.txt 90"
    "./result_8chains/node319_1_0.txt 89"
    "./result_8chains/node319_1_2.txt 89"
    "./result_8chains/node319_2_0.txt 88"
    "./result_8chains/node319_2_2.txt 88"
    "./result_8chains/node319_3_0.txt 87"
    "./result_8chains/node319_3_2.txt 87"
    "./result_8chains/node319_4_0.txt 86"
    "./result_8chains/node319_4_2.txt 86"
    "./result_8chains/node319_5_0.txt 85"
    "./result_8chains/node319_5_2.txt 85"
    "./result_8chains/node319_6_0.txt 84"
    "./result_8chains/node319_6_2.txt 84"
    "./result_8chains/node319_7_0.txt 83"
    "./result_8chains/node319_7_2.txt 83"
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
