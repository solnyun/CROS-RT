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
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_2 -p 21 -st topic85_0_1 -pt None -u 0.02536403829987771 > ./result_8chains/node85_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_2 -p 526 -st topic85_1_1 -pt None -u 0.013272370238418874 > ./result_8chains/node85_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_2 -p 542 -st topic85_2_1 -pt None -u 0.0033175097514343 > ./result_8chains/node85_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_2 -p 562 -st topic85_3_1 -pt None -u 0.06638087185152333 > ./result_8chains/node85_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_2 -p 635 -st topic85_4_1 -pt None -u 0.017868810758744094 > ./result_8chains/node85_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_2 -p 695 -st topic85_5_1 -pt None -u 0.020614178539613975 > ./result_8chains/node85_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_6_2 -p 933 -st topic85_6_1 -pt None -u 0.021065862963902598 > ./result_8chains/node85_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_7_2 -p 967 -st topic85_7_1 -pt None -u 0.0032918910053332277 > ./result_8chains/node85_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_0 -p 21 -st none -pt topic85_0_0 -u 0.048976237641174036 > ./result_8chains/node85_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_0 -p 526 -st none -pt topic85_1_0 -u 0.00827736364198689 > ./result_8chains/node85_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_0 -p 542 -st none -pt topic85_2_0 -u 0.011437425490502973 > ./result_8chains/node85_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_0 -p 562 -st none -pt topic85_3_0 -u 0.05444826949166909 > ./result_8chains/node85_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_0 -p 635 -st none -pt topic85_4_0 -u 0.01569906995677317 > ./result_8chains/node85_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_0 -p 695 -st none -pt topic85_5_0 -u 0.0029378637159728632 > ./result_8chains/node85_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_6_0 -p 933 -st none -pt topic85_6_0 -u 0.029180819122500985 > ./result_8chains/node85_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_7_0 -p 967 -st none -pt topic85_7_0 -u 0.001919299520942972 > ./result_8chains/node85_7_0.txt &
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
    "./result_8chains/node85_0_0.txt 90"
    "./result_8chains/node85_0_2.txt 90"
    "./result_8chains/node85_1_0.txt 89"
    "./result_8chains/node85_1_2.txt 89"
    "./result_8chains/node85_2_0.txt 88"
    "./result_8chains/node85_2_2.txt 88"
    "./result_8chains/node85_3_0.txt 87"
    "./result_8chains/node85_3_2.txt 87"
    "./result_8chains/node85_4_0.txt 86"
    "./result_8chains/node85_4_2.txt 86"
    "./result_8chains/node85_5_0.txt 85"
    "./result_8chains/node85_5_2.txt 85"
    "./result_8chains/node85_6_0.txt 84"
    "./result_8chains/node85_6_2.txt 84"
    "./result_8chains/node85_7_0.txt 83"
    "./result_8chains/node85_7_2.txt 83"
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
