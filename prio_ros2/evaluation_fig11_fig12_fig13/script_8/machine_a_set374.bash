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
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_2 -p 20 -st topic374_0_1 -pt None -u 0.033577056395094285 > ./result_8chains/node374_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_2 -p 37 -st topic374_1_1 -pt None -u 0.018753212722672385 > ./result_8chains/node374_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_2 -p 54 -st topic374_2_1 -pt None -u 0.008675736488090335 > ./result_8chains/node374_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_2 -p 61 -st topic374_3_1 -pt None -u 0.010208359866751504 > ./result_8chains/node374_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_2 -p 90 -st topic374_4_1 -pt None -u 0.005080327792972905 > ./result_8chains/node374_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_2 -p 494 -st topic374_5_1 -pt None -u 0.014900448722242943 > ./result_8chains/node374_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_6_2 -p 574 -st topic374_6_1 -pt None -u 0.010237017297364315 > ./result_8chains/node374_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_7_2 -p 876 -st topic374_7_1 -pt None -u 0.04060187252744979 > ./result_8chains/node374_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_0 -p 20 -st none -pt topic374_0_0 -u 0.09985343503226052 > ./result_8chains/node374_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_0 -p 37 -st none -pt topic374_1_0 -u 0.020463725146410483 > ./result_8chains/node374_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_0 -p 54 -st none -pt topic374_2_0 -u 0.0392043608647521 > ./result_8chains/node374_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_0 -p 61 -st none -pt topic374_3_0 -u 0.011213165302369571 > ./result_8chains/node374_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_0 -p 90 -st none -pt topic374_4_0 -u 0.010381698571090475 > ./result_8chains/node374_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_0 -p 494 -st none -pt topic374_5_0 -u 0.011276909705998567 > ./result_8chains/node374_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_6_0 -p 574 -st none -pt topic374_6_0 -u 0.015404142253224312 > ./result_8chains/node374_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_7_0 -p 876 -st none -pt topic374_7_0 -u 0.04767072604781534 > ./result_8chains/node374_7_0.txt &
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
    "./result_8chains/node374_0_0.txt 90"
    "./result_8chains/node374_0_2.txt 90"
    "./result_8chains/node374_1_0.txt 89"
    "./result_8chains/node374_1_2.txt 89"
    "./result_8chains/node374_2_0.txt 88"
    "./result_8chains/node374_2_2.txt 88"
    "./result_8chains/node374_3_0.txt 87"
    "./result_8chains/node374_3_2.txt 87"
    "./result_8chains/node374_4_0.txt 86"
    "./result_8chains/node374_4_2.txt 86"
    "./result_8chains/node374_5_0.txt 85"
    "./result_8chains/node374_5_2.txt 85"
    "./result_8chains/node374_6_0.txt 84"
    "./result_8chains/node374_6_2.txt 84"
    "./result_8chains/node374_7_0.txt 83"
    "./result_8chains/node374_7_2.txt 83"
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
