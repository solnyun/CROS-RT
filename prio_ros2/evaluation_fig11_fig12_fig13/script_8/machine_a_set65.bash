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
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_2 -p 96 -st topic65_0_1 -pt None -u 0.002274426476948588 > ./result_8chains/node65_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_2 -p 173 -st topic65_1_1 -pt None -u 0.000623887562855252 > ./result_8chains/node65_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_2 -p 325 -st topic65_2_1 -pt None -u 0.001915700804983822 > ./result_8chains/node65_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_2 -p 331 -st topic65_3_1 -pt None -u 0.0346190160474637 > ./result_8chains/node65_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_2 -p 479 -st topic65_4_1 -pt None -u 0.11448149669781177 > ./result_8chains/node65_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_2 -p 620 -st topic65_5_1 -pt None -u 0.0034817099569267596 > ./result_8chains/node65_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_6_2 -p 853 -st topic65_6_1 -pt None -u 0.03405061368525106 > ./result_8chains/node65_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_7_2 -p 942 -st topic65_7_1 -pt None -u 0.015985580079173098 > ./result_8chains/node65_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_0 -p 96 -st none -pt topic65_0_0 -u 0.008360968760502963 > ./result_8chains/node65_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_0 -p 173 -st none -pt topic65_1_0 -u 0.007071340283248906 > ./result_8chains/node65_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_0 -p 325 -st none -pt topic65_2_0 -u 0.04825260650661012 > ./result_8chains/node65_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_0 -p 331 -st none -pt topic65_3_0 -u 0.04184116086974837 > ./result_8chains/node65_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_0 -p 479 -st none -pt topic65_4_0 -u 0.012315513949138823 > ./result_8chains/node65_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_0 -p 620 -st none -pt topic65_5_0 -u 0.002619809983400334 > ./result_8chains/node65_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_6_0 -p 853 -st none -pt topic65_6_0 -u 0.03417969914336988 > ./result_8chains/node65_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_7_0 -p 942 -st none -pt topic65_7_0 -u 0.03248483727719067 > ./result_8chains/node65_7_0.txt &
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
    "./result_8chains/node65_0_0.txt 90"
    "./result_8chains/node65_0_2.txt 90"
    "./result_8chains/node65_1_0.txt 89"
    "./result_8chains/node65_1_2.txt 89"
    "./result_8chains/node65_2_0.txt 88"
    "./result_8chains/node65_2_2.txt 88"
    "./result_8chains/node65_3_0.txt 87"
    "./result_8chains/node65_3_2.txt 87"
    "./result_8chains/node65_4_0.txt 86"
    "./result_8chains/node65_4_2.txt 86"
    "./result_8chains/node65_5_0.txt 85"
    "./result_8chains/node65_5_2.txt 85"
    "./result_8chains/node65_6_0.txt 84"
    "./result_8chains/node65_6_2.txt 84"
    "./result_8chains/node65_7_0.txt 83"
    "./result_8chains/node65_7_2.txt 83"
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
