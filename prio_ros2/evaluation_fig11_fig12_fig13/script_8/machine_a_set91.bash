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
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_2 -p 223 -st topic91_0_1 -pt None -u 0.007852941873798647 > ./result_8chains/node91_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_2 -p 356 -st topic91_1_1 -pt None -u 0.013436040779720104 > ./result_8chains/node91_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_2 -p 357 -st topic91_2_1 -pt None -u 0.014802399592104332 > ./result_8chains/node91_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_2 -p 583 -st topic91_3_1 -pt None -u 0.02997350854673303 > ./result_8chains/node91_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_2 -p 809 -st topic91_4_1 -pt None -u 0.04484279383274206 > ./result_8chains/node91_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_2 -p 875 -st topic91_5_1 -pt None -u 0.013922709936417754 > ./result_8chains/node91_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_6_2 -p 877 -st topic91_6_1 -pt None -u 0.002412668969533155 > ./result_8chains/node91_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_7_2 -p 954 -st topic91_7_1 -pt None -u 0.0171651480216609 > ./result_8chains/node91_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_0 -p 223 -st none -pt topic91_0_0 -u 0.004320290570413221 > ./result_8chains/node91_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_0 -p 356 -st none -pt topic91_1_0 -u 0.028197827335153747 > ./result_8chains/node91_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_0 -p 357 -st none -pt topic91_2_0 -u 0.009711732899460812 > ./result_8chains/node91_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_0 -p 583 -st none -pt topic91_3_0 -u 0.0028176315012616304 > ./result_8chains/node91_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_0 -p 809 -st none -pt topic91_4_0 -u 0.011806666871121974 > ./result_8chains/node91_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_0 -p 875 -st none -pt topic91_5_0 -u 0.017384319220240918 > ./result_8chains/node91_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_6_0 -p 877 -st none -pt topic91_6_0 -u 0.03716796457739699 > ./result_8chains/node91_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_7_0 -p 954 -st none -pt topic91_7_0 -u 0.01626952658065904 > ./result_8chains/node91_7_0.txt &
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
    "./result_8chains/node91_0_0.txt 90"
    "./result_8chains/node91_0_2.txt 90"
    "./result_8chains/node91_1_0.txt 89"
    "./result_8chains/node91_1_2.txt 89"
    "./result_8chains/node91_2_0.txt 88"
    "./result_8chains/node91_2_2.txt 88"
    "./result_8chains/node91_3_0.txt 87"
    "./result_8chains/node91_3_2.txt 87"
    "./result_8chains/node91_4_0.txt 86"
    "./result_8chains/node91_4_2.txt 86"
    "./result_8chains/node91_5_0.txt 85"
    "./result_8chains/node91_5_2.txt 85"
    "./result_8chains/node91_6_0.txt 84"
    "./result_8chains/node91_6_2.txt 84"
    "./result_8chains/node91_7_0.txt 83"
    "./result_8chains/node91_7_2.txt 83"
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
