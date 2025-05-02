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
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_2 -p 34 -st topic389_0_1 -pt None -u 0.005781815761428222 > ./result_6chains/node389_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_2 -p 108 -st topic389_1_1 -pt None -u 0.046288755839755724 > ./result_6chains/node389_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_2 -p 388 -st topic389_2_1 -pt None -u 0.02237208827066625 > ./result_6chains/node389_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_2 -p 399 -st topic389_3_1 -pt None -u 0.009916626102981135 > ./result_6chains/node389_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_2 -p 412 -st topic389_4_1 -pt None -u 0.00825409694158001 > ./result_6chains/node389_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_2 -p 921 -st topic389_5_1 -pt None -u 0.024879547216864802 > ./result_6chains/node389_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_0 -p 34 -st none -pt topic389_0_0 -u 0.010206845527248598 > ./result_6chains/node389_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_0 -p 108 -st none -pt topic389_1_0 -u 0.10624028742821251 > ./result_6chains/node389_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_0 -p 388 -st none -pt topic389_2_0 -u 0.04211978391164256 > ./result_6chains/node389_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_0 -p 399 -st none -pt topic389_3_0 -u 0.07818325357256933 > ./result_6chains/node389_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_0 -p 412 -st none -pt topic389_4_0 -u 0.02108679050566463 > ./result_6chains/node389_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_0 -p 921 -st none -pt topic389_5_0 -u 0.07553602504872131 > ./result_6chains/node389_5_0.txt &
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
    "./result_6chains/node389_0_0.txt 90"
    "./result_6chains/node389_0_2.txt 90"
    "./result_6chains/node389_1_0.txt 89"
    "./result_6chains/node389_1_2.txt 89"
    "./result_6chains/node389_2_0.txt 88"
    "./result_6chains/node389_2_2.txt 88"
    "./result_6chains/node389_3_0.txt 87"
    "./result_6chains/node389_3_2.txt 87"
    "./result_6chains/node389_4_0.txt 86"
    "./result_6chains/node389_4_2.txt 86"
    "./result_6chains/node389_5_0.txt 85"
    "./result_6chains/node389_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
