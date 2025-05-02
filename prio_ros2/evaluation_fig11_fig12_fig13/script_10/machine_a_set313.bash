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
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_2 -p 91 -st topic313_0_1 -pt None -u 0.007325316639976265 > ./result_10chains/node313_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_2 -p 169 -st topic313_1_1 -pt None -u 0.0008428011330668395 > ./result_10chains/node313_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_2 -p 246 -st topic313_2_1 -pt None -u 0.022201256645804746 > ./result_10chains/node313_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_2 -p 277 -st topic313_3_1 -pt None -u 0.01337457252986124 > ./result_10chains/node313_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_2 -p 306 -st topic313_4_1 -pt None -u 0.028096601608168292 > ./result_10chains/node313_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_2 -p 323 -st topic313_5_1 -pt None -u 0.021365109356160678 > ./result_10chains/node313_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_6_2 -p 582 -st topic313_6_1 -pt None -u 0.003576688473048345 > ./result_10chains/node313_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_7_2 -p 624 -st topic313_7_1 -pt None -u 0.014232585200439518 > ./result_10chains/node313_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_8_2 -p 721 -st topic313_8_1 -pt None -u 0.06571209297274766 > ./result_10chains/node313_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_9_2 -p 923 -st topic313_9_1 -pt None -u 0.0046615754323926445 > ./result_10chains/node313_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_0 -p 91 -st none -pt topic313_0_0 -u 0.021585137654462627 > ./result_10chains/node313_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_0 -p 169 -st none -pt topic313_1_0 -u 0.007961148806179652 > ./result_10chains/node313_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_0 -p 246 -st none -pt topic313_2_0 -u 0.05490748836723219 > ./result_10chains/node313_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_0 -p 277 -st none -pt topic313_3_0 -u 0.007964186417074082 > ./result_10chains/node313_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_0 -p 306 -st none -pt topic313_4_0 -u 0.0006174061654948271 > ./result_10chains/node313_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_0 -p 323 -st none -pt topic313_5_0 -u 0.02905917315274248 > ./result_10chains/node313_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_6_0 -p 582 -st none -pt topic313_6_0 -u 0.011386042533113927 > ./result_10chains/node313_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_7_0 -p 624 -st none -pt topic313_7_0 -u 0.028045900162581877 > ./result_10chains/node313_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_8_0 -p 721 -st none -pt topic313_8_0 -u 0.00025536003314476086 > ./result_10chains/node313_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node313_9_0 -p 923 -st none -pt topic313_9_0 -u 0.007017937866675324 > ./result_10chains/node313_9_0.txt &
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
    "./result_10chains/node313_0_0.txt 90"
    "./result_10chains/node313_0_2.txt 90"
    "./result_10chains/node313_1_0.txt 89"
    "./result_10chains/node313_1_2.txt 89"
    "./result_10chains/node313_2_0.txt 88"
    "./result_10chains/node313_2_2.txt 88"
    "./result_10chains/node313_3_0.txt 87"
    "./result_10chains/node313_3_2.txt 87"
    "./result_10chains/node313_4_0.txt 86"
    "./result_10chains/node313_4_2.txt 86"
    "./result_10chains/node313_5_0.txt 85"
    "./result_10chains/node313_5_2.txt 85"
    "./result_10chains/node313_6_0.txt 84"
    "./result_10chains/node313_6_2.txt 84"
    "./result_10chains/node313_7_0.txt 83"
    "./result_10chains/node313_7_2.txt 83"
    "./result_10chains/node313_8_0.txt 82"
    "./result_10chains/node313_8_2.txt 82"
    "./result_10chains/node313_9_0.txt 81"
    "./result_10chains/node313_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
