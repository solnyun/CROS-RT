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
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_2 -p 14 -st topic483_0_1 -pt None -u 0.0008507570101712325 > ./result_10chains/node483_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_2 -p 39 -st topic483_1_1 -pt None -u 0.04649458972603049 > ./result_10chains/node483_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_2 -p 64 -st topic483_2_1 -pt None -u 0.0180340790813574 > ./result_10chains/node483_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_2 -p 123 -st topic483_3_1 -pt None -u 0.013229835045368676 > ./result_10chains/node483_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_2 -p 200 -st topic483_4_1 -pt None -u 0.026751441981178403 > ./result_10chains/node483_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_2 -p 373 -st topic483_5_1 -pt None -u 0.021224432081032585 > ./result_10chains/node483_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_6_2 -p 560 -st topic483_6_1 -pt None -u 0.01397326816336776 > ./result_10chains/node483_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_7_2 -p 597 -st topic483_7_1 -pt None -u 0.0019452862855804595 > ./result_10chains/node483_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_8_2 -p 817 -st topic483_8_1 -pt None -u 0.011174254305489312 > ./result_10chains/node483_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_9_2 -p 835 -st topic483_9_1 -pt None -u 0.01593042880098802 > ./result_10chains/node483_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_0 -p 14 -st none -pt topic483_0_0 -u 0.011461036542445624 > ./result_10chains/node483_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_0 -p 39 -st none -pt topic483_1_0 -u 0.02007102835493546 > ./result_10chains/node483_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_0 -p 64 -st none -pt topic483_2_0 -u 0.02050685534318858 > ./result_10chains/node483_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_0 -p 123 -st none -pt topic483_3_0 -u 0.0023706730552285893 > ./result_10chains/node483_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_0 -p 200 -st none -pt topic483_4_0 -u 0.014659840581195821 > ./result_10chains/node483_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_0 -p 373 -st none -pt topic483_5_0 -u 0.023620023550975477 > ./result_10chains/node483_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_6_0 -p 560 -st none -pt topic483_6_0 -u 0.006295862075719222 > ./result_10chains/node483_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_7_0 -p 597 -st none -pt topic483_7_0 -u 0.00014191851595728167 > ./result_10chains/node483_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_8_0 -p 817 -st none -pt topic483_8_0 -u 0.01315575885122161 > ./result_10chains/node483_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_9_0 -p 835 -st none -pt topic483_9_0 -u 0.009566102469291658 > ./result_10chains/node483_9_0.txt &
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
    "./result_10chains/node483_0_0.txt 90"
    "./result_10chains/node483_0_2.txt 90"
    "./result_10chains/node483_1_0.txt 89"
    "./result_10chains/node483_1_2.txt 89"
    "./result_10chains/node483_2_0.txt 88"
    "./result_10chains/node483_2_2.txt 88"
    "./result_10chains/node483_3_0.txt 87"
    "./result_10chains/node483_3_2.txt 87"
    "./result_10chains/node483_4_0.txt 86"
    "./result_10chains/node483_4_2.txt 86"
    "./result_10chains/node483_5_0.txt 85"
    "./result_10chains/node483_5_2.txt 85"
    "./result_10chains/node483_6_0.txt 84"
    "./result_10chains/node483_6_2.txt 84"
    "./result_10chains/node483_7_0.txt 83"
    "./result_10chains/node483_7_2.txt 83"
    "./result_10chains/node483_8_0.txt 82"
    "./result_10chains/node483_8_2.txt 82"
    "./result_10chains/node483_9_0.txt 81"
    "./result_10chains/node483_9_2.txt 81"
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
