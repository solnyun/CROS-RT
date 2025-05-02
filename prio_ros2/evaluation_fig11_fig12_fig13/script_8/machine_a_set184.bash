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
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_2 -p 128 -st topic184_0_1 -pt None -u 0.017431218228670053 > ./result_8chains/node184_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_2 -p 355 -st topic184_1_1 -pt None -u 0.009888221267168595 > ./result_8chains/node184_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_2 -p 439 -st topic184_2_1 -pt None -u 0.005057431102305443 > ./result_8chains/node184_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_2 -p 711 -st topic184_3_1 -pt None -u 0.04524064560407087 > ./result_8chains/node184_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_2 -p 739 -st topic184_4_1 -pt None -u 0.0067391474004726 > ./result_8chains/node184_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_2 -p 741 -st topic184_5_1 -pt None -u 0.0030642696637931677 > ./result_8chains/node184_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_6_2 -p 786 -st topic184_6_1 -pt None -u 0.023836497783609058 > ./result_8chains/node184_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_7_2 -p 910 -st topic184_7_1 -pt None -u 0.01652518572191314 > ./result_8chains/node184_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_0 -p 128 -st none -pt topic184_0_0 -u 0.021575662469131895 > ./result_8chains/node184_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_0 -p 355 -st none -pt topic184_1_0 -u 0.017568312366547323 > ./result_8chains/node184_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_0 -p 439 -st none -pt topic184_2_0 -u 0.027237517027643765 > ./result_8chains/node184_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_0 -p 711 -st none -pt topic184_3_0 -u 0.013600633708573118 > ./result_8chains/node184_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_0 -p 739 -st none -pt topic184_4_0 -u 0.11429115314480925 > ./result_8chains/node184_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_0 -p 741 -st none -pt topic184_5_0 -u 0.006386626873536763 > ./result_8chains/node184_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_6_0 -p 786 -st none -pt topic184_6_0 -u 0.02783015017308288 > ./result_8chains/node184_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_7_0 -p 910 -st none -pt topic184_7_0 -u 0.009346519652415487 > ./result_8chains/node184_7_0.txt &
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
    "./result_8chains/node184_0_0.txt 90"
    "./result_8chains/node184_0_2.txt 90"
    "./result_8chains/node184_1_0.txt 89"
    "./result_8chains/node184_1_2.txt 89"
    "./result_8chains/node184_2_0.txt 88"
    "./result_8chains/node184_2_2.txt 88"
    "./result_8chains/node184_3_0.txt 87"
    "./result_8chains/node184_3_2.txt 87"
    "./result_8chains/node184_4_0.txt 86"
    "./result_8chains/node184_4_2.txt 86"
    "./result_8chains/node184_5_0.txt 85"
    "./result_8chains/node184_5_2.txt 85"
    "./result_8chains/node184_6_0.txt 84"
    "./result_8chains/node184_6_2.txt 84"
    "./result_8chains/node184_7_0.txt 83"
    "./result_8chains/node184_7_2.txt 83"
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
