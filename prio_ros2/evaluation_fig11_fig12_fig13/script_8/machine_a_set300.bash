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
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_2 -p 274 -st topic300_0_1 -pt None -u 0.004581281532283543 > ./result_8chains/node300_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_2 -p 389 -st topic300_1_1 -pt None -u 0.011060027251083404 > ./result_8chains/node300_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_2 -p 563 -st topic300_2_1 -pt None -u 0.020758040570111047 > ./result_8chains/node300_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_2 -p 719 -st topic300_3_1 -pt None -u 0.0053852172073784454 > ./result_8chains/node300_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_2 -p 756 -st topic300_4_1 -pt None -u 0.0006193634727336139 > ./result_8chains/node300_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_2 -p 811 -st topic300_5_1 -pt None -u 0.0018803793918183154 > ./result_8chains/node300_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_6_2 -p 868 -st topic300_6_1 -pt None -u 0.06483025696711564 > ./result_8chains/node300_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_7_2 -p 961 -st topic300_7_1 -pt None -u 0.1177299786364187 > ./result_8chains/node300_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_0_0 -p 274 -st none -pt topic300_0_0 -u 0.006779492375393048 > ./result_8chains/node300_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_1_0 -p 389 -st none -pt topic300_1_0 -u 0.01423818834166718 > ./result_8chains/node300_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_2_0 -p 563 -st none -pt topic300_2_0 -u 0.013996410753843613 > ./result_8chains/node300_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_3_0 -p 719 -st none -pt topic300_3_0 -u 0.027364978476691892 > ./result_8chains/node300_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_4_0 -p 756 -st none -pt topic300_4_0 -u 0.0010366972727310353 > ./result_8chains/node300_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_5_0 -p 811 -st none -pt topic300_5_0 -u 0.023234974544316223 > ./result_8chains/node300_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node300_6_0 -p 868 -st none -pt topic300_6_0 -u 0.018910003623974214 > ./result_8chains/node300_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node300_7_0 -p 961 -st none -pt topic300_7_0 -u 0.0020188713815521564 > ./result_8chains/node300_7_0.txt &
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
    "./result_8chains/node300_0_0.txt 90"
    "./result_8chains/node300_0_2.txt 90"
    "./result_8chains/node300_1_0.txt 89"
    "./result_8chains/node300_1_2.txt 89"
    "./result_8chains/node300_2_0.txt 88"
    "./result_8chains/node300_2_2.txt 88"
    "./result_8chains/node300_3_0.txt 87"
    "./result_8chains/node300_3_2.txt 87"
    "./result_8chains/node300_4_0.txt 86"
    "./result_8chains/node300_4_2.txt 86"
    "./result_8chains/node300_5_0.txt 85"
    "./result_8chains/node300_5_2.txt 85"
    "./result_8chains/node300_6_0.txt 84"
    "./result_8chains/node300_6_2.txt 84"
    "./result_8chains/node300_7_0.txt 83"
    "./result_8chains/node300_7_2.txt 83"
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
