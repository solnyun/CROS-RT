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
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_2 -p 138 -st topic337_0_1 -pt None -u 0.02143196559554228 > ./result_6chains/node337_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_2 -p 222 -st topic337_1_1 -pt None -u 0.045659802453773324 > ./result_6chains/node337_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_2 -p 518 -st topic337_2_1 -pt None -u 0.021567463853644192 > ./result_6chains/node337_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_2 -p 629 -st topic337_3_1 -pt None -u 0.030343096631298305 > ./result_6chains/node337_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_2 -p 897 -st topic337_4_1 -pt None -u 0.05600133642914717 > ./result_6chains/node337_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_2 -p 985 -st topic337_5_1 -pt None -u 0.02921111366620626 > ./result_6chains/node337_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_0 -p 138 -st none -pt topic337_0_0 -u 0.015509400365722126 > ./result_6chains/node337_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_0 -p 222 -st none -pt topic337_1_0 -u 0.085507722636814 > ./result_6chains/node337_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_0 -p 518 -st none -pt topic337_2_0 -u 0.026010879449621438 > ./result_6chains/node337_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_0 -p 629 -st none -pt topic337_3_0 -u 0.006746556137666726 > ./result_6chains/node337_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_0 -p 897 -st none -pt topic337_4_0 -u 0.04481367473004086 > ./result_6chains/node337_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_0 -p 985 -st none -pt topic337_5_0 -u 0.01739051942591298 > ./result_6chains/node337_5_0.txt &
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
    "./result_6chains/node337_0_0.txt 90"
    "./result_6chains/node337_0_2.txt 90"
    "./result_6chains/node337_1_0.txt 89"
    "./result_6chains/node337_1_2.txt 89"
    "./result_6chains/node337_2_0.txt 88"
    "./result_6chains/node337_2_2.txt 88"
    "./result_6chains/node337_3_0.txt 87"
    "./result_6chains/node337_3_2.txt 87"
    "./result_6chains/node337_4_0.txt 86"
    "./result_6chains/node337_4_2.txt 86"
    "./result_6chains/node337_5_0.txt 85"
    "./result_6chains/node337_5_2.txt 85"
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
