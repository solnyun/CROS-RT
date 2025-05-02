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
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_2 -p 106 -st topic278_0_1 -pt None -u 0.013989695435596028 > ./result_8chains/node278_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_2 -p 291 -st topic278_1_1 -pt None -u 0.004712957869827172 > ./result_8chains/node278_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_2 -p 326 -st topic278_2_1 -pt None -u 0.007889264582112865 > ./result_8chains/node278_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_2 -p 405 -st topic278_3_1 -pt None -u 0.026073462071590947 > ./result_8chains/node278_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_2 -p 512 -st topic278_4_1 -pt None -u 0.01326101069161037 > ./result_8chains/node278_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_2 -p 595 -st topic278_5_1 -pt None -u 0.02172397187061101 > ./result_8chains/node278_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_6_2 -p 971 -st topic278_6_1 -pt None -u 0.022142317164865005 > ./result_8chains/node278_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_7_2 -p 999 -st topic278_7_1 -pt None -u 0.04293109346975681 > ./result_8chains/node278_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_0 -p 106 -st none -pt topic278_0_0 -u 0.04314767797146468 > ./result_8chains/node278_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_0 -p 291 -st none -pt topic278_1_0 -u 0.008694137865313811 > ./result_8chains/node278_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_0 -p 326 -st none -pt topic278_2_0 -u 0.0551710830146509 > ./result_8chains/node278_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_0 -p 405 -st none -pt topic278_3_0 -u 0.0066852676298365665 > ./result_8chains/node278_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_0 -p 512 -st none -pt topic278_4_0 -u 0.029608735091072924 > ./result_8chains/node278_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_0 -p 595 -st none -pt topic278_5_0 -u 0.0479004838707304 > ./result_8chains/node278_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_6_0 -p 971 -st none -pt topic278_6_0 -u 0.00837685996556184 > ./result_8chains/node278_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_7_0 -p 999 -st none -pt topic278_7_0 -u 0.04216539593101544 > ./result_8chains/node278_7_0.txt &
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
    "./result_8chains/node278_0_0.txt 90"
    "./result_8chains/node278_0_2.txt 90"
    "./result_8chains/node278_1_0.txt 89"
    "./result_8chains/node278_1_2.txt 89"
    "./result_8chains/node278_2_0.txt 88"
    "./result_8chains/node278_2_2.txt 88"
    "./result_8chains/node278_3_0.txt 87"
    "./result_8chains/node278_3_2.txt 87"
    "./result_8chains/node278_4_0.txt 86"
    "./result_8chains/node278_4_2.txt 86"
    "./result_8chains/node278_5_0.txt 85"
    "./result_8chains/node278_5_2.txt 85"
    "./result_8chains/node278_6_0.txt 84"
    "./result_8chains/node278_6_2.txt 84"
    "./result_8chains/node278_7_0.txt 83"
    "./result_8chains/node278_7_2.txt 83"
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
