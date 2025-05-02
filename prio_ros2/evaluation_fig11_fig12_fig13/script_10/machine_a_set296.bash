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
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_2 -p 22 -st topic296_0_1 -pt None -u 0.023102559843675485 > ./result_10chains/node296_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_2 -p 98 -st topic296_1_1 -pt None -u 0.04639292994783756 > ./result_10chains/node296_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_2 -p 112 -st topic296_2_1 -pt None -u 0.024481086548614306 > ./result_10chains/node296_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_2 -p 165 -st topic296_3_1 -pt None -u 0.0392411658187139 > ./result_10chains/node296_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_2 -p 167 -st topic296_4_1 -pt None -u 0.0019775832048760933 > ./result_10chains/node296_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_2 -p 245 -st topic296_5_1 -pt None -u 0.00832969766622757 > ./result_10chains/node296_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_6_2 -p 393 -st topic296_6_1 -pt None -u 0.010157201026361903 > ./result_10chains/node296_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_7_2 -p 449 -st topic296_7_1 -pt None -u 0.00402731777742453 > ./result_10chains/node296_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_8_2 -p 662 -st topic296_8_1 -pt None -u 0.05368766425335801 > ./result_10chains/node296_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_9_2 -p 707 -st topic296_9_1 -pt None -u 8.14305231564882e-05 > ./result_10chains/node296_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_0_0 -p 22 -st none -pt topic296_0_0 -u 0.01883085650085259 > ./result_10chains/node296_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_1_0 -p 98 -st none -pt topic296_1_0 -u 0.00868046506558795 > ./result_10chains/node296_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_2_0 -p 112 -st none -pt topic296_2_0 -u 0.007280211866078634 > ./result_10chains/node296_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_3_0 -p 165 -st none -pt topic296_3_0 -u 0.0009643327036326643 > ./result_10chains/node296_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_4_0 -p 167 -st none -pt topic296_4_0 -u 0.020884319227043036 > ./result_10chains/node296_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_5_0 -p 245 -st none -pt topic296_5_0 -u 0.013796812247466178 > ./result_10chains/node296_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_6_0 -p 393 -st none -pt topic296_6_0 -u 0.025181936807461475 > ./result_10chains/node296_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_7_0 -p 449 -st none -pt topic296_7_0 -u 0.002287528625060528 > ./result_10chains/node296_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node296_8_0 -p 662 -st none -pt topic296_8_0 -u 0.009562243512519414 > ./result_10chains/node296_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node296_9_0 -p 707 -st none -pt topic296_9_0 -u 0.011606969481944434 > ./result_10chains/node296_9_0.txt &
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
    "./result_10chains/node296_0_0.txt 90"
    "./result_10chains/node296_0_2.txt 90"
    "./result_10chains/node296_1_0.txt 89"
    "./result_10chains/node296_1_2.txt 89"
    "./result_10chains/node296_2_0.txt 88"
    "./result_10chains/node296_2_2.txt 88"
    "./result_10chains/node296_3_0.txt 87"
    "./result_10chains/node296_3_2.txt 87"
    "./result_10chains/node296_4_0.txt 86"
    "./result_10chains/node296_4_2.txt 86"
    "./result_10chains/node296_5_0.txt 85"
    "./result_10chains/node296_5_2.txt 85"
    "./result_10chains/node296_6_0.txt 84"
    "./result_10chains/node296_6_2.txt 84"
    "./result_10chains/node296_7_0.txt 83"
    "./result_10chains/node296_7_2.txt 83"
    "./result_10chains/node296_8_0.txt 82"
    "./result_10chains/node296_8_2.txt 82"
    "./result_10chains/node296_9_0.txt 81"
    "./result_10chains/node296_9_2.txt 81"
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
