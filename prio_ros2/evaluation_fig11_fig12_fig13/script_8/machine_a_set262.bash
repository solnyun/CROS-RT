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
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_2 -p 73 -st topic262_0_1 -pt None -u 0.013858165774591036 > ./result_8chains/node262_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_2 -p 144 -st topic262_1_1 -pt None -u 0.01761227866619619 > ./result_8chains/node262_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_2 -p 167 -st topic262_2_1 -pt None -u 0.015924065519364317 > ./result_8chains/node262_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_2 -p 264 -st topic262_3_1 -pt None -u 0.004581325237322353 > ./result_8chains/node262_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_2 -p 409 -st topic262_4_1 -pt None -u 0.021974260220221475 > ./result_8chains/node262_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_2 -p 457 -st topic262_5_1 -pt None -u 0.0010618686527569254 > ./result_8chains/node262_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_6_2 -p 591 -st topic262_6_1 -pt None -u 0.10858975645483177 > ./result_8chains/node262_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_7_2 -p 749 -st topic262_7_1 -pt None -u 0.02280017461180172 > ./result_8chains/node262_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_0 -p 73 -st none -pt topic262_0_0 -u 0.002782799695086713 > ./result_8chains/node262_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_0 -p 144 -st none -pt topic262_1_0 -u 0.0037762463335002106 > ./result_8chains/node262_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_0 -p 167 -st none -pt topic262_2_0 -u 0.012879876853309824 > ./result_8chains/node262_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_0 -p 264 -st none -pt topic262_3_0 -u 0.02205898397228273 > ./result_8chains/node262_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_0 -p 409 -st none -pt topic262_4_0 -u 0.011977663958476659 > ./result_8chains/node262_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_0 -p 457 -st none -pt topic262_5_0 -u 0.013970481807912272 > ./result_8chains/node262_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_6_0 -p 591 -st none -pt topic262_6_0 -u 0.020406468390514187 > ./result_8chains/node262_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_7_0 -p 749 -st none -pt topic262_7_0 -u 0.006650679006748171 > ./result_8chains/node262_7_0.txt &
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
    "./result_8chains/node262_0_0.txt 90"
    "./result_8chains/node262_0_2.txt 90"
    "./result_8chains/node262_1_0.txt 89"
    "./result_8chains/node262_1_2.txt 89"
    "./result_8chains/node262_2_0.txt 88"
    "./result_8chains/node262_2_2.txt 88"
    "./result_8chains/node262_3_0.txt 87"
    "./result_8chains/node262_3_2.txt 87"
    "./result_8chains/node262_4_0.txt 86"
    "./result_8chains/node262_4_2.txt 86"
    "./result_8chains/node262_5_0.txt 85"
    "./result_8chains/node262_5_2.txt 85"
    "./result_8chains/node262_6_0.txt 84"
    "./result_8chains/node262_6_2.txt 84"
    "./result_8chains/node262_7_0.txt 83"
    "./result_8chains/node262_7_2.txt 83"
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
