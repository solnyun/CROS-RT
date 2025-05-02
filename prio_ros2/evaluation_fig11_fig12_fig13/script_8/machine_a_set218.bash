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
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_2 -p 103 -st topic218_0_1 -pt None -u 0.010434345383673438 > ./result_8chains/node218_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_2 -p 408 -st topic218_1_1 -pt None -u 0.07092141363922944 > ./result_8chains/node218_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_2 -p 470 -st topic218_2_1 -pt None -u 0.01767604179190696 > ./result_8chains/node218_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_2 -p 652 -st topic218_3_1 -pt None -u 0.013519704758169382 > ./result_8chains/node218_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_2 -p 671 -st topic218_4_1 -pt None -u 0.03354431330218918 > ./result_8chains/node218_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_2 -p 709 -st topic218_5_1 -pt None -u 0.016625522780334717 > ./result_8chains/node218_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_6_2 -p 841 -st topic218_6_1 -pt None -u 0.018524539851991484 > ./result_8chains/node218_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_7_2 -p 874 -st topic218_7_1 -pt None -u 0.020057769267002253 > ./result_8chains/node218_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_0 -p 103 -st none -pt topic218_0_0 -u 0.03246324385458532 > ./result_8chains/node218_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_0 -p 408 -st none -pt topic218_1_0 -u 0.0020571378600594548 > ./result_8chains/node218_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_0 -p 470 -st none -pt topic218_2_0 -u 0.023813707136376816 > ./result_8chains/node218_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_0 -p 652 -st none -pt topic218_3_0 -u 0.0067768807176740165 > ./result_8chains/node218_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_0 -p 671 -st none -pt topic218_4_0 -u 0.006899904646569588 > ./result_8chains/node218_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_0 -p 709 -st none -pt topic218_5_0 -u 0.008375474155128265 > ./result_8chains/node218_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_6_0 -p 841 -st none -pt topic218_6_0 -u 0.04730094639548431 > ./result_8chains/node218_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_7_0 -p 874 -st none -pt topic218_7_0 -u 0.011806019370687579 > ./result_8chains/node218_7_0.txt &
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
    "./result_8chains/node218_0_0.txt 90"
    "./result_8chains/node218_0_2.txt 90"
    "./result_8chains/node218_1_0.txt 89"
    "./result_8chains/node218_1_2.txt 89"
    "./result_8chains/node218_2_0.txt 88"
    "./result_8chains/node218_2_2.txt 88"
    "./result_8chains/node218_3_0.txt 87"
    "./result_8chains/node218_3_2.txt 87"
    "./result_8chains/node218_4_0.txt 86"
    "./result_8chains/node218_4_2.txt 86"
    "./result_8chains/node218_5_0.txt 85"
    "./result_8chains/node218_5_2.txt 85"
    "./result_8chains/node218_6_0.txt 84"
    "./result_8chains/node218_6_2.txt 84"
    "./result_8chains/node218_7_0.txt 83"
    "./result_8chains/node218_7_2.txt 83"
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
