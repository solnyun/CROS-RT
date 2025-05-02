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
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_2 -p 44 -st topic58_0_1 -pt None -u 0.0007925587706995585 > ./result_8chains/node58_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_2 -p 74 -st topic58_1_1 -pt None -u 0.060160183029309366 > ./result_8chains/node58_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_2 -p 185 -st topic58_2_1 -pt None -u 0.01478570303607507 > ./result_8chains/node58_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_2 -p 347 -st topic58_3_1 -pt None -u 0.021494195190334242 > ./result_8chains/node58_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_2 -p 378 -st topic58_4_1 -pt None -u 0.08499828260658196 > ./result_8chains/node58_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_2 -p 809 -st topic58_5_1 -pt None -u 0.002272187471182685 > ./result_8chains/node58_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_6_2 -p 877 -st topic58_6_1 -pt None -u 0.06830214262909429 > ./result_8chains/node58_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_7_2 -p 941 -st topic58_7_1 -pt None -u 0.0031499091202603683 > ./result_8chains/node58_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_0_0 -p 44 -st none -pt topic58_0_0 -u 0.010049394763102959 > ./result_8chains/node58_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_1_0 -p 74 -st none -pt topic58_1_0 -u 0.029426051921555896 > ./result_8chains/node58_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_2_0 -p 185 -st none -pt topic58_2_0 -u 0.04672676620075711 > ./result_8chains/node58_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_3_0 -p 347 -st none -pt topic58_3_0 -u 0.005241601331626211 > ./result_8chains/node58_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_4_0 -p 378 -st none -pt topic58_4_0 -u 0.011001384296298933 > ./result_8chains/node58_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_5_0 -p 809 -st none -pt topic58_5_0 -u 0.0024768104538848423 > ./result_8chains/node58_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node58_6_0 -p 877 -st none -pt topic58_6_0 -u 0.013781220629675156 > ./result_8chains/node58_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node58_7_0 -p 941 -st none -pt topic58_7_0 -u 0.0031379642773584245 > ./result_8chains/node58_7_0.txt &
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
    "./result_8chains/node58_0_0.txt 90"
    "./result_8chains/node58_0_2.txt 90"
    "./result_8chains/node58_1_0.txt 89"
    "./result_8chains/node58_1_2.txt 89"
    "./result_8chains/node58_2_0.txt 88"
    "./result_8chains/node58_2_2.txt 88"
    "./result_8chains/node58_3_0.txt 87"
    "./result_8chains/node58_3_2.txt 87"
    "./result_8chains/node58_4_0.txt 86"
    "./result_8chains/node58_4_2.txt 86"
    "./result_8chains/node58_5_0.txt 85"
    "./result_8chains/node58_5_2.txt 85"
    "./result_8chains/node58_6_0.txt 84"
    "./result_8chains/node58_6_2.txt 84"
    "./result_8chains/node58_7_0.txt 83"
    "./result_8chains/node58_7_2.txt 83"
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
