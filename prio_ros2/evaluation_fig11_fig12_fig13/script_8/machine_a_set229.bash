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
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_2 -p 26 -st topic229_0_1 -pt None -u 0.01366782381502174 > ./result_8chains/node229_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_2 -p 99 -st topic229_1_1 -pt None -u 7.146110286110341e-05 > ./result_8chains/node229_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_2 -p 322 -st topic229_2_1 -pt None -u 0.0225574797953218 > ./result_8chains/node229_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_2 -p 440 -st topic229_3_1 -pt None -u 0.02274735390013627 > ./result_8chains/node229_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_2 -p 538 -st topic229_4_1 -pt None -u 0.012513414580408777 > ./result_8chains/node229_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_2 -p 549 -st topic229_5_1 -pt None -u 0.006295516163288245 > ./result_8chains/node229_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_6_2 -p 666 -st topic229_6_1 -pt None -u 0.017878664194145785 > ./result_8chains/node229_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_7_2 -p 985 -st topic229_7_1 -pt None -u 0.012890902621863107 > ./result_8chains/node229_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_0 -p 26 -st none -pt topic229_0_0 -u 0.015375177937963558 > ./result_8chains/node229_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_0 -p 99 -st none -pt topic229_1_0 -u 0.00044790680170270214 > ./result_8chains/node229_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_0 -p 322 -st none -pt topic229_2_0 -u 0.014072498245411957 > ./result_8chains/node229_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_0 -p 440 -st none -pt topic229_3_0 -u 0.02202049877889528 > ./result_8chains/node229_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_0 -p 538 -st none -pt topic229_4_0 -u 0.024642058651218435 > ./result_8chains/node229_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_0 -p 549 -st none -pt topic229_5_0 -u 0.015853716385998584 > ./result_8chains/node229_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_6_0 -p 666 -st none -pt topic229_6_0 -u 0.07746303621464087 > ./result_8chains/node229_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node229_7_0 -p 985 -st none -pt topic229_7_0 -u 0.02319247663925995 > ./result_8chains/node229_7_0.txt &
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
    "./result_8chains/node229_0_0.txt 90"
    "./result_8chains/node229_0_2.txt 90"
    "./result_8chains/node229_1_0.txt 89"
    "./result_8chains/node229_1_2.txt 89"
    "./result_8chains/node229_2_0.txt 88"
    "./result_8chains/node229_2_2.txt 88"
    "./result_8chains/node229_3_0.txt 87"
    "./result_8chains/node229_3_2.txt 87"
    "./result_8chains/node229_4_0.txt 86"
    "./result_8chains/node229_4_2.txt 86"
    "./result_8chains/node229_5_0.txt 85"
    "./result_8chains/node229_5_2.txt 85"
    "./result_8chains/node229_6_0.txt 84"
    "./result_8chains/node229_6_2.txt 84"
    "./result_8chains/node229_7_0.txt 83"
    "./result_8chains/node229_7_2.txt 83"
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
