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
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_2 -p 29 -st topic393_0_1 -pt None -u 0.021682471474353815 > ./result_8chains/node393_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_2 -p 139 -st topic393_1_1 -pt None -u 0.001461102585705698 > ./result_8chains/node393_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_2 -p 200 -st topic393_2_1 -pt None -u 0.010762383890464966 > ./result_8chains/node393_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_2 -p 232 -st topic393_3_1 -pt None -u 0.017401911639123524 > ./result_8chains/node393_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_2 -p 289 -st topic393_4_1 -pt None -u 0.013899764914025114 > ./result_8chains/node393_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_2 -p 493 -st topic393_5_1 -pt None -u 0.004605412762883676 > ./result_8chains/node393_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_6_2 -p 514 -st topic393_6_1 -pt None -u 0.0027567478535251017 > ./result_8chains/node393_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_7_2 -p 594 -st topic393_7_1 -pt None -u 0.07524767496505858 > ./result_8chains/node393_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_0 -p 29 -st none -pt topic393_0_0 -u 0.05418324415246489 > ./result_8chains/node393_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_0 -p 139 -st none -pt topic393_1_0 -u 0.017937343989910925 > ./result_8chains/node393_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_0 -p 200 -st none -pt topic393_2_0 -u 0.02842388185942607 > ./result_8chains/node393_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_0 -p 232 -st none -pt topic393_3_0 -u 0.016777489822084934 > ./result_8chains/node393_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_0 -p 289 -st none -pt topic393_4_0 -u 0.006780044755446191 > ./result_8chains/node393_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_0 -p 493 -st none -pt topic393_5_0 -u 0.008210815105076819 > ./result_8chains/node393_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_6_0 -p 514 -st none -pt topic393_6_0 -u 0.046510888698150024 > ./result_8chains/node393_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_7_0 -p 594 -st none -pt topic393_7_0 -u 0.001566334211566725 > ./result_8chains/node393_7_0.txt &
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
    "./result_8chains/node393_0_0.txt 90"
    "./result_8chains/node393_0_2.txt 90"
    "./result_8chains/node393_1_0.txt 89"
    "./result_8chains/node393_1_2.txt 89"
    "./result_8chains/node393_2_0.txt 88"
    "./result_8chains/node393_2_2.txt 88"
    "./result_8chains/node393_3_0.txt 87"
    "./result_8chains/node393_3_2.txt 87"
    "./result_8chains/node393_4_0.txt 86"
    "./result_8chains/node393_4_2.txt 86"
    "./result_8chains/node393_5_0.txt 85"
    "./result_8chains/node393_5_2.txt 85"
    "./result_8chains/node393_6_0.txt 84"
    "./result_8chains/node393_6_2.txt 84"
    "./result_8chains/node393_7_0.txt 83"
    "./result_8chains/node393_7_2.txt 83"
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
