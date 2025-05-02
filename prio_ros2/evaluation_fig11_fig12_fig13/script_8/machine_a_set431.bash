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
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_2 -p 97 -st topic431_0_1 -pt None -u 0.028985485054112692 > ./result_8chains/node431_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_2 -p 162 -st topic431_1_1 -pt None -u 0.00274290291197965 > ./result_8chains/node431_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_2 -p 234 -st topic431_2_1 -pt None -u 0.0314143096844241 > ./result_8chains/node431_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_2 -p 406 -st topic431_3_1 -pt None -u 0.005525996364585062 > ./result_8chains/node431_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_2 -p 461 -st topic431_4_1 -pt None -u 0.00869170329158972 > ./result_8chains/node431_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_2 -p 543 -st topic431_5_1 -pt None -u 0.04320809728299041 > ./result_8chains/node431_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_6_2 -p 690 -st topic431_6_1 -pt None -u 6.220065404707875e-05 > ./result_8chains/node431_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_7_2 -p 705 -st topic431_7_1 -pt None -u 0.07773233156055563 > ./result_8chains/node431_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_0 -p 97 -st none -pt topic431_0_0 -u 0.028918170918276143 > ./result_8chains/node431_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_0 -p 162 -st none -pt topic431_1_0 -u 0.011458221924411094 > ./result_8chains/node431_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_0 -p 234 -st none -pt topic431_2_0 -u 0.0027460704530137825 > ./result_8chains/node431_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_0 -p 406 -st none -pt topic431_3_0 -u 0.020958038572683357 > ./result_8chains/node431_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_0 -p 461 -st none -pt topic431_4_0 -u 0.002687420545987307 > ./result_8chains/node431_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_0 -p 543 -st none -pt topic431_5_0 -u 0.011234061282012209 > ./result_8chains/node431_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_6_0 -p 690 -st none -pt topic431_6_0 -u 0.007483336933032381 > ./result_8chains/node431_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_7_0 -p 705 -st none -pt topic431_7_0 -u 0.02242645909540511 > ./result_8chains/node431_7_0.txt &
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
    "./result_8chains/node431_0_0.txt 90"
    "./result_8chains/node431_0_2.txt 90"
    "./result_8chains/node431_1_0.txt 89"
    "./result_8chains/node431_1_2.txt 89"
    "./result_8chains/node431_2_0.txt 88"
    "./result_8chains/node431_2_2.txt 88"
    "./result_8chains/node431_3_0.txt 87"
    "./result_8chains/node431_3_2.txt 87"
    "./result_8chains/node431_4_0.txt 86"
    "./result_8chains/node431_4_2.txt 86"
    "./result_8chains/node431_5_0.txt 85"
    "./result_8chains/node431_5_2.txt 85"
    "./result_8chains/node431_6_0.txt 84"
    "./result_8chains/node431_6_2.txt 84"
    "./result_8chains/node431_7_0.txt 83"
    "./result_8chains/node431_7_2.txt 83"
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
