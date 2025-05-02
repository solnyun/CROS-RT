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
ros2 run evaluation_3_randomdag uunifast_node -n node174_0_2 -p 50 -st topic174_0_1 -pt None -u 0.003321644970739779 > ./result_10chains/node174_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_1_2 -p 74 -st topic174_1_1 -pt None -u 0.010613920736608162 > ./result_10chains/node174_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_2_2 -p 98 -st topic174_2_1 -pt None -u 0.02891223251699021 > ./result_10chains/node174_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_3_2 -p 175 -st topic174_3_1 -pt None -u 0.05374253442899074 > ./result_10chains/node174_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_4_2 -p 265 -st topic174_4_1 -pt None -u 0.03485495967112784 > ./result_10chains/node174_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_5_2 -p 417 -st topic174_5_1 -pt None -u 0.021398174901697625 > ./result_10chains/node174_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_6_2 -p 521 -st topic174_6_1 -pt None -u 0.01739530569992065 > ./result_10chains/node174_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_7_2 -p 662 -st topic174_7_1 -pt None -u 0.03686925443698347 > ./result_10chains/node174_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_8_2 -p 689 -st topic174_8_1 -pt None -u 0.01967572505915447 > ./result_10chains/node174_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_9_2 -p 725 -st topic174_9_1 -pt None -u 0.008550255180988562 > ./result_10chains/node174_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_0_0 -p 50 -st none -pt topic174_0_0 -u 0.001014789926606141 > ./result_10chains/node174_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_1_0 -p 74 -st none -pt topic174_1_0 -u 0.013297401050852642 > ./result_10chains/node174_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_2_0 -p 98 -st none -pt topic174_2_0 -u 0.007227996352836108 > ./result_10chains/node174_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_3_0 -p 175 -st none -pt topic174_3_0 -u 0.04247283616166131 > ./result_10chains/node174_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_4_0 -p 265 -st none -pt topic174_4_0 -u 0.004776635126281736 > ./result_10chains/node174_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_5_0 -p 417 -st none -pt topic174_5_0 -u 0.017459619000321613 > ./result_10chains/node174_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_6_0 -p 521 -st none -pt topic174_6_0 -u 0.011630637117603038 > ./result_10chains/node174_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_7_0 -p 662 -st none -pt topic174_7_0 -u 0.06919261512085167 > ./result_10chains/node174_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_8_0 -p 689 -st none -pt topic174_8_0 -u 0.028614399030375298 > ./result_10chains/node174_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node174_9_0 -p 725 -st none -pt topic174_9_0 -u 0.010978788355687016 > ./result_10chains/node174_9_0.txt &
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
    "./result_10chains/node174_0_0.txt 90"
    "./result_10chains/node174_0_2.txt 90"
    "./result_10chains/node174_1_0.txt 89"
    "./result_10chains/node174_1_2.txt 89"
    "./result_10chains/node174_2_0.txt 88"
    "./result_10chains/node174_2_2.txt 88"
    "./result_10chains/node174_3_0.txt 87"
    "./result_10chains/node174_3_2.txt 87"
    "./result_10chains/node174_4_0.txt 86"
    "./result_10chains/node174_4_2.txt 86"
    "./result_10chains/node174_5_0.txt 85"
    "./result_10chains/node174_5_2.txt 85"
    "./result_10chains/node174_6_0.txt 84"
    "./result_10chains/node174_6_2.txt 84"
    "./result_10chains/node174_7_0.txt 83"
    "./result_10chains/node174_7_2.txt 83"
    "./result_10chains/node174_8_0.txt 82"
    "./result_10chains/node174_8_2.txt 82"
    "./result_10chains/node174_9_0.txt 81"
    "./result_10chains/node174_9_2.txt 81"
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
