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
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_2 -p 43 -st topic217_0_1 -pt None -u 0.013446698911090627 > ./result_8chains/node217_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_2 -p 124 -st topic217_1_1 -pt None -u 0.0048094708651071905 > ./result_8chains/node217_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_2 -p 359 -st topic217_2_1 -pt None -u 0.007636007906262954 > ./result_8chains/node217_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_2 -p 512 -st topic217_3_1 -pt None -u 0.020003240504168185 > ./result_8chains/node217_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_2 -p 627 -st topic217_4_1 -pt None -u 0.005162844627197349 > ./result_8chains/node217_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_2 -p 687 -st topic217_5_1 -pt None -u 0.014612254803949953 > ./result_8chains/node217_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_6_2 -p 841 -st topic217_6_1 -pt None -u 0.008182651182322004 > ./result_8chains/node217_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_7_2 -p 916 -st topic217_7_1 -pt None -u 0.021021362495312165 > ./result_8chains/node217_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_0 -p 43 -st none -pt topic217_0_0 -u 0.0046942090958186355 > ./result_8chains/node217_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_0 -p 124 -st none -pt topic217_1_0 -u 0.008553850569318233 > ./result_8chains/node217_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_0 -p 359 -st none -pt topic217_2_0 -u 0.011397950601185203 > ./result_8chains/node217_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_0 -p 512 -st none -pt topic217_3_0 -u 0.0074779750999535155 > ./result_8chains/node217_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_0 -p 627 -st none -pt topic217_4_0 -u 0.018194461599122913 > ./result_8chains/node217_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_0 -p 687 -st none -pt topic217_5_0 -u 0.032116592538655786 > ./result_8chains/node217_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_6_0 -p 841 -st none -pt topic217_6_0 -u 0.010785736062008916 > ./result_8chains/node217_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_7_0 -p 916 -st none -pt topic217_7_0 -u 0.13075165394601376 > ./result_8chains/node217_7_0.txt &
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
    "./result_8chains/node217_0_0.txt 90"
    "./result_8chains/node217_0_2.txt 90"
    "./result_8chains/node217_1_0.txt 89"
    "./result_8chains/node217_1_2.txt 89"
    "./result_8chains/node217_2_0.txt 88"
    "./result_8chains/node217_2_2.txt 88"
    "./result_8chains/node217_3_0.txt 87"
    "./result_8chains/node217_3_2.txt 87"
    "./result_8chains/node217_4_0.txt 86"
    "./result_8chains/node217_4_2.txt 86"
    "./result_8chains/node217_5_0.txt 85"
    "./result_8chains/node217_5_2.txt 85"
    "./result_8chains/node217_6_0.txt 84"
    "./result_8chains/node217_6_2.txt 84"
    "./result_8chains/node217_7_0.txt 83"
    "./result_8chains/node217_7_2.txt 83"
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
