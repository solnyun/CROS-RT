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
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_2 -p 94 -st topic61_0_1 -pt None -u 0.024049689741512725 > ./result_8chains/node61_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_2 -p 353 -st topic61_1_1 -pt None -u 0.03578954820606717 > ./result_8chains/node61_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_2 -p 486 -st topic61_2_1 -pt None -u 0.010638709751191633 > ./result_8chains/node61_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_2 -p 558 -st topic61_3_1 -pt None -u 0.026349248821187277 > ./result_8chains/node61_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_2 -p 882 -st topic61_4_1 -pt None -u 0.03075492229306609 > ./result_8chains/node61_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_2 -p 927 -st topic61_5_1 -pt None -u 0.0022715063210460573 > ./result_8chains/node61_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_6_2 -p 931 -st topic61_6_1 -pt None -u 0.002878590436912576 > ./result_8chains/node61_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_7_2 -p 983 -st topic61_7_1 -pt None -u 0.03166150946858086 > ./result_8chains/node61_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_0 -p 94 -st none -pt topic61_0_0 -u 0.003812459013989078 > ./result_8chains/node61_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_0 -p 353 -st none -pt topic61_1_0 -u 0.03487392748978674 > ./result_8chains/node61_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_0 -p 486 -st none -pt topic61_2_0 -u 0.029221455412808683 > ./result_8chains/node61_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_0 -p 558 -st none -pt topic61_3_0 -u 0.028057562105252787 > ./result_8chains/node61_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_0 -p 882 -st none -pt topic61_4_0 -u 0.041229312062182444 > ./result_8chains/node61_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_0 -p 927 -st none -pt topic61_5_0 -u 0.00514150401304711 > ./result_8chains/node61_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_6_0 -p 931 -st none -pt topic61_6_0 -u 0.01536324803457119 > ./result_8chains/node61_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_7_0 -p 983 -st none -pt topic61_7_0 -u 0.03650652417432313 > ./result_8chains/node61_7_0.txt &
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
    "./result_8chains/node61_0_0.txt 90"
    "./result_8chains/node61_0_2.txt 90"
    "./result_8chains/node61_1_0.txt 89"
    "./result_8chains/node61_1_2.txt 89"
    "./result_8chains/node61_2_0.txt 88"
    "./result_8chains/node61_2_2.txt 88"
    "./result_8chains/node61_3_0.txt 87"
    "./result_8chains/node61_3_2.txt 87"
    "./result_8chains/node61_4_0.txt 86"
    "./result_8chains/node61_4_2.txt 86"
    "./result_8chains/node61_5_0.txt 85"
    "./result_8chains/node61_5_2.txt 85"
    "./result_8chains/node61_6_0.txt 84"
    "./result_8chains/node61_6_2.txt 84"
    "./result_8chains/node61_7_0.txt 83"
    "./result_8chains/node61_7_2.txt 83"
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
