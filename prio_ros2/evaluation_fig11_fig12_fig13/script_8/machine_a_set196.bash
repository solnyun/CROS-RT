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
ros2 run evaluation_3_randomdag uunifast_node -n node196_0_2 -p 14 -st topic196_0_1 -pt None -u 0.0031886635297930233 > ./result_8chains/node196_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_1_2 -p 30 -st topic196_1_1 -pt None -u 0.012108499045181076 > ./result_8chains/node196_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_2_2 -p 210 -st topic196_2_1 -pt None -u 0.034761320553381936 > ./result_8chains/node196_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_3_2 -p 366 -st topic196_3_1 -pt None -u 0.06843437489211898 > ./result_8chains/node196_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_4_2 -p 393 -st topic196_4_1 -pt None -u 0.016730884773944577 > ./result_8chains/node196_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_5_2 -p 404 -st topic196_5_1 -pt None -u 0.007398642571082303 > ./result_8chains/node196_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_6_2 -p 684 -st topic196_6_1 -pt None -u 0.0030121945193941416 > ./result_8chains/node196_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_7_2 -p 821 -st topic196_7_1 -pt None -u 0.011556923110481945 > ./result_8chains/node196_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_0_0 -p 14 -st none -pt topic196_0_0 -u 0.031222199429642605 > ./result_8chains/node196_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_1_0 -p 30 -st none -pt topic196_1_0 -u 0.01986006926867029 > ./result_8chains/node196_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_2_0 -p 210 -st none -pt topic196_2_0 -u 0.03651559434266649 > ./result_8chains/node196_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_3_0 -p 366 -st none -pt topic196_3_0 -u 0.025466719970038187 > ./result_8chains/node196_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_4_0 -p 393 -st none -pt topic196_4_0 -u 0.0006806221168495497 > ./result_8chains/node196_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_5_0 -p 404 -st none -pt topic196_5_0 -u 0.01786783889214119 > ./result_8chains/node196_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node196_6_0 -p 684 -st none -pt topic196_6_0 -u 0.019671434368267432 > ./result_8chains/node196_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node196_7_0 -p 821 -st none -pt topic196_7_0 -u 0.006356977190478556 > ./result_8chains/node196_7_0.txt &
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
    "./result_8chains/node196_0_0.txt 90"
    "./result_8chains/node196_0_2.txt 90"
    "./result_8chains/node196_1_0.txt 89"
    "./result_8chains/node196_1_2.txt 89"
    "./result_8chains/node196_2_0.txt 88"
    "./result_8chains/node196_2_2.txt 88"
    "./result_8chains/node196_3_0.txt 87"
    "./result_8chains/node196_3_2.txt 87"
    "./result_8chains/node196_4_0.txt 86"
    "./result_8chains/node196_4_2.txt 86"
    "./result_8chains/node196_5_0.txt 85"
    "./result_8chains/node196_5_2.txt 85"
    "./result_8chains/node196_6_0.txt 84"
    "./result_8chains/node196_6_2.txt 84"
    "./result_8chains/node196_7_0.txt 83"
    "./result_8chains/node196_7_2.txt 83"
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
