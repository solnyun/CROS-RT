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
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_2 -p 47 -st topic307_0_1 -pt None -u 0.00034131283510041577 > ./result_8chains/node307_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_2 -p 78 -st topic307_1_1 -pt None -u 0.018342142092645453 > ./result_8chains/node307_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_2 -p 81 -st topic307_2_1 -pt None -u 0.06711989702865273 > ./result_8chains/node307_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_2 -p 106 -st topic307_3_1 -pt None -u 0.021168435164223204 > ./result_8chains/node307_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_2 -p 349 -st topic307_4_1 -pt None -u 0.015141456403372555 > ./result_8chains/node307_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_2 -p 427 -st topic307_5_1 -pt None -u 0.020029992549784853 > ./result_8chains/node307_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_6_2 -p 435 -st topic307_6_1 -pt None -u 0.00815155146351381 > ./result_8chains/node307_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_7_2 -p 522 -st topic307_7_1 -pt None -u 0.0038497299541539525 > ./result_8chains/node307_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_0 -p 47 -st none -pt topic307_0_0 -u 0.021488543044241748 > ./result_8chains/node307_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_0 -p 78 -st none -pt topic307_1_0 -u 0.006895111153804034 > ./result_8chains/node307_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_0 -p 81 -st none -pt topic307_2_0 -u 0.022816364012341994 > ./result_8chains/node307_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_0 -p 106 -st none -pt topic307_3_0 -u 0.0069363570760067605 > ./result_8chains/node307_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_0 -p 349 -st none -pt topic307_4_0 -u 0.02136836540138043 > ./result_8chains/node307_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_0 -p 427 -st none -pt topic307_5_0 -u 0.013686819652590693 > ./result_8chains/node307_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_6_0 -p 435 -st none -pt topic307_6_0 -u 0.049051341848960844 > ./result_8chains/node307_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_7_0 -p 522 -st none -pt topic307_7_0 -u 0.0003553265089576846 > ./result_8chains/node307_7_0.txt &
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
    "./result_8chains/node307_0_0.txt 90"
    "./result_8chains/node307_0_2.txt 90"
    "./result_8chains/node307_1_0.txt 89"
    "./result_8chains/node307_1_2.txt 89"
    "./result_8chains/node307_2_0.txt 88"
    "./result_8chains/node307_2_2.txt 88"
    "./result_8chains/node307_3_0.txt 87"
    "./result_8chains/node307_3_2.txt 87"
    "./result_8chains/node307_4_0.txt 86"
    "./result_8chains/node307_4_2.txt 86"
    "./result_8chains/node307_5_0.txt 85"
    "./result_8chains/node307_5_2.txt 85"
    "./result_8chains/node307_6_0.txt 84"
    "./result_8chains/node307_6_2.txt 84"
    "./result_8chains/node307_7_0.txt 83"
    "./result_8chains/node307_7_2.txt 83"
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
