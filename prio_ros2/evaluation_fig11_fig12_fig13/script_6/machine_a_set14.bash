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
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_2 -p 28 -st topic14_0_1 -pt None -u 0.03555198039827634 > ./result_6chains/node14_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_2 -p 38 -st topic14_1_1 -pt None -u 0.009660379799298346 > ./result_6chains/node14_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_2 -p 449 -st topic14_2_1 -pt None -u 0.02782008122657309 > ./result_6chains/node14_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_2 -p 452 -st topic14_3_1 -pt None -u 0.04238694766472839 > ./result_6chains/node14_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_2 -p 711 -st topic14_4_1 -pt None -u 0.10488882567901699 > ./result_6chains/node14_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_2 -p 765 -st topic14_5_1 -pt None -u 0.005024712541736854 > ./result_6chains/node14_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_0 -p 28 -st none -pt topic14_0_0 -u 0.0014261137474598784 > ./result_6chains/node14_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_0 -p 38 -st none -pt topic14_1_0 -u 0.01520248361090698 > ./result_6chains/node14_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_0 -p 449 -st none -pt topic14_2_0 -u 0.01680945694411856 > ./result_6chains/node14_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_0 -p 452 -st none -pt topic14_3_0 -u 0.02171692606403164 > ./result_6chains/node14_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_0 -p 711 -st none -pt topic14_4_0 -u 0.033826613669356215 > ./result_6chains/node14_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_0 -p 765 -st none -pt topic14_5_0 -u 0.005397266879949916 > ./result_6chains/node14_5_0.txt &
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
    "./result_6chains/node14_0_0.txt 90"
    "./result_6chains/node14_0_2.txt 90"
    "./result_6chains/node14_1_0.txt 89"
    "./result_6chains/node14_1_2.txt 89"
    "./result_6chains/node14_2_0.txt 88"
    "./result_6chains/node14_2_2.txt 88"
    "./result_6chains/node14_3_0.txt 87"
    "./result_6chains/node14_3_2.txt 87"
    "./result_6chains/node14_4_0.txt 86"
    "./result_6chains/node14_4_2.txt 86"
    "./result_6chains/node14_5_0.txt 85"
    "./result_6chains/node14_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
