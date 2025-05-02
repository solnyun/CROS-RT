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
ros2 run evaluation_3_randomdag uunifast_node -n node113_0_2 -p 167 -st topic113_0_1 -pt None -u 0.0054208492834892374 > ./result_8chains/node113_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_1_2 -p 519 -st topic113_1_1 -pt None -u 0.02210319228330504 > ./result_8chains/node113_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_2_2 -p 586 -st topic113_2_1 -pt None -u 0.02828208301165408 > ./result_8chains/node113_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_3_2 -p 731 -st topic113_3_1 -pt None -u 0.03284116800146544 > ./result_8chains/node113_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_4_2 -p 751 -st topic113_4_1 -pt None -u 0.07645695846227374 > ./result_8chains/node113_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_5_2 -p 808 -st topic113_5_1 -pt None -u 0.0015718556477093831 > ./result_8chains/node113_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_6_2 -p 861 -st topic113_6_1 -pt None -u 0.012744684043813619 > ./result_8chains/node113_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_7_2 -p 931 -st topic113_7_1 -pt None -u 0.030348695171472963 > ./result_8chains/node113_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_0_0 -p 167 -st none -pt topic113_0_0 -u 0.005500968139004192 > ./result_8chains/node113_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_1_0 -p 519 -st none -pt topic113_1_0 -u 0.002343880134905274 > ./result_8chains/node113_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_2_0 -p 586 -st none -pt topic113_2_0 -u 0.01596433174564771 > ./result_8chains/node113_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_3_0 -p 731 -st none -pt topic113_3_0 -u 0.06788633287877185 > ./result_8chains/node113_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_4_0 -p 751 -st none -pt topic113_4_0 -u 0.0004981669729955396 > ./result_8chains/node113_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_5_0 -p 808 -st none -pt topic113_5_0 -u 0.03272047186555803 > ./result_8chains/node113_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_6_0 -p 861 -st none -pt topic113_6_0 -u 0.02378522940361432 > ./result_8chains/node113_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_7_0 -p 931 -st none -pt topic113_7_0 -u 0.005707859354344945 > ./result_8chains/node113_7_0.txt &
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
    "./result_8chains/node113_0_0.txt 90"
    "./result_8chains/node113_0_2.txt 90"
    "./result_8chains/node113_1_0.txt 89"
    "./result_8chains/node113_1_2.txt 89"
    "./result_8chains/node113_2_0.txt 88"
    "./result_8chains/node113_2_2.txt 88"
    "./result_8chains/node113_3_0.txt 87"
    "./result_8chains/node113_3_2.txt 87"
    "./result_8chains/node113_4_0.txt 86"
    "./result_8chains/node113_4_2.txt 86"
    "./result_8chains/node113_5_0.txt 85"
    "./result_8chains/node113_5_2.txt 85"
    "./result_8chains/node113_6_0.txt 84"
    "./result_8chains/node113_6_2.txt 84"
    "./result_8chains/node113_7_0.txt 83"
    "./result_8chains/node113_7_2.txt 83"
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
