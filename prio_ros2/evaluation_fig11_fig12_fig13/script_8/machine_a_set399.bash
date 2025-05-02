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
ros2 run evaluation_3_randomdag uunifast_node -n node399_0_2 -p 70 -st topic399_0_1 -pt None -u 4.2681310055858734e-05 > ./result_8chains/node399_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_1_2 -p 212 -st topic399_1_1 -pt None -u 0.008438552597873739 > ./result_8chains/node399_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_2_2 -p 294 -st topic399_2_1 -pt None -u 0.026813023820529636 > ./result_8chains/node399_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_3_2 -p 432 -st topic399_3_1 -pt None -u 0.006756810302749577 > ./result_8chains/node399_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_4_2 -p 536 -st topic399_4_1 -pt None -u 0.07340761239999474 > ./result_8chains/node399_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_5_2 -p 674 -st topic399_5_1 -pt None -u 0.0035915885328622194 > ./result_8chains/node399_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_6_2 -p 962 -st topic399_6_1 -pt None -u 0.008503838482614323 > ./result_8chains/node399_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_7_2 -p 971 -st topic399_7_1 -pt None -u 0.02160235712072078 > ./result_8chains/node399_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_0_0 -p 70 -st none -pt topic399_0_0 -u 0.008012400935403896 > ./result_8chains/node399_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_1_0 -p 212 -st none -pt topic399_1_0 -u 0.03760806896512042 > ./result_8chains/node399_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_2_0 -p 294 -st none -pt topic399_2_0 -u 0.0012137679456492023 > ./result_8chains/node399_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_3_0 -p 432 -st none -pt topic399_3_0 -u 0.07047006447092641 > ./result_8chains/node399_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_4_0 -p 536 -st none -pt topic399_4_0 -u 0.07395807238871141 > ./result_8chains/node399_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_5_0 -p 674 -st none -pt topic399_5_0 -u 0.0012436464704902173 > ./result_8chains/node399_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_6_0 -p 962 -st none -pt topic399_6_0 -u 0.004136253458788389 > ./result_8chains/node399_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_7_0 -p 971 -st none -pt topic399_7_0 -u 0.006106711631632514 > ./result_8chains/node399_7_0.txt &
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
    "./result_8chains/node399_0_0.txt 90"
    "./result_8chains/node399_0_2.txt 90"
    "./result_8chains/node399_1_0.txt 89"
    "./result_8chains/node399_1_2.txt 89"
    "./result_8chains/node399_2_0.txt 88"
    "./result_8chains/node399_2_2.txt 88"
    "./result_8chains/node399_3_0.txt 87"
    "./result_8chains/node399_3_2.txt 87"
    "./result_8chains/node399_4_0.txt 86"
    "./result_8chains/node399_4_2.txt 86"
    "./result_8chains/node399_5_0.txt 85"
    "./result_8chains/node399_5_2.txt 85"
    "./result_8chains/node399_6_0.txt 84"
    "./result_8chains/node399_6_2.txt 84"
    "./result_8chains/node399_7_0.txt 83"
    "./result_8chains/node399_7_2.txt 83"
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
