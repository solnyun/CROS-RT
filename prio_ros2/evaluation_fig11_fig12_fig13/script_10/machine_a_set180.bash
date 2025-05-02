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
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_2 -p 140 -st topic180_0_1 -pt None -u 0.010500316914714314 > ./result_10chains/node180_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_2 -p 179 -st topic180_1_1 -pt None -u 0.0113835424117395 > ./result_10chains/node180_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_2 -p 193 -st topic180_2_1 -pt None -u 0.004323961357118267 > ./result_10chains/node180_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_2 -p 233 -st topic180_3_1 -pt None -u 0.0430116509412814 > ./result_10chains/node180_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_2 -p 308 -st topic180_4_1 -pt None -u 0.023978355540291207 > ./result_10chains/node180_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_2 -p 441 -st topic180_5_1 -pt None -u 0.013463236404868822 > ./result_10chains/node180_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_6_2 -p 738 -st topic180_6_1 -pt None -u 0.0017950547259592553 > ./result_10chains/node180_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_7_2 -p 832 -st topic180_7_1 -pt None -u 0.029886001657128777 > ./result_10chains/node180_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_8_2 -p 862 -st topic180_8_1 -pt None -u 0.028806785948899016 > ./result_10chains/node180_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_9_2 -p 888 -st topic180_9_1 -pt None -u 0.02960170144163827 > ./result_10chains/node180_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_0 -p 140 -st none -pt topic180_0_0 -u 0.006249414016195998 > ./result_10chains/node180_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_0 -p 179 -st none -pt topic180_1_0 -u 0.06464887169216915 > ./result_10chains/node180_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_0 -p 193 -st none -pt topic180_2_0 -u 0.0185317762766109 > ./result_10chains/node180_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_0 -p 233 -st none -pt topic180_3_0 -u 0.00962721902614222 > ./result_10chains/node180_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_0 -p 308 -st none -pt topic180_4_0 -u 0.026953385432814392 > ./result_10chains/node180_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_0 -p 441 -st none -pt topic180_5_0 -u 0.002337448691267674 > ./result_10chains/node180_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_6_0 -p 738 -st none -pt topic180_6_0 -u 0.0016979317143670236 > ./result_10chains/node180_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_7_0 -p 832 -st none -pt topic180_7_0 -u 0.002769030442052206 > ./result_10chains/node180_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_8_0 -p 862 -st none -pt topic180_8_0 -u 0.02301854434065874 > ./result_10chains/node180_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_9_0 -p 888 -st none -pt topic180_9_0 -u 0.019129115712605914 > ./result_10chains/node180_9_0.txt &
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
    "./result_10chains/node180_0_0.txt 90"
    "./result_10chains/node180_0_2.txt 90"
    "./result_10chains/node180_1_0.txt 89"
    "./result_10chains/node180_1_2.txt 89"
    "./result_10chains/node180_2_0.txt 88"
    "./result_10chains/node180_2_2.txt 88"
    "./result_10chains/node180_3_0.txt 87"
    "./result_10chains/node180_3_2.txt 87"
    "./result_10chains/node180_4_0.txt 86"
    "./result_10chains/node180_4_2.txt 86"
    "./result_10chains/node180_5_0.txt 85"
    "./result_10chains/node180_5_2.txt 85"
    "./result_10chains/node180_6_0.txt 84"
    "./result_10chains/node180_6_2.txt 84"
    "./result_10chains/node180_7_0.txt 83"
    "./result_10chains/node180_7_2.txt 83"
    "./result_10chains/node180_8_0.txt 82"
    "./result_10chains/node180_8_2.txt 82"
    "./result_10chains/node180_9_0.txt 81"
    "./result_10chains/node180_9_2.txt 81"
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
