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
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_2 -p 164 -st topic232_0_1 -pt None -u 0.06475697120889906 > ./result_4chains/node232_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_2 -p 217 -st topic232_1_1 -pt None -u 0.01797680349582162 > ./result_4chains/node232_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_2 -p 368 -st topic232_2_1 -pt None -u 0.007668306667288238 > ./result_4chains/node232_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_2 -p 901 -st topic232_3_1 -pt None -u 0.04479329782885824 > ./result_4chains/node232_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_0 -p 164 -st none -pt topic232_0_0 -u 0.0010947626066233895 > ./result_4chains/node232_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_0 -p 217 -st none -pt topic232_1_0 -u 0.014392693083019326 > ./result_4chains/node232_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_0 -p 368 -st none -pt topic232_2_0 -u 0.11222386077394282 > ./result_4chains/node232_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_0 -p 901 -st none -pt topic232_3_0 -u 0.008210035227724108 > ./result_4chains/node232_3_0.txt &
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
    "./result_4chains/node232_0_0.txt 90"
    "./result_4chains/node232_0_2.txt 90"
    "./result_4chains/node232_1_0.txt 89"
    "./result_4chains/node232_1_2.txt 89"
    "./result_4chains/node232_2_0.txt 88"
    "./result_4chains/node232_2_2.txt 88"
    "./result_4chains/node232_3_0.txt 87"
    "./result_4chains/node232_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
