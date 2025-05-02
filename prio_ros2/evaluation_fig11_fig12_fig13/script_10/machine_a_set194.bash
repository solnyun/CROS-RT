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
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_2 -p 104 -st topic194_0_1 -pt None -u 0.01774018925264248 > ./result_10chains/node194_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_2 -p 152 -st topic194_1_1 -pt None -u 0.06328765221083826 > ./result_10chains/node194_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_2 -p 216 -st topic194_2_1 -pt None -u 0.0007869762300348193 > ./result_10chains/node194_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_2 -p 378 -st topic194_3_1 -pt None -u 0.08201155256896203 > ./result_10chains/node194_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_2 -p 478 -st topic194_4_1 -pt None -u 0.002987928245103272 > ./result_10chains/node194_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_2 -p 518 -st topic194_5_1 -pt None -u 0.010065927642827682 > ./result_10chains/node194_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_6_2 -p 568 -st topic194_6_1 -pt None -u 0.00496239155022056 > ./result_10chains/node194_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_7_2 -p 748 -st topic194_7_1 -pt None -u 0.0024434375050838425 > ./result_10chains/node194_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_8_2 -p 770 -st topic194_8_1 -pt None -u 0.003710996631036934 > ./result_10chains/node194_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_9_2 -p 936 -st topic194_9_1 -pt None -u 0.002799118210289871 > ./result_10chains/node194_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_0 -p 104 -st none -pt topic194_0_0 -u 0.02297396643034466 > ./result_10chains/node194_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_0 -p 152 -st none -pt topic194_1_0 -u 0.035999119923911305 > ./result_10chains/node194_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_0 -p 216 -st none -pt topic194_2_0 -u 0.013258337019527666 > ./result_10chains/node194_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_0 -p 378 -st none -pt topic194_3_0 -u 0.05017084619243373 > ./result_10chains/node194_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_0 -p 478 -st none -pt topic194_4_0 -u 0.012373634063364974 > ./result_10chains/node194_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_0 -p 518 -st none -pt topic194_5_0 -u 0.003800282346401035 > ./result_10chains/node194_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_6_0 -p 568 -st none -pt topic194_6_0 -u 0.005072621422647555 > ./result_10chains/node194_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_7_0 -p 748 -st none -pt topic194_7_0 -u 0.018232689437970018 > ./result_10chains/node194_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_8_0 -p 770 -st none -pt topic194_8_0 -u 0.0001082867848668928 > ./result_10chains/node194_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_9_0 -p 936 -st none -pt topic194_9_0 -u 0.004608052539347159 > ./result_10chains/node194_9_0.txt &
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
    "./result_10chains/node194_0_0.txt 90"
    "./result_10chains/node194_0_2.txt 90"
    "./result_10chains/node194_1_0.txt 89"
    "./result_10chains/node194_1_2.txt 89"
    "./result_10chains/node194_2_0.txt 88"
    "./result_10chains/node194_2_2.txt 88"
    "./result_10chains/node194_3_0.txt 87"
    "./result_10chains/node194_3_2.txt 87"
    "./result_10chains/node194_4_0.txt 86"
    "./result_10chains/node194_4_2.txt 86"
    "./result_10chains/node194_5_0.txt 85"
    "./result_10chains/node194_5_2.txt 85"
    "./result_10chains/node194_6_0.txt 84"
    "./result_10chains/node194_6_2.txt 84"
    "./result_10chains/node194_7_0.txt 83"
    "./result_10chains/node194_7_2.txt 83"
    "./result_10chains/node194_8_0.txt 82"
    "./result_10chains/node194_8_2.txt 82"
    "./result_10chains/node194_9_0.txt 81"
    "./result_10chains/node194_9_2.txt 81"
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
