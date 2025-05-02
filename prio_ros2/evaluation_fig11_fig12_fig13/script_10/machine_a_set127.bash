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
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_2 -p 68 -st topic127_0_1 -pt None -u 0.10924791841084514 > ./result_10chains/node127_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_2 -p 84 -st topic127_1_1 -pt None -u 0.004739533613594804 > ./result_10chains/node127_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_2 -p 188 -st topic127_2_1 -pt None -u 0.07822560350569963 > ./result_10chains/node127_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_2 -p 250 -st topic127_3_1 -pt None -u 0.0010029425799426839 > ./result_10chains/node127_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_2 -p 256 -st topic127_4_1 -pt None -u 0.020283903087178923 > ./result_10chains/node127_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_2 -p 297 -st topic127_5_1 -pt None -u 0.0006280268587444404 > ./result_10chains/node127_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_6_2 -p 734 -st topic127_6_1 -pt None -u 0.009265083667474056 > ./result_10chains/node127_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_7_2 -p 847 -st topic127_7_1 -pt None -u 0.005709604500950385 > ./result_10chains/node127_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_8_2 -p 932 -st topic127_8_1 -pt None -u 0.026446182663118715 > ./result_10chains/node127_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_9_2 -p 972 -st topic127_9_1 -pt None -u 0.003908406737754891 > ./result_10chains/node127_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_0_0 -p 68 -st none -pt topic127_0_0 -u 0.026926994513489344 > ./result_10chains/node127_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_1_0 -p 84 -st none -pt topic127_1_0 -u 0.0283909074266403 > ./result_10chains/node127_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_2_0 -p 188 -st none -pt topic127_2_0 -u 0.005011057054774226 > ./result_10chains/node127_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_3_0 -p 250 -st none -pt topic127_3_0 -u 0.006558099905126236 > ./result_10chains/node127_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_4_0 -p 256 -st none -pt topic127_4_0 -u 0.01438128129197866 > ./result_10chains/node127_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_5_0 -p 297 -st none -pt topic127_5_0 -u 0.006993336064877731 > ./result_10chains/node127_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_6_0 -p 734 -st none -pt topic127_6_0 -u 0.02970591244125148 > ./result_10chains/node127_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_7_0 -p 847 -st none -pt topic127_7_0 -u 0.012204283306949934 > ./result_10chains/node127_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node127_8_0 -p 932 -st none -pt topic127_8_0 -u 0.002052830734153112 > ./result_10chains/node127_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node127_9_0 -p 972 -st none -pt topic127_9_0 -u 0.004581843268247114 > ./result_10chains/node127_9_0.txt &
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
    "./result_10chains/node127_0_0.txt 90"
    "./result_10chains/node127_0_2.txt 90"
    "./result_10chains/node127_1_0.txt 89"
    "./result_10chains/node127_1_2.txt 89"
    "./result_10chains/node127_2_0.txt 88"
    "./result_10chains/node127_2_2.txt 88"
    "./result_10chains/node127_3_0.txt 87"
    "./result_10chains/node127_3_2.txt 87"
    "./result_10chains/node127_4_0.txt 86"
    "./result_10chains/node127_4_2.txt 86"
    "./result_10chains/node127_5_0.txt 85"
    "./result_10chains/node127_5_2.txt 85"
    "./result_10chains/node127_6_0.txt 84"
    "./result_10chains/node127_6_2.txt 84"
    "./result_10chains/node127_7_0.txt 83"
    "./result_10chains/node127_7_2.txt 83"
    "./result_10chains/node127_8_0.txt 82"
    "./result_10chains/node127_8_2.txt 82"
    "./result_10chains/node127_9_0.txt 81"
    "./result_10chains/node127_9_2.txt 81"
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
