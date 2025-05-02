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
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_2 -p 110 -st topic77_0_1 -pt None -u 0.003940944324787143 > ./result_8chains/node77_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_2 -p 249 -st topic77_1_1 -pt None -u 0.006074260208677296 > ./result_8chains/node77_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_2 -p 277 -st topic77_2_1 -pt None -u 0.02702109372638395 > ./result_8chains/node77_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_2 -p 293 -st topic77_3_1 -pt None -u 0.040692841636124855 > ./result_8chains/node77_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_2 -p 330 -st topic77_4_1 -pt None -u 0.003058704405673185 > ./result_8chains/node77_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_2 -p 744 -st topic77_5_1 -pt None -u 0.03456999285357894 > ./result_8chains/node77_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_6_2 -p 747 -st topic77_6_1 -pt None -u 0.0063446570703434985 > ./result_8chains/node77_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_7_2 -p 921 -st topic77_7_1 -pt None -u 0.0018044335185479039 > ./result_8chains/node77_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_0 -p 110 -st none -pt topic77_0_0 -u 0.0037619345421924244 > ./result_8chains/node77_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_0 -p 249 -st none -pt topic77_1_0 -u 0.03227519934452927 > ./result_8chains/node77_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_0 -p 277 -st none -pt topic77_2_0 -u 0.0390012592708478 > ./result_8chains/node77_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_0 -p 293 -st none -pt topic77_3_0 -u 0.005118601185300664 > ./result_8chains/node77_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_0 -p 330 -st none -pt topic77_4_0 -u 0.004771749400793002 > ./result_8chains/node77_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_0 -p 744 -st none -pt topic77_5_0 -u 0.019445702564659467 > ./result_8chains/node77_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_6_0 -p 747 -st none -pt topic77_6_0 -u 0.0011833606451965434 > ./result_8chains/node77_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_7_0 -p 921 -st none -pt topic77_7_0 -u 0.011180417387827442 > ./result_8chains/node77_7_0.txt &
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
    "./result_8chains/node77_0_0.txt 90"
    "./result_8chains/node77_0_2.txt 90"
    "./result_8chains/node77_1_0.txt 89"
    "./result_8chains/node77_1_2.txt 89"
    "./result_8chains/node77_2_0.txt 88"
    "./result_8chains/node77_2_2.txt 88"
    "./result_8chains/node77_3_0.txt 87"
    "./result_8chains/node77_3_2.txt 87"
    "./result_8chains/node77_4_0.txt 86"
    "./result_8chains/node77_4_2.txt 86"
    "./result_8chains/node77_5_0.txt 85"
    "./result_8chains/node77_5_2.txt 85"
    "./result_8chains/node77_6_0.txt 84"
    "./result_8chains/node77_6_2.txt 84"
    "./result_8chains/node77_7_0.txt 83"
    "./result_8chains/node77_7_2.txt 83"
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
