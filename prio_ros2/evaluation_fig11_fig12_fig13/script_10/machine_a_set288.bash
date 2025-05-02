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
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_2 -p 85 -st topic288_0_1 -pt None -u 0.06049749725046555 > ./result_10chains/node288_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_2 -p 146 -st topic288_1_1 -pt None -u 0.03396947161936953 > ./result_10chains/node288_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_2 -p 284 -st topic288_2_1 -pt None -u 0.01470710493953864 > ./result_10chains/node288_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_2 -p 485 -st topic288_3_1 -pt None -u 0.001196466474966018 > ./result_10chains/node288_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_2 -p 518 -st topic288_4_1 -pt None -u 0.021880324705871312 > ./result_10chains/node288_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_2 -p 592 -st topic288_5_1 -pt None -u 0.013407673704590423 > ./result_10chains/node288_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_6_2 -p 657 -st topic288_6_1 -pt None -u 0.014304427973616307 > ./result_10chains/node288_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_7_2 -p 666 -st topic288_7_1 -pt None -u 0.016898387508533425 > ./result_10chains/node288_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_8_2 -p 921 -st topic288_8_1 -pt None -u 0.0535199709306281 > ./result_10chains/node288_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_9_2 -p 943 -st topic288_9_1 -pt None -u 0.06296990282535231 > ./result_10chains/node288_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_0 -p 85 -st none -pt topic288_0_0 -u 0.003722799290265477 > ./result_10chains/node288_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_0 -p 146 -st none -pt topic288_1_0 -u 0.0042653960273899005 > ./result_10chains/node288_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_0 -p 284 -st none -pt topic288_2_0 -u 0.0063565848103711575 > ./result_10chains/node288_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_0 -p 485 -st none -pt topic288_3_0 -u 0.008321589536577467 > ./result_10chains/node288_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_0 -p 518 -st none -pt topic288_4_0 -u 0.0049660295983842695 > ./result_10chains/node288_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_0 -p 592 -st none -pt topic288_5_0 -u 0.025939320020043566 > ./result_10chains/node288_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_6_0 -p 657 -st none -pt topic288_6_0 -u 0.003053564141998838 > ./result_10chains/node288_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_7_0 -p 666 -st none -pt topic288_7_0 -u 0.007093352736555925 > ./result_10chains/node288_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_8_0 -p 921 -st none -pt topic288_8_0 -u 0.028169590089894725 > ./result_10chains/node288_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_9_0 -p 943 -st none -pt topic288_9_0 -u 0.02419455019972397 > ./result_10chains/node288_9_0.txt &
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
    "./result_10chains/node288_0_0.txt 90"
    "./result_10chains/node288_0_2.txt 90"
    "./result_10chains/node288_1_0.txt 89"
    "./result_10chains/node288_1_2.txt 89"
    "./result_10chains/node288_2_0.txt 88"
    "./result_10chains/node288_2_2.txt 88"
    "./result_10chains/node288_3_0.txt 87"
    "./result_10chains/node288_3_2.txt 87"
    "./result_10chains/node288_4_0.txt 86"
    "./result_10chains/node288_4_2.txt 86"
    "./result_10chains/node288_5_0.txt 85"
    "./result_10chains/node288_5_2.txt 85"
    "./result_10chains/node288_6_0.txt 84"
    "./result_10chains/node288_6_2.txt 84"
    "./result_10chains/node288_7_0.txt 83"
    "./result_10chains/node288_7_2.txt 83"
    "./result_10chains/node288_8_0.txt 82"
    "./result_10chains/node288_8_2.txt 82"
    "./result_10chains/node288_9_0.txt 81"
    "./result_10chains/node288_9_2.txt 81"
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
