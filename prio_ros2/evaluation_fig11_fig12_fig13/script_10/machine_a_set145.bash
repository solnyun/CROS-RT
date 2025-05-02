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
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_2 -p 15 -st topic145_0_1 -pt None -u 0.0172621537438441 > ./result_10chains/node145_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_2 -p 88 -st topic145_1_1 -pt None -u 0.029383102929762928 > ./result_10chains/node145_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_2 -p 194 -st topic145_2_1 -pt None -u 0.02670307662901844 > ./result_10chains/node145_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_2 -p 484 -st topic145_3_1 -pt None -u 0.003158030568591874 > ./result_10chains/node145_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_2 -p 527 -st topic145_4_1 -pt None -u 0.011875791597618923 > ./result_10chains/node145_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_2 -p 773 -st topic145_5_1 -pt None -u 0.02778865160428376 > ./result_10chains/node145_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_6_2 -p 789 -st topic145_6_1 -pt None -u 0.014140062976461476 > ./result_10chains/node145_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_7_2 -p 799 -st topic145_7_1 -pt None -u 0.0230981106066252 > ./result_10chains/node145_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_8_2 -p 813 -st topic145_8_1 -pt None -u 0.01750144617599233 > ./result_10chains/node145_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_9_2 -p 930 -st topic145_9_1 -pt None -u 0.03148162961516031 > ./result_10chains/node145_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_0 -p 15 -st none -pt topic145_0_0 -u 0.006756630967841848 > ./result_10chains/node145_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_0 -p 88 -st none -pt topic145_1_0 -u 0.01639540528361494 > ./result_10chains/node145_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_0 -p 194 -st none -pt topic145_2_0 -u 0.01535998720887266 > ./result_10chains/node145_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_0 -p 484 -st none -pt topic145_3_0 -u 0.0019013556935379428 > ./result_10chains/node145_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_0 -p 527 -st none -pt topic145_4_0 -u 0.010274474685159907 > ./result_10chains/node145_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_0 -p 773 -st none -pt topic145_5_0 -u 0.027129496819214477 > ./result_10chains/node145_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_6_0 -p 789 -st none -pt topic145_6_0 -u 0.03683440946905994 > ./result_10chains/node145_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_7_0 -p 799 -st none -pt topic145_7_0 -u 0.005383601637732799 > ./result_10chains/node145_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_8_0 -p 813 -st none -pt topic145_8_0 -u 0.025369244666560528 > ./result_10chains/node145_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node145_9_0 -p 930 -st none -pt topic145_9_0 -u 0.003115740493753752 > ./result_10chains/node145_9_0.txt &
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
    "./result_10chains/node145_0_0.txt 90"
    "./result_10chains/node145_0_2.txt 90"
    "./result_10chains/node145_1_0.txt 89"
    "./result_10chains/node145_1_2.txt 89"
    "./result_10chains/node145_2_0.txt 88"
    "./result_10chains/node145_2_2.txt 88"
    "./result_10chains/node145_3_0.txt 87"
    "./result_10chains/node145_3_2.txt 87"
    "./result_10chains/node145_4_0.txt 86"
    "./result_10chains/node145_4_2.txt 86"
    "./result_10chains/node145_5_0.txt 85"
    "./result_10chains/node145_5_2.txt 85"
    "./result_10chains/node145_6_0.txt 84"
    "./result_10chains/node145_6_2.txt 84"
    "./result_10chains/node145_7_0.txt 83"
    "./result_10chains/node145_7_2.txt 83"
    "./result_10chains/node145_8_0.txt 82"
    "./result_10chains/node145_8_2.txt 82"
    "./result_10chains/node145_9_0.txt 81"
    "./result_10chains/node145_9_2.txt 81"
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
