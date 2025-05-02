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
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_2 -p 110 -st topic455_0_1 -pt None -u 0.013924436589332123 > ./result_10chains/node455_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_2 -p 186 -st topic455_1_1 -pt None -u 0.004413455418772305 > ./result_10chains/node455_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_2 -p 564 -st topic455_2_1 -pt None -u 0.002317418313125541 > ./result_10chains/node455_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_2 -p 688 -st topic455_3_1 -pt None -u 1.872454088935882e-05 > ./result_10chains/node455_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_2 -p 696 -st topic455_4_1 -pt None -u 0.014319820595332045 > ./result_10chains/node455_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_2 -p 762 -st topic455_5_1 -pt None -u 0.014891635019823435 > ./result_10chains/node455_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_6_2 -p 766 -st topic455_6_1 -pt None -u 0.007928937013968518 > ./result_10chains/node455_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_7_2 -p 830 -st topic455_7_1 -pt None -u 0.015175406384423301 > ./result_10chains/node455_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_8_2 -p 867 -st topic455_8_1 -pt None -u 0.023286771355701237 > ./result_10chains/node455_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_9_2 -p 963 -st topic455_9_1 -pt None -u 0.020231841593481147 > ./result_10chains/node455_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_0 -p 110 -st none -pt topic455_0_0 -u 0.004930732737475796 > ./result_10chains/node455_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_0 -p 186 -st none -pt topic455_1_0 -u 0.007128690692253914 > ./result_10chains/node455_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_0 -p 564 -st none -pt topic455_2_0 -u 0.004364262744976866 > ./result_10chains/node455_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_0 -p 688 -st none -pt topic455_3_0 -u 0.028313740003305388 > ./result_10chains/node455_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_0 -p 696 -st none -pt topic455_4_0 -u 0.000698334103761078 > ./result_10chains/node455_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_0 -p 762 -st none -pt topic455_5_0 -u 0.04921563818611177 > ./result_10chains/node455_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_6_0 -p 766 -st none -pt topic455_6_0 -u 0.0039693417711298695 > ./result_10chains/node455_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_7_0 -p 830 -st none -pt topic455_7_0 -u 0.003738046703083253 > ./result_10chains/node455_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_8_0 -p 867 -st none -pt topic455_8_0 -u 0.0786233860987207 > ./result_10chains/node455_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_9_0 -p 963 -st none -pt topic455_9_0 -u 0.0027044292751300797 > ./result_10chains/node455_9_0.txt &
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
    "./result_10chains/node455_0_0.txt 90"
    "./result_10chains/node455_0_2.txt 90"
    "./result_10chains/node455_1_0.txt 89"
    "./result_10chains/node455_1_2.txt 89"
    "./result_10chains/node455_2_0.txt 88"
    "./result_10chains/node455_2_2.txt 88"
    "./result_10chains/node455_3_0.txt 87"
    "./result_10chains/node455_3_2.txt 87"
    "./result_10chains/node455_4_0.txt 86"
    "./result_10chains/node455_4_2.txt 86"
    "./result_10chains/node455_5_0.txt 85"
    "./result_10chains/node455_5_2.txt 85"
    "./result_10chains/node455_6_0.txt 84"
    "./result_10chains/node455_6_2.txt 84"
    "./result_10chains/node455_7_0.txt 83"
    "./result_10chains/node455_7_2.txt 83"
    "./result_10chains/node455_8_0.txt 82"
    "./result_10chains/node455_8_2.txt 82"
    "./result_10chains/node455_9_0.txt 81"
    "./result_10chains/node455_9_2.txt 81"
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
