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
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_2 -p 93 -st topic139_0_1 -pt None -u 0.006397907384074808 > ./result_10chains/node139_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_2 -p 138 -st topic139_1_1 -pt None -u 0.013756060338533382 > ./result_10chains/node139_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_2 -p 173 -st topic139_2_1 -pt None -u 0.02885262990463211 > ./result_10chains/node139_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_2 -p 416 -st topic139_3_1 -pt None -u 0.004930987320936886 > ./result_10chains/node139_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_2 -p 486 -st topic139_4_1 -pt None -u 0.02847430266878173 > ./result_10chains/node139_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_2 -p 560 -st topic139_5_1 -pt None -u 6.020093212100175e-06 > ./result_10chains/node139_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_6_2 -p 582 -st topic139_6_1 -pt None -u 0.003577789928451036 > ./result_10chains/node139_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_7_2 -p 739 -st topic139_7_1 -pt None -u 0.014658495310804771 > ./result_10chains/node139_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_8_2 -p 905 -st topic139_8_1 -pt None -u 0.0028629142305192125 > ./result_10chains/node139_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_9_2 -p 916 -st topic139_9_1 -pt None -u 0.006697915455854338 > ./result_10chains/node139_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_0 -p 93 -st none -pt topic139_0_0 -u 0.0197801829974964 > ./result_10chains/node139_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_0 -p 138 -st none -pt topic139_1_0 -u 0.02377026928670606 > ./result_10chains/node139_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_0 -p 173 -st none -pt topic139_2_0 -u 0.03852332971507805 > ./result_10chains/node139_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_0 -p 416 -st none -pt topic139_3_0 -u 0.0017003982662300854 > ./result_10chains/node139_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_0 -p 486 -st none -pt topic139_4_0 -u 0.003341467616265914 > ./result_10chains/node139_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_0 -p 560 -st none -pt topic139_5_0 -u 0.013361192737673583 > ./result_10chains/node139_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_6_0 -p 582 -st none -pt topic139_6_0 -u 0.01818917812440199 > ./result_10chains/node139_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_7_0 -p 739 -st none -pt topic139_7_0 -u 0.02335526538594146 > ./result_10chains/node139_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_8_0 -p 905 -st none -pt topic139_8_0 -u 0.016938174898115617 > ./result_10chains/node139_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_9_0 -p 916 -st none -pt topic139_9_0 -u 0.0006463014563405818 > ./result_10chains/node139_9_0.txt &
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
    "./result_10chains/node139_0_0.txt 90"
    "./result_10chains/node139_0_2.txt 90"
    "./result_10chains/node139_1_0.txt 89"
    "./result_10chains/node139_1_2.txt 89"
    "./result_10chains/node139_2_0.txt 88"
    "./result_10chains/node139_2_2.txt 88"
    "./result_10chains/node139_3_0.txt 87"
    "./result_10chains/node139_3_2.txt 87"
    "./result_10chains/node139_4_0.txt 86"
    "./result_10chains/node139_4_2.txt 86"
    "./result_10chains/node139_5_0.txt 85"
    "./result_10chains/node139_5_2.txt 85"
    "./result_10chains/node139_6_0.txt 84"
    "./result_10chains/node139_6_2.txt 84"
    "./result_10chains/node139_7_0.txt 83"
    "./result_10chains/node139_7_2.txt 83"
    "./result_10chains/node139_8_0.txt 82"
    "./result_10chains/node139_8_2.txt 82"
    "./result_10chains/node139_9_0.txt 81"
    "./result_10chains/node139_9_2.txt 81"
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
