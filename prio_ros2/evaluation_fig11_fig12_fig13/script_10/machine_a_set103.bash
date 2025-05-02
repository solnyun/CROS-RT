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
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_2 -p 37 -st topic103_0_1 -pt None -u 0.024803741927139522 > ./result_10chains/node103_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_2 -p 222 -st topic103_1_1 -pt None -u 0.0015953863868948814 > ./result_10chains/node103_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_2 -p 237 -st topic103_2_1 -pt None -u 0.0027213292571794945 > ./result_10chains/node103_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_2 -p 391 -st topic103_3_1 -pt None -u 0.06658391045993622 > ./result_10chains/node103_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_2 -p 466 -st topic103_4_1 -pt None -u 0.019938978708100963 > ./result_10chains/node103_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_2 -p 520 -st topic103_5_1 -pt None -u 0.021320917892127256 > ./result_10chains/node103_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_6_2 -p 588 -st topic103_6_1 -pt None -u 0.045947266764130024 > ./result_10chains/node103_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_7_2 -p 724 -st topic103_7_1 -pt None -u 0.0275418415701717 > ./result_10chains/node103_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_8_2 -p 902 -st topic103_8_1 -pt None -u 0.0417811269210496 > ./result_10chains/node103_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_9_2 -p 943 -st topic103_9_1 -pt None -u 0.00026896493170507866 > ./result_10chains/node103_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_0 -p 37 -st none -pt topic103_0_0 -u 0.0011076564293343028 > ./result_10chains/node103_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_0 -p 222 -st none -pt topic103_1_0 -u 0.010142638001508941 > ./result_10chains/node103_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_0 -p 237 -st none -pt topic103_2_0 -u 0.0001704693774360888 > ./result_10chains/node103_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_0 -p 391 -st none -pt topic103_3_0 -u 0.002020000364516883 > ./result_10chains/node103_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_0 -p 466 -st none -pt topic103_4_0 -u 0.013781702909773874 > ./result_10chains/node103_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_0 -p 520 -st none -pt topic103_5_0 -u 0.0018649639373628513 > ./result_10chains/node103_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_6_0 -p 588 -st none -pt topic103_6_0 -u 0.008291222505377005 > ./result_10chains/node103_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_7_0 -p 724 -st none -pt topic103_7_0 -u 0.026482215596559028 > ./result_10chains/node103_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_8_0 -p 902 -st none -pt topic103_8_0 -u 0.011201680585717175 > ./result_10chains/node103_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_9_0 -p 943 -st none -pt topic103_9_0 -u 0.011734316212161972 > ./result_10chains/node103_9_0.txt &
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
    "./result_10chains/node103_0_0.txt 90"
    "./result_10chains/node103_0_2.txt 90"
    "./result_10chains/node103_1_0.txt 89"
    "./result_10chains/node103_1_2.txt 89"
    "./result_10chains/node103_2_0.txt 88"
    "./result_10chains/node103_2_2.txt 88"
    "./result_10chains/node103_3_0.txt 87"
    "./result_10chains/node103_3_2.txt 87"
    "./result_10chains/node103_4_0.txt 86"
    "./result_10chains/node103_4_2.txt 86"
    "./result_10chains/node103_5_0.txt 85"
    "./result_10chains/node103_5_2.txt 85"
    "./result_10chains/node103_6_0.txt 84"
    "./result_10chains/node103_6_2.txt 84"
    "./result_10chains/node103_7_0.txt 83"
    "./result_10chains/node103_7_2.txt 83"
    "./result_10chains/node103_8_0.txt 82"
    "./result_10chains/node103_8_2.txt 82"
    "./result_10chains/node103_9_0.txt 81"
    "./result_10chains/node103_9_2.txt 81"
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
