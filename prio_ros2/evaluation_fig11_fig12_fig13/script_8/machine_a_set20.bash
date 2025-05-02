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
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_2 -p 178 -st topic20_0_1 -pt None -u 0.01750764269680377 > ./result_8chains/node20_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_2 -p 217 -st topic20_1_1 -pt None -u 0.020617636167276743 > ./result_8chains/node20_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_2 -p 227 -st topic20_2_1 -pt None -u 0.03273715077514233 > ./result_8chains/node20_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_2 -p 246 -st topic20_3_1 -pt None -u 0.06963989465052112 > ./result_8chains/node20_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_2 -p 488 -st topic20_4_1 -pt None -u 0.03464700349490954 > ./result_8chains/node20_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_2 -p 499 -st topic20_5_1 -pt None -u 0.00756872184371056 > ./result_8chains/node20_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_6_2 -p 884 -st topic20_6_1 -pt None -u 0.02867217119220692 > ./result_8chains/node20_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_7_2 -p 917 -st topic20_7_1 -pt None -u 0.039406108070782805 > ./result_8chains/node20_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_0 -p 178 -st none -pt topic20_0_0 -u 0.02931956486207371 > ./result_8chains/node20_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_0 -p 217 -st none -pt topic20_1_0 -u 0.0118625488976567 > ./result_8chains/node20_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_0 -p 227 -st none -pt topic20_2_0 -u 0.013341776931502625 > ./result_8chains/node20_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_0 -p 246 -st none -pt topic20_3_0 -u 0.008468108773406313 > ./result_8chains/node20_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_0 -p 488 -st none -pt topic20_4_0 -u 0.03108186890090417 > ./result_8chains/node20_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_0 -p 499 -st none -pt topic20_5_0 -u 0.001682224985179101 > ./result_8chains/node20_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node20_6_0 -p 884 -st none -pt topic20_6_0 -u 0.0001970982758010692 > ./result_8chains/node20_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node20_7_0 -p 917 -st none -pt topic20_7_0 -u 0.011656315634705018 > ./result_8chains/node20_7_0.txt &
sleep 10
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
    "./result_8chains/node20_0_0.txt 90"
    "./result_8chains/node20_0_2.txt 90"
    "./result_8chains/node20_1_0.txt 89"
    "./result_8chains/node20_1_2.txt 89"
    "./result_8chains/node20_2_0.txt 88"
    "./result_8chains/node20_2_2.txt 88"
    "./result_8chains/node20_3_0.txt 87"
    "./result_8chains/node20_3_2.txt 87"
    "./result_8chains/node20_4_0.txt 86"
    "./result_8chains/node20_4_2.txt 86"
    "./result_8chains/node20_5_0.txt 85"
    "./result_8chains/node20_5_2.txt 85"
    "./result_8chains/node20_6_0.txt 84"
    "./result_8chains/node20_6_2.txt 84"
    "./result_8chains/node20_7_0.txt 83"
    "./result_8chains/node20_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
