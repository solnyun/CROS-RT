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
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_2 -p 288 -st topic476_0_1 -pt None -u 0.0018715210480013122 > ./result_8chains/node476_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_2 -p 315 -st topic476_1_1 -pt None -u 0.0026266063704674103 > ./result_8chains/node476_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_2 -p 400 -st topic476_2_1 -pt None -u 0.036891694886076076 > ./result_8chains/node476_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_2 -p 524 -st topic476_3_1 -pt None -u 0.003942848114534547 > ./result_8chains/node476_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_2 -p 598 -st topic476_4_1 -pt None -u 0.038775640905707565 > ./result_8chains/node476_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_2 -p 789 -st topic476_5_1 -pt None -u 0.0095974257815033 > ./result_8chains/node476_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_6_2 -p 812 -st topic476_6_1 -pt None -u 0.01650774173716732 > ./result_8chains/node476_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_7_2 -p 872 -st topic476_7_1 -pt None -u 0.032844172261377674 > ./result_8chains/node476_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_0 -p 288 -st none -pt topic476_0_0 -u 0.028868319129594755 > ./result_8chains/node476_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_0 -p 315 -st none -pt topic476_1_0 -u 0.08925682937836898 > ./result_8chains/node476_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_0 -p 400 -st none -pt topic476_2_0 -u 0.011207597789743562 > ./result_8chains/node476_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_0 -p 524 -st none -pt topic476_3_0 -u 0.017172913915554422 > ./result_8chains/node476_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_0 -p 598 -st none -pt topic476_4_0 -u 0.004816261716183157 > ./result_8chains/node476_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_0 -p 789 -st none -pt topic476_5_0 -u 0.007993359237318448 > ./result_8chains/node476_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_6_0 -p 812 -st none -pt topic476_6_0 -u 0.046891180792876075 > ./result_8chains/node476_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_7_0 -p 872 -st none -pt topic476_7_0 -u 0.003061315439457979 > ./result_8chains/node476_7_0.txt &
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
    "./result_8chains/node476_0_0.txt 90"
    "./result_8chains/node476_0_2.txt 90"
    "./result_8chains/node476_1_0.txt 89"
    "./result_8chains/node476_1_2.txt 89"
    "./result_8chains/node476_2_0.txt 88"
    "./result_8chains/node476_2_2.txt 88"
    "./result_8chains/node476_3_0.txt 87"
    "./result_8chains/node476_3_2.txt 87"
    "./result_8chains/node476_4_0.txt 86"
    "./result_8chains/node476_4_2.txt 86"
    "./result_8chains/node476_5_0.txt 85"
    "./result_8chains/node476_5_2.txt 85"
    "./result_8chains/node476_6_0.txt 84"
    "./result_8chains/node476_6_2.txt 84"
    "./result_8chains/node476_7_0.txt 83"
    "./result_8chains/node476_7_2.txt 83"
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
