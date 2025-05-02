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
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_2 -p 236 -st topic371_0_1 -pt None -u 0.017602134299803618 > ./result_10chains/node371_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_2 -p 241 -st topic371_1_1 -pt None -u 0.022186088331470066 > ./result_10chains/node371_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_2 -p 532 -st topic371_2_1 -pt None -u 0.004886971625962522 > ./result_10chains/node371_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_2 -p 535 -st topic371_3_1 -pt None -u 0.07114159476956905 > ./result_10chains/node371_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_2 -p 542 -st topic371_4_1 -pt None -u 0.02980196058875434 > ./result_10chains/node371_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_2 -p 599 -st topic371_5_1 -pt None -u 0.009972997884579393 > ./result_10chains/node371_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_6_2 -p 687 -st topic371_6_1 -pt None -u 0.031323986858977 > ./result_10chains/node371_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_7_2 -p 766 -st topic371_7_1 -pt None -u 0.04171735440568192 > ./result_10chains/node371_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_8_2 -p 894 -st topic371_8_1 -pt None -u 0.013877515297264924 > ./result_10chains/node371_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_9_2 -p 911 -st topic371_9_1 -pt None -u 0.005431564924272643 > ./result_10chains/node371_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_0 -p 236 -st none -pt topic371_0_0 -u 0.013016373765835587 > ./result_10chains/node371_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_0 -p 241 -st none -pt topic371_1_0 -u 0.006904854705462926 > ./result_10chains/node371_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_0 -p 532 -st none -pt topic371_2_0 -u 0.03314921539797416 > ./result_10chains/node371_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_0 -p 535 -st none -pt topic371_3_0 -u 0.0011769741124606492 > ./result_10chains/node371_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_0 -p 542 -st none -pt topic371_4_0 -u 0.007033509051229181 > ./result_10chains/node371_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_0 -p 599 -st none -pt topic371_5_0 -u 0.01445862927327124 > ./result_10chains/node371_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_6_0 -p 687 -st none -pt topic371_6_0 -u 0.05367162117752314 > ./result_10chains/node371_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_7_0 -p 766 -st none -pt topic371_7_0 -u 5.8527716781081596e-05 > ./result_10chains/node371_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_8_0 -p 894 -st none -pt topic371_8_0 -u 0.0004024846520118905 > ./result_10chains/node371_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_9_0 -p 911 -st none -pt topic371_9_0 -u 0.009659578561216834 > ./result_10chains/node371_9_0.txt &
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
    "./result_10chains/node371_0_0.txt 90"
    "./result_10chains/node371_0_2.txt 90"
    "./result_10chains/node371_1_0.txt 89"
    "./result_10chains/node371_1_2.txt 89"
    "./result_10chains/node371_2_0.txt 88"
    "./result_10chains/node371_2_2.txt 88"
    "./result_10chains/node371_3_0.txt 87"
    "./result_10chains/node371_3_2.txt 87"
    "./result_10chains/node371_4_0.txt 86"
    "./result_10chains/node371_4_2.txt 86"
    "./result_10chains/node371_5_0.txt 85"
    "./result_10chains/node371_5_2.txt 85"
    "./result_10chains/node371_6_0.txt 84"
    "./result_10chains/node371_6_2.txt 84"
    "./result_10chains/node371_7_0.txt 83"
    "./result_10chains/node371_7_2.txt 83"
    "./result_10chains/node371_8_0.txt 82"
    "./result_10chains/node371_8_2.txt 82"
    "./result_10chains/node371_9_0.txt 81"
    "./result_10chains/node371_9_2.txt 81"
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
