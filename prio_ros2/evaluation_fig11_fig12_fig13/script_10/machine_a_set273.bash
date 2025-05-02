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
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_2 -p 90 -st topic273_0_1 -pt None -u 0.004314730627353269 > ./result_10chains/node273_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_2 -p 309 -st topic273_1_1 -pt None -u 0.002618903230395375 > ./result_10chains/node273_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_2 -p 409 -st topic273_2_1 -pt None -u 0.00285472463609604 > ./result_10chains/node273_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_2 -p 467 -st topic273_3_1 -pt None -u 0.01994534632469655 > ./result_10chains/node273_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_2 -p 475 -st topic273_4_1 -pt None -u 0.0589950014162805 > ./result_10chains/node273_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_2 -p 612 -st topic273_5_1 -pt None -u 0.009364682933030138 > ./result_10chains/node273_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_6_2 -p 674 -st topic273_6_1 -pt None -u 0.0002679101838249931 > ./result_10chains/node273_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_7_2 -p 784 -st topic273_7_1 -pt None -u 0.008006541462416084 > ./result_10chains/node273_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_8_2 -p 906 -st topic273_8_1 -pt None -u 0.01886166807675216 > ./result_10chains/node273_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_9_2 -p 942 -st topic273_9_1 -pt None -u 0.0021071462404471755 > ./result_10chains/node273_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_0_0 -p 90 -st none -pt topic273_0_0 -u 0.03889588835320351 > ./result_10chains/node273_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_1_0 -p 309 -st none -pt topic273_1_0 -u 0.0574653429377463 > ./result_10chains/node273_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_2_0 -p 409 -st none -pt topic273_2_0 -u 0.04736727518281886 > ./result_10chains/node273_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_3_0 -p 467 -st none -pt topic273_3_0 -u 0.01074232334589309 > ./result_10chains/node273_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_4_0 -p 475 -st none -pt topic273_4_0 -u 0.0009416492582873526 > ./result_10chains/node273_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_5_0 -p 612 -st none -pt topic273_5_0 -u 0.017977437559521497 > ./result_10chains/node273_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_6_0 -p 674 -st none -pt topic273_6_0 -u 0.004737802391898305 > ./result_10chains/node273_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_7_0 -p 784 -st none -pt topic273_7_0 -u 0.011510187343884745 > ./result_10chains/node273_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node273_8_0 -p 906 -st none -pt topic273_8_0 -u 0.0004379342427311139 > ./result_10chains/node273_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node273_9_0 -p 942 -st none -pt topic273_9_0 -u 0.059533469245164325 > ./result_10chains/node273_9_0.txt &
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
    "./result_10chains/node273_0_0.txt 90"
    "./result_10chains/node273_0_2.txt 90"
    "./result_10chains/node273_1_0.txt 89"
    "./result_10chains/node273_1_2.txt 89"
    "./result_10chains/node273_2_0.txt 88"
    "./result_10chains/node273_2_2.txt 88"
    "./result_10chains/node273_3_0.txt 87"
    "./result_10chains/node273_3_2.txt 87"
    "./result_10chains/node273_4_0.txt 86"
    "./result_10chains/node273_4_2.txt 86"
    "./result_10chains/node273_5_0.txt 85"
    "./result_10chains/node273_5_2.txt 85"
    "./result_10chains/node273_6_0.txt 84"
    "./result_10chains/node273_6_2.txt 84"
    "./result_10chains/node273_7_0.txt 83"
    "./result_10chains/node273_7_2.txt 83"
    "./result_10chains/node273_8_0.txt 82"
    "./result_10chains/node273_8_2.txt 82"
    "./result_10chains/node273_9_0.txt 81"
    "./result_10chains/node273_9_2.txt 81"
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
