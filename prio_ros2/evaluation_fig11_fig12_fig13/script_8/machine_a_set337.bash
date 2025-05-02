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
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_2 -p 150 -st topic337_0_1 -pt None -u 0.009345658172821625 > ./result_8chains/node337_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_2 -p 310 -st topic337_1_1 -pt None -u 0.023436871905122336 > ./result_8chains/node337_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_2 -p 527 -st topic337_2_1 -pt None -u 0.012565906281688466 > ./result_8chains/node337_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_2 -p 608 -st topic337_3_1 -pt None -u 0.0026055175108123385 > ./result_8chains/node337_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_2 -p 643 -st topic337_4_1 -pt None -u 0.017771139963626226 > ./result_8chains/node337_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_2 -p 673 -st topic337_5_1 -pt None -u 0.005138182588753648 > ./result_8chains/node337_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_6_2 -p 739 -st topic337_6_1 -pt None -u 0.01558396112629501 > ./result_8chains/node337_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_7_2 -p 817 -st topic337_7_1 -pt None -u 0.03933194710505355 > ./result_8chains/node337_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_0_0 -p 150 -st none -pt topic337_0_0 -u 0.005552469238090718 > ./result_8chains/node337_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_1_0 -p 310 -st none -pt topic337_1_0 -u 0.022114543816952936 > ./result_8chains/node337_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_2_0 -p 527 -st none -pt topic337_2_0 -u 0.027137196794381424 > ./result_8chains/node337_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_3_0 -p 608 -st none -pt topic337_3_0 -u 0.030538233719902386 > ./result_8chains/node337_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_4_0 -p 643 -st none -pt topic337_4_0 -u 0.015154986516406954 > ./result_8chains/node337_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_5_0 -p 673 -st none -pt topic337_5_0 -u 0.03387564857589817 > ./result_8chains/node337_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node337_6_0 -p 739 -st none -pt topic337_6_0 -u 0.021838739898244364 > ./result_8chains/node337_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node337_7_0 -p 817 -st none -pt topic337_7_0 -u 0.031334760297941924 > ./result_8chains/node337_7_0.txt &
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
    "./result_8chains/node337_0_0.txt 90"
    "./result_8chains/node337_0_2.txt 90"
    "./result_8chains/node337_1_0.txt 89"
    "./result_8chains/node337_1_2.txt 89"
    "./result_8chains/node337_2_0.txt 88"
    "./result_8chains/node337_2_2.txt 88"
    "./result_8chains/node337_3_0.txt 87"
    "./result_8chains/node337_3_2.txt 87"
    "./result_8chains/node337_4_0.txt 86"
    "./result_8chains/node337_4_2.txt 86"
    "./result_8chains/node337_5_0.txt 85"
    "./result_8chains/node337_5_2.txt 85"
    "./result_8chains/node337_6_0.txt 84"
    "./result_8chains/node337_6_2.txt 84"
    "./result_8chains/node337_7_0.txt 83"
    "./result_8chains/node337_7_2.txt 83"
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
