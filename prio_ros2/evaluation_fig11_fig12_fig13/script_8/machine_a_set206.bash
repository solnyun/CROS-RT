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
ros2 run evaluation_3_randomdag uunifast_node -n node206_0_2 -p 248 -st topic206_0_1 -pt None -u 0.013455178078573937 > ./result_8chains/node206_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_1_2 -p 430 -st topic206_1_1 -pt None -u 0.016152577456878536 > ./result_8chains/node206_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_2_2 -p 446 -st topic206_2_1 -pt None -u 0.032846251688661204 > ./result_8chains/node206_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_3_2 -p 484 -st topic206_3_1 -pt None -u 0.02360892714143667 > ./result_8chains/node206_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_4_2 -p 538 -st topic206_4_1 -pt None -u 0.006586151593741235 > ./result_8chains/node206_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_5_2 -p 556 -st topic206_5_1 -pt None -u 0.013199099257313274 > ./result_8chains/node206_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_6_2 -p 627 -st topic206_6_1 -pt None -u 0.01682670671233749 > ./result_8chains/node206_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_7_2 -p 684 -st topic206_7_1 -pt None -u 0.056242347451251375 > ./result_8chains/node206_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_0_0 -p 248 -st none -pt topic206_0_0 -u 0.04377542148438107 > ./result_8chains/node206_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_1_0 -p 430 -st none -pt topic206_1_0 -u 0.012078705112517019 > ./result_8chains/node206_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_2_0 -p 446 -st none -pt topic206_2_0 -u 0.04617139842816148 > ./result_8chains/node206_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_3_0 -p 484 -st none -pt topic206_3_0 -u 0.0035420337626022314 > ./result_8chains/node206_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_4_0 -p 538 -st none -pt topic206_4_0 -u 0.005893309906682992 > ./result_8chains/node206_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_5_0 -p 556 -st none -pt topic206_5_0 -u 0.03608501780851389 > ./result_8chains/node206_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node206_6_0 -p 627 -st none -pt topic206_6_0 -u 0.015945279014515326 > ./result_8chains/node206_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node206_7_0 -p 684 -st none -pt topic206_7_0 -u 0.002842215864675257 > ./result_8chains/node206_7_0.txt &
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
    "./result_8chains/node206_0_0.txt 90"
    "./result_8chains/node206_0_2.txt 90"
    "./result_8chains/node206_1_0.txt 89"
    "./result_8chains/node206_1_2.txt 89"
    "./result_8chains/node206_2_0.txt 88"
    "./result_8chains/node206_2_2.txt 88"
    "./result_8chains/node206_3_0.txt 87"
    "./result_8chains/node206_3_2.txt 87"
    "./result_8chains/node206_4_0.txt 86"
    "./result_8chains/node206_4_2.txt 86"
    "./result_8chains/node206_5_0.txt 85"
    "./result_8chains/node206_5_2.txt 85"
    "./result_8chains/node206_6_0.txt 84"
    "./result_8chains/node206_6_2.txt 84"
    "./result_8chains/node206_7_0.txt 83"
    "./result_8chains/node206_7_2.txt 83"
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
