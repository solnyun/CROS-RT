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
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_2 -p 71 -st topic214_0_1 -pt None -u 0.07735145758450396 > ./result_8chains/node214_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_2 -p 325 -st topic214_1_1 -pt None -u 0.002323196027469221 > ./result_8chains/node214_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_2 -p 360 -st topic214_2_1 -pt None -u 0.015140343759147246 > ./result_8chains/node214_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_2 -p 530 -st topic214_3_1 -pt None -u 0.013969017937552508 > ./result_8chains/node214_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_2 -p 641 -st topic214_4_1 -pt None -u 0.061102494527488616 > ./result_8chains/node214_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_2 -p 682 -st topic214_5_1 -pt None -u 0.030764147645808426 > ./result_8chains/node214_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_6_2 -p 686 -st topic214_6_1 -pt None -u 0.021641362992099157 > ./result_8chains/node214_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_7_2 -p 993 -st topic214_7_1 -pt None -u 0.0372860109154371 > ./result_8chains/node214_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_0 -p 71 -st none -pt topic214_0_0 -u 0.0023601609076809305 > ./result_8chains/node214_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_0 -p 325 -st none -pt topic214_1_0 -u 0.008512066953039854 > ./result_8chains/node214_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_0 -p 360 -st none -pt topic214_2_0 -u 0.02829284969649215 > ./result_8chains/node214_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_0 -p 530 -st none -pt topic214_3_0 -u 0.00019192412007246196 > ./result_8chains/node214_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_0 -p 641 -st none -pt topic214_4_0 -u 0.005322239368431014 > ./result_8chains/node214_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_0 -p 682 -st none -pt topic214_5_0 -u 0.0294177311084175 > ./result_8chains/node214_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_6_0 -p 686 -st none -pt topic214_6_0 -u 0.037678961529200194 > ./result_8chains/node214_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_7_0 -p 993 -st none -pt topic214_7_0 -u 0.0029666990646396163 > ./result_8chains/node214_7_0.txt &
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
    "./result_8chains/node214_0_0.txt 90"
    "./result_8chains/node214_0_2.txt 90"
    "./result_8chains/node214_1_0.txt 89"
    "./result_8chains/node214_1_2.txt 89"
    "./result_8chains/node214_2_0.txt 88"
    "./result_8chains/node214_2_2.txt 88"
    "./result_8chains/node214_3_0.txt 87"
    "./result_8chains/node214_3_2.txt 87"
    "./result_8chains/node214_4_0.txt 86"
    "./result_8chains/node214_4_2.txt 86"
    "./result_8chains/node214_5_0.txt 85"
    "./result_8chains/node214_5_2.txt 85"
    "./result_8chains/node214_6_0.txt 84"
    "./result_8chains/node214_6_2.txt 84"
    "./result_8chains/node214_7_0.txt 83"
    "./result_8chains/node214_7_2.txt 83"
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
