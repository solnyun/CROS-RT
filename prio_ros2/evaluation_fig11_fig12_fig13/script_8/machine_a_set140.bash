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
ros2 run evaluation_3_randomdag uunifast_node -n node140_0_2 -p 11 -st topic140_0_1 -pt None -u 0.00035917866851253866 > ./result_8chains/node140_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_1_2 -p 118 -st topic140_1_1 -pt None -u 0.04052116347875406 > ./result_8chains/node140_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_2_2 -p 181 -st topic140_2_1 -pt None -u 0.009784381521203145 > ./result_8chains/node140_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_3_2 -p 232 -st topic140_3_1 -pt None -u 0.03799421393676969 > ./result_8chains/node140_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_4_2 -p 428 -st topic140_4_1 -pt None -u 0.006499198157983166 > ./result_8chains/node140_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_5_2 -p 556 -st topic140_5_1 -pt None -u 0.0027100298080889595 > ./result_8chains/node140_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_6_2 -p 842 -st topic140_6_1 -pt None -u 0.005780465004343843 > ./result_8chains/node140_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_7_2 -p 888 -st topic140_7_1 -pt None -u 0.05993554041433272 > ./result_8chains/node140_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_0_0 -p 11 -st none -pt topic140_0_0 -u 0.006832375218800535 > ./result_8chains/node140_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_1_0 -p 118 -st none -pt topic140_1_0 -u 0.01962777163528906 > ./result_8chains/node140_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_2_0 -p 181 -st none -pt topic140_2_0 -u 0.09412093340263045 > ./result_8chains/node140_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_3_0 -p 232 -st none -pt topic140_3_0 -u 0.010576338076349723 > ./result_8chains/node140_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_4_0 -p 428 -st none -pt topic140_4_0 -u 0.00997099857743236 > ./result_8chains/node140_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_5_0 -p 556 -st none -pt topic140_5_0 -u 0.00858865943147824 > ./result_8chains/node140_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_6_0 -p 842 -st none -pt topic140_6_0 -u 0.018708081200650872 > ./result_8chains/node140_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_7_0 -p 888 -st none -pt topic140_7_0 -u 0.026532127033192132 > ./result_8chains/node140_7_0.txt &
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
    "./result_8chains/node140_0_0.txt 90"
    "./result_8chains/node140_0_2.txt 90"
    "./result_8chains/node140_1_0.txt 89"
    "./result_8chains/node140_1_2.txt 89"
    "./result_8chains/node140_2_0.txt 88"
    "./result_8chains/node140_2_2.txt 88"
    "./result_8chains/node140_3_0.txt 87"
    "./result_8chains/node140_3_2.txt 87"
    "./result_8chains/node140_4_0.txt 86"
    "./result_8chains/node140_4_2.txt 86"
    "./result_8chains/node140_5_0.txt 85"
    "./result_8chains/node140_5_2.txt 85"
    "./result_8chains/node140_6_0.txt 84"
    "./result_8chains/node140_6_2.txt 84"
    "./result_8chains/node140_7_0.txt 83"
    "./result_8chains/node140_7_2.txt 83"
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
