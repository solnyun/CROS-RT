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
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_2 -p 60 -st topic191_0_1 -pt None -u 0.021386481006186064 > ./result_8chains/node191_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_2 -p 171 -st topic191_1_1 -pt None -u 0.01069961506126016 > ./result_8chains/node191_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_2 -p 541 -st topic191_2_1 -pt None -u 0.017932148004237536 > ./result_8chains/node191_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_2 -p 638 -st topic191_3_1 -pt None -u 0.005641389001771385 > ./result_8chains/node191_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_2 -p 639 -st topic191_4_1 -pt None -u 0.010091967131689694 > ./result_8chains/node191_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_2 -p 708 -st topic191_5_1 -pt None -u 0.015028988607390159 > ./result_8chains/node191_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_6_2 -p 806 -st topic191_6_1 -pt None -u 0.005408783404332929 > ./result_8chains/node191_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_7_2 -p 963 -st topic191_7_1 -pt None -u 0.04747046404229701 > ./result_8chains/node191_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_0 -p 60 -st none -pt topic191_0_0 -u 0.031760789990254834 > ./result_8chains/node191_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_0 -p 171 -st none -pt topic191_1_0 -u 0.07756559952801301 > ./result_8chains/node191_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_0 -p 541 -st none -pt topic191_2_0 -u 0.0036961968912423426 > ./result_8chains/node191_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_0 -p 638 -st none -pt topic191_3_0 -u 0.009336054622661294 > ./result_8chains/node191_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_0 -p 639 -st none -pt topic191_4_0 -u 0.004153613411934792 > ./result_8chains/node191_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_0 -p 708 -st none -pt topic191_5_0 -u 0.021029965396340167 > ./result_8chains/node191_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_6_0 -p 806 -st none -pt topic191_6_0 -u 0.03234079740251758 > ./result_8chains/node191_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_7_0 -p 963 -st none -pt topic191_7_0 -u 0.05085752443354935 > ./result_8chains/node191_7_0.txt &
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
    "./result_8chains/node191_0_0.txt 90"
    "./result_8chains/node191_0_2.txt 90"
    "./result_8chains/node191_1_0.txt 89"
    "./result_8chains/node191_1_2.txt 89"
    "./result_8chains/node191_2_0.txt 88"
    "./result_8chains/node191_2_2.txt 88"
    "./result_8chains/node191_3_0.txt 87"
    "./result_8chains/node191_3_2.txt 87"
    "./result_8chains/node191_4_0.txt 86"
    "./result_8chains/node191_4_2.txt 86"
    "./result_8chains/node191_5_0.txt 85"
    "./result_8chains/node191_5_2.txt 85"
    "./result_8chains/node191_6_0.txt 84"
    "./result_8chains/node191_6_2.txt 84"
    "./result_8chains/node191_7_0.txt 83"
    "./result_8chains/node191_7_2.txt 83"
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
