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
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_2 -p 183 -st topic228_0_1 -pt None -u 0.011224987249905116 > ./result_8chains/node228_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_2 -p 468 -st topic228_1_1 -pt None -u 0.008784707906123457 > ./result_8chains/node228_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_2 -p 485 -st topic228_2_1 -pt None -u 0.06170553177322621 > ./result_8chains/node228_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_2 -p 502 -st topic228_3_1 -pt None -u 0.00021596302559767633 > ./result_8chains/node228_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_2 -p 676 -st topic228_4_1 -pt None -u 0.00022326963193972094 > ./result_8chains/node228_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_2 -p 739 -st topic228_5_1 -pt None -u 0.007879046183690439 > ./result_8chains/node228_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_6_2 -p 742 -st topic228_6_1 -pt None -u 0.009986735062323553 > ./result_8chains/node228_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_7_2 -p 744 -st topic228_7_1 -pt None -u 0.0018216136153589222 > ./result_8chains/node228_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_0_0 -p 183 -st none -pt topic228_0_0 -u 0.0063112334386059565 > ./result_8chains/node228_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_1_0 -p 468 -st none -pt topic228_1_0 -u 0.008939785437638958 > ./result_8chains/node228_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_2_0 -p 485 -st none -pt topic228_2_0 -u 0.0028112465712271106 > ./result_8chains/node228_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_3_0 -p 502 -st none -pt topic228_3_0 -u 0.04818377102741614 > ./result_8chains/node228_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_4_0 -p 676 -st none -pt topic228_4_0 -u 0.05651916966744608 > ./result_8chains/node228_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_5_0 -p 739 -st none -pt topic228_5_0 -u 0.019807252275878977 > ./result_8chains/node228_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node228_6_0 -p 742 -st none -pt topic228_6_0 -u 0.023020006719310808 > ./result_8chains/node228_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node228_7_0 -p 744 -st none -pt topic228_7_0 -u 0.0036086795034295806 > ./result_8chains/node228_7_0.txt &
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
    "./result_8chains/node228_0_0.txt 90"
    "./result_8chains/node228_0_2.txt 90"
    "./result_8chains/node228_1_0.txt 89"
    "./result_8chains/node228_1_2.txt 89"
    "./result_8chains/node228_2_0.txt 88"
    "./result_8chains/node228_2_2.txt 88"
    "./result_8chains/node228_3_0.txt 87"
    "./result_8chains/node228_3_2.txt 87"
    "./result_8chains/node228_4_0.txt 86"
    "./result_8chains/node228_4_2.txt 86"
    "./result_8chains/node228_5_0.txt 85"
    "./result_8chains/node228_5_2.txt 85"
    "./result_8chains/node228_6_0.txt 84"
    "./result_8chains/node228_6_2.txt 84"
    "./result_8chains/node228_7_0.txt 83"
    "./result_8chains/node228_7_2.txt 83"
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
