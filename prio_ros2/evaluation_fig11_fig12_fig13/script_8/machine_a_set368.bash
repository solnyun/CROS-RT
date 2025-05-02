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
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_2 -p 253 -st topic368_0_1 -pt None -u 0.00277324143026203 > ./result_8chains/node368_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_2 -p 329 -st topic368_1_1 -pt None -u 0.006058198449845453 > ./result_8chains/node368_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_2 -p 402 -st topic368_2_1 -pt None -u 0.026342901215525794 > ./result_8chains/node368_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_2 -p 466 -st topic368_3_1 -pt None -u 0.03255830550608546 > ./result_8chains/node368_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_2 -p 556 -st topic368_4_1 -pt None -u 0.0068820766212792095 > ./result_8chains/node368_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_2 -p 641 -st topic368_5_1 -pt None -u 0.006845363434405838 > ./result_8chains/node368_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_6_2 -p 798 -st topic368_6_1 -pt None -u 0.09103604568674904 > ./result_8chains/node368_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_7_2 -p 836 -st topic368_7_1 -pt None -u 0.034652646021532826 > ./result_8chains/node368_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_0 -p 253 -st none -pt topic368_0_0 -u 0.04183173068894097 > ./result_8chains/node368_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_0 -p 329 -st none -pt topic368_1_0 -u 0.018868960540774138 > ./result_8chains/node368_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_0 -p 402 -st none -pt topic368_2_0 -u 0.00019213774140347528 > ./result_8chains/node368_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_0 -p 466 -st none -pt topic368_3_0 -u 0.0045656381154656756 > ./result_8chains/node368_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_0 -p 556 -st none -pt topic368_4_0 -u 0.0038751250004236404 > ./result_8chains/node368_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_0 -p 641 -st none -pt topic368_5_0 -u 0.020054258612213438 > ./result_8chains/node368_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_6_0 -p 798 -st none -pt topic368_6_0 -u 0.02789609343452612 > ./result_8chains/node368_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node368_7_0 -p 836 -st none -pt topic368_7_0 -u 0.05242267310244459 > ./result_8chains/node368_7_0.txt &
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
    "./result_8chains/node368_0_0.txt 90"
    "./result_8chains/node368_0_2.txt 90"
    "./result_8chains/node368_1_0.txt 89"
    "./result_8chains/node368_1_2.txt 89"
    "./result_8chains/node368_2_0.txt 88"
    "./result_8chains/node368_2_2.txt 88"
    "./result_8chains/node368_3_0.txt 87"
    "./result_8chains/node368_3_2.txt 87"
    "./result_8chains/node368_4_0.txt 86"
    "./result_8chains/node368_4_2.txt 86"
    "./result_8chains/node368_5_0.txt 85"
    "./result_8chains/node368_5_2.txt 85"
    "./result_8chains/node368_6_0.txt 84"
    "./result_8chains/node368_6_2.txt 84"
    "./result_8chains/node368_7_0.txt 83"
    "./result_8chains/node368_7_2.txt 83"
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
