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
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_2 -p 160 -st topic435_0_1 -pt None -u 0.0010530891377526497 > ./result_10chains/node435_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_2 -p 180 -st topic435_1_1 -pt None -u 0.006598806003054791 > ./result_10chains/node435_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_2 -p 228 -st topic435_2_1 -pt None -u 0.03508739762051749 > ./result_10chains/node435_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_2 -p 385 -st topic435_3_1 -pt None -u 0.004575574709263397 > ./result_10chains/node435_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_2 -p 467 -st topic435_4_1 -pt None -u 0.012393600297028629 > ./result_10chains/node435_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_2 -p 478 -st topic435_5_1 -pt None -u 0.01030782849146894 > ./result_10chains/node435_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_6_2 -p 649 -st topic435_6_1 -pt None -u 0.009204617876725663 > ./result_10chains/node435_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_7_2 -p 740 -st topic435_7_1 -pt None -u 0.014284617748775263 > ./result_10chains/node435_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_8_2 -p 914 -st topic435_8_1 -pt None -u 0.00376452788301692 > ./result_10chains/node435_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_9_2 -p 928 -st topic435_9_1 -pt None -u 0.015557957407321401 > ./result_10chains/node435_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_0 -p 160 -st none -pt topic435_0_0 -u 0.010411883589183157 > ./result_10chains/node435_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_0 -p 180 -st none -pt topic435_1_0 -u 0.014645773473473067 > ./result_10chains/node435_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_0 -p 228 -st none -pt topic435_2_0 -u 0.0031138962287118876 > ./result_10chains/node435_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_0 -p 385 -st none -pt topic435_3_0 -u 0.016429791159698226 > ./result_10chains/node435_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_0 -p 467 -st none -pt topic435_4_0 -u 0.012785568356142307 > ./result_10chains/node435_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_0 -p 478 -st none -pt topic435_5_0 -u 0.04590293312995941 > ./result_10chains/node435_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_6_0 -p 649 -st none -pt topic435_6_0 -u 0.0010114503056102564 > ./result_10chains/node435_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_7_0 -p 740 -st none -pt topic435_7_0 -u 0.05568963063670701 > ./result_10chains/node435_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_8_0 -p 914 -st none -pt topic435_8_0 -u 0.013408861937506886 > ./result_10chains/node435_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node435_9_0 -p 928 -st none -pt topic435_9_0 -u 0.018946010224331056 > ./result_10chains/node435_9_0.txt &
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
    "./result_10chains/node435_0_0.txt 90"
    "./result_10chains/node435_0_2.txt 90"
    "./result_10chains/node435_1_0.txt 89"
    "./result_10chains/node435_1_2.txt 89"
    "./result_10chains/node435_2_0.txt 88"
    "./result_10chains/node435_2_2.txt 88"
    "./result_10chains/node435_3_0.txt 87"
    "./result_10chains/node435_3_2.txt 87"
    "./result_10chains/node435_4_0.txt 86"
    "./result_10chains/node435_4_2.txt 86"
    "./result_10chains/node435_5_0.txt 85"
    "./result_10chains/node435_5_2.txt 85"
    "./result_10chains/node435_6_0.txt 84"
    "./result_10chains/node435_6_2.txt 84"
    "./result_10chains/node435_7_0.txt 83"
    "./result_10chains/node435_7_2.txt 83"
    "./result_10chains/node435_8_0.txt 82"
    "./result_10chains/node435_8_2.txt 82"
    "./result_10chains/node435_9_0.txt 81"
    "./result_10chains/node435_9_2.txt 81"
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
