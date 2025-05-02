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
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_2 -p 38 -st topic135_0_1 -pt None -u 0.015506887160194882 > ./result_8chains/node135_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_2 -p 206 -st topic135_1_1 -pt None -u 0.029623511333252917 > ./result_8chains/node135_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_2 -p 344 -st topic135_2_1 -pt None -u 0.02636744025102894 > ./result_8chains/node135_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_2 -p 412 -st topic135_3_1 -pt None -u 0.061055940440983225 > ./result_8chains/node135_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_2 -p 566 -st topic135_4_1 -pt None -u 0.004410545567836488 > ./result_8chains/node135_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_2 -p 754 -st topic135_5_1 -pt None -u 0.003043215800264884 > ./result_8chains/node135_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_6_2 -p 780 -st topic135_6_1 -pt None -u 0.008063197014361728 > ./result_8chains/node135_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_7_2 -p 974 -st topic135_7_1 -pt None -u 0.0324402462033173 > ./result_8chains/node135_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_0 -p 38 -st none -pt topic135_0_0 -u 0.006106800219903841 > ./result_8chains/node135_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_0 -p 206 -st none -pt topic135_1_0 -u 0.013475189816824884 > ./result_8chains/node135_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_0 -p 344 -st none -pt topic135_2_0 -u 0.0015453232150415275 > ./result_8chains/node135_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_0 -p 412 -st none -pt topic135_3_0 -u 0.006632236337031916 > ./result_8chains/node135_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_0 -p 566 -st none -pt topic135_4_0 -u 0.012946198325140545 > ./result_8chains/node135_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_0 -p 754 -st none -pt topic135_5_0 -u 0.05634591103170192 > ./result_8chains/node135_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_6_0 -p 780 -st none -pt topic135_6_0 -u 0.032955625645492787 > ./result_8chains/node135_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_7_0 -p 974 -st none -pt topic135_7_0 -u 0.012037569672411715 > ./result_8chains/node135_7_0.txt &
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
    "./result_8chains/node135_0_0.txt 90"
    "./result_8chains/node135_0_2.txt 90"
    "./result_8chains/node135_1_0.txt 89"
    "./result_8chains/node135_1_2.txt 89"
    "./result_8chains/node135_2_0.txt 88"
    "./result_8chains/node135_2_2.txt 88"
    "./result_8chains/node135_3_0.txt 87"
    "./result_8chains/node135_3_2.txt 87"
    "./result_8chains/node135_4_0.txt 86"
    "./result_8chains/node135_4_2.txt 86"
    "./result_8chains/node135_5_0.txt 85"
    "./result_8chains/node135_5_2.txt 85"
    "./result_8chains/node135_6_0.txt 84"
    "./result_8chains/node135_6_2.txt 84"
    "./result_8chains/node135_7_0.txt 83"
    "./result_8chains/node135_7_2.txt 83"
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
