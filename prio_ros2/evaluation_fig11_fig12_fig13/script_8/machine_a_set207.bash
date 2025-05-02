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
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_2 -p 55 -st topic207_0_1 -pt None -u 0.018332103165426106 > ./result_8chains/node207_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_2 -p 194 -st topic207_1_1 -pt None -u 0.02114854621149856 > ./result_8chains/node207_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_2 -p 225 -st topic207_2_1 -pt None -u 0.001762648204584466 > ./result_8chains/node207_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_2 -p 281 -st topic207_3_1 -pt None -u 0.013969400406981525 > ./result_8chains/node207_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_2 -p 327 -st topic207_4_1 -pt None -u 0.023068203179045565 > ./result_8chains/node207_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_2 -p 407 -st topic207_5_1 -pt None -u 0.0026863447698212 > ./result_8chains/node207_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_6_2 -p 632 -st topic207_6_1 -pt None -u 0.05641481032181572 > ./result_8chains/node207_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_7_2 -p 846 -st topic207_7_1 -pt None -u 0.025769005332815287 > ./result_8chains/node207_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_0 -p 55 -st none -pt topic207_0_0 -u 0.032573121434446184 > ./result_8chains/node207_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_0 -p 194 -st none -pt topic207_1_0 -u 0.08486502914030353 > ./result_8chains/node207_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_0 -p 225 -st none -pt topic207_2_0 -u 0.01406317593085582 > ./result_8chains/node207_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_0 -p 281 -st none -pt topic207_3_0 -u 0.020820696221853174 > ./result_8chains/node207_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_0 -p 327 -st none -pt topic207_4_0 -u 0.0059518201870008836 > ./result_8chains/node207_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_0 -p 407 -st none -pt topic207_5_0 -u 0.0101836438505237 > ./result_8chains/node207_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_6_0 -p 632 -st none -pt topic207_6_0 -u 0.013877599887982317 > ./result_8chains/node207_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node207_7_0 -p 846 -st none -pt topic207_7_0 -u 0.0013709646497191141 > ./result_8chains/node207_7_0.txt &
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
    "./result_8chains/node207_0_0.txt 90"
    "./result_8chains/node207_0_2.txt 90"
    "./result_8chains/node207_1_0.txt 89"
    "./result_8chains/node207_1_2.txt 89"
    "./result_8chains/node207_2_0.txt 88"
    "./result_8chains/node207_2_2.txt 88"
    "./result_8chains/node207_3_0.txt 87"
    "./result_8chains/node207_3_2.txt 87"
    "./result_8chains/node207_4_0.txt 86"
    "./result_8chains/node207_4_2.txt 86"
    "./result_8chains/node207_5_0.txt 85"
    "./result_8chains/node207_5_2.txt 85"
    "./result_8chains/node207_6_0.txt 84"
    "./result_8chains/node207_6_2.txt 84"
    "./result_8chains/node207_7_0.txt 83"
    "./result_8chains/node207_7_2.txt 83"
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
