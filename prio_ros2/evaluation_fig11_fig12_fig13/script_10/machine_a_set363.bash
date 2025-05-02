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
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_2 -p 50 -st topic363_0_1 -pt None -u 0.0021078508078322677 > ./result_10chains/node363_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_2 -p 107 -st topic363_1_1 -pt None -u 0.004812069316455225 > ./result_10chains/node363_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_2 -p 183 -st topic363_2_1 -pt None -u 0.01681443151873402 > ./result_10chains/node363_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_2 -p 305 -st topic363_3_1 -pt None -u 0.001078715800009289 > ./result_10chains/node363_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_2 -p 386 -st topic363_4_1 -pt None -u 0.046531821220805736 > ./result_10chains/node363_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_2 -p 395 -st topic363_5_1 -pt None -u 0.02972257626983134 > ./result_10chains/node363_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_6_2 -p 520 -st topic363_6_1 -pt None -u 0.00689179662606941 > ./result_10chains/node363_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_7_2 -p 589 -st topic363_7_1 -pt None -u 0.008828425223262812 > ./result_10chains/node363_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_8_2 -p 624 -st topic363_8_1 -pt None -u 0.012533431098094145 > ./result_10chains/node363_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_9_2 -p 676 -st topic363_9_1 -pt None -u 0.01353329043285148 > ./result_10chains/node363_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_0 -p 50 -st none -pt topic363_0_0 -u 0.0064314315573301695 > ./result_10chains/node363_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_0 -p 107 -st none -pt topic363_1_0 -u 0.015005695723949386 > ./result_10chains/node363_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_0 -p 183 -st none -pt topic363_2_0 -u 0.021873555596632566 > ./result_10chains/node363_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_0 -p 305 -st none -pt topic363_3_0 -u 0.04951187358163195 > ./result_10chains/node363_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_0 -p 386 -st none -pt topic363_4_0 -u 0.04437882857846687 > ./result_10chains/node363_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_0 -p 395 -st none -pt topic363_5_0 -u 0.007494235560422502 > ./result_10chains/node363_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_6_0 -p 520 -st none -pt topic363_6_0 -u 0.006284458055777015 > ./result_10chains/node363_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_7_0 -p 589 -st none -pt topic363_7_0 -u 0.00812083172499585 > ./result_10chains/node363_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_8_0 -p 624 -st none -pt topic363_8_0 -u 0.012662103307855957 > ./result_10chains/node363_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node363_9_0 -p 676 -st none -pt topic363_9_0 -u 0.007565381206534209 > ./result_10chains/node363_9_0.txt &
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
    "./result_10chains/node363_0_0.txt 90"
    "./result_10chains/node363_0_2.txt 90"
    "./result_10chains/node363_1_0.txt 89"
    "./result_10chains/node363_1_2.txt 89"
    "./result_10chains/node363_2_0.txt 88"
    "./result_10chains/node363_2_2.txt 88"
    "./result_10chains/node363_3_0.txt 87"
    "./result_10chains/node363_3_2.txt 87"
    "./result_10chains/node363_4_0.txt 86"
    "./result_10chains/node363_4_2.txt 86"
    "./result_10chains/node363_5_0.txt 85"
    "./result_10chains/node363_5_2.txt 85"
    "./result_10chains/node363_6_0.txt 84"
    "./result_10chains/node363_6_2.txt 84"
    "./result_10chains/node363_7_0.txt 83"
    "./result_10chains/node363_7_2.txt 83"
    "./result_10chains/node363_8_0.txt 82"
    "./result_10chains/node363_8_2.txt 82"
    "./result_10chains/node363_9_0.txt 81"
    "./result_10chains/node363_9_2.txt 81"
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
