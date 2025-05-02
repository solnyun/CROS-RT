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
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_2 -p 13 -st topic442_0_1 -pt None -u 0.012667520251894382 > ./result_8chains/node442_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_2 -p 19 -st topic442_1_1 -pt None -u 0.0077102894996951 > ./result_8chains/node442_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_2 -p 180 -st topic442_2_1 -pt None -u 0.006358342868128697 > ./result_8chains/node442_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_2 -p 281 -st topic442_3_1 -pt None -u 0.01008021524334779 > ./result_8chains/node442_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_2 -p 468 -st topic442_4_1 -pt None -u 0.007746518572826766 > ./result_8chains/node442_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_2 -p 492 -st topic442_5_1 -pt None -u 0.02916274039557211 > ./result_8chains/node442_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_6_2 -p 678 -st topic442_6_1 -pt None -u 0.06667003690319737 > ./result_8chains/node442_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_7_2 -p 809 -st topic442_7_1 -pt None -u 0.004762285526178198 > ./result_8chains/node442_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_0 -p 13 -st none -pt topic442_0_0 -u 0.04607521372991569 > ./result_8chains/node442_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_0 -p 19 -st none -pt topic442_1_0 -u 0.0474874085922517 > ./result_8chains/node442_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_0 -p 180 -st none -pt topic442_2_0 -u 0.012036658617295526 > ./result_8chains/node442_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_0 -p 281 -st none -pt topic442_3_0 -u 0.024428664352316 > ./result_8chains/node442_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_0 -p 468 -st none -pt topic442_4_0 -u 0.008006080282507766 > ./result_8chains/node442_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_0 -p 492 -st none -pt topic442_5_0 -u 0.03848758181398085 > ./result_8chains/node442_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_6_0 -p 678 -st none -pt topic442_6_0 -u 0.015391891792288073 > ./result_8chains/node442_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_7_0 -p 809 -st none -pt topic442_7_0 -u 0.006982232270746822 > ./result_8chains/node442_7_0.txt &
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
    "./result_8chains/node442_0_0.txt 90"
    "./result_8chains/node442_0_2.txt 90"
    "./result_8chains/node442_1_0.txt 89"
    "./result_8chains/node442_1_2.txt 89"
    "./result_8chains/node442_2_0.txt 88"
    "./result_8chains/node442_2_2.txt 88"
    "./result_8chains/node442_3_0.txt 87"
    "./result_8chains/node442_3_2.txt 87"
    "./result_8chains/node442_4_0.txt 86"
    "./result_8chains/node442_4_2.txt 86"
    "./result_8chains/node442_5_0.txt 85"
    "./result_8chains/node442_5_2.txt 85"
    "./result_8chains/node442_6_0.txt 84"
    "./result_8chains/node442_6_2.txt 84"
    "./result_8chains/node442_7_0.txt 83"
    "./result_8chains/node442_7_2.txt 83"
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
