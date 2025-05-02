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
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_2 -p 29 -st topic404_0_1 -pt None -u 0.017132833214937193 > ./result_10chains/node404_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_2 -p 313 -st topic404_1_1 -pt None -u 0.0347261658496143 > ./result_10chains/node404_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_2 -p 436 -st topic404_2_1 -pt None -u 0.04771724116111975 > ./result_10chains/node404_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_2 -p 564 -st topic404_3_1 -pt None -u 0.00954717870193078 > ./result_10chains/node404_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_2 -p 639 -st topic404_4_1 -pt None -u 8.009317203025446e-05 > ./result_10chains/node404_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_2 -p 658 -st topic404_5_1 -pt None -u 0.011606424320716513 > ./result_10chains/node404_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_6_2 -p 771 -st topic404_6_1 -pt None -u 0.0020189444402134993 > ./result_10chains/node404_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_7_2 -p 794 -st topic404_7_1 -pt None -u 0.0008786184329538371 > ./result_10chains/node404_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_8_2 -p 820 -st topic404_8_1 -pt None -u 0.024642340348134242 > ./result_10chains/node404_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_9_2 -p 919 -st topic404_9_1 -pt None -u 0.0026215922025779512 > ./result_10chains/node404_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_0 -p 29 -st none -pt topic404_0_0 -u 0.010283657287083525 > ./result_10chains/node404_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_0 -p 313 -st none -pt topic404_1_0 -u 0.02302073746335792 > ./result_10chains/node404_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_0 -p 436 -st none -pt topic404_2_0 -u 0.0012742423935462877 > ./result_10chains/node404_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_0 -p 564 -st none -pt topic404_3_0 -u 0.01283353670452908 > ./result_10chains/node404_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_0 -p 639 -st none -pt topic404_4_0 -u 0.002625663552155766 > ./result_10chains/node404_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_0 -p 658 -st none -pt topic404_5_0 -u 0.02576497583171722 > ./result_10chains/node404_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_6_0 -p 771 -st none -pt topic404_6_0 -u 0.005800079983346973 > ./result_10chains/node404_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_7_0 -p 794 -st none -pt topic404_7_0 -u 0.003826343150742234 > ./result_10chains/node404_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_8_0 -p 820 -st none -pt topic404_8_0 -u 0.07443228261922946 > ./result_10chains/node404_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_9_0 -p 919 -st none -pt topic404_9_0 -u 0.04887865872760487 > ./result_10chains/node404_9_0.txt &
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
    "./result_10chains/node404_0_0.txt 90"
    "./result_10chains/node404_0_2.txt 90"
    "./result_10chains/node404_1_0.txt 89"
    "./result_10chains/node404_1_2.txt 89"
    "./result_10chains/node404_2_0.txt 88"
    "./result_10chains/node404_2_2.txt 88"
    "./result_10chains/node404_3_0.txt 87"
    "./result_10chains/node404_3_2.txt 87"
    "./result_10chains/node404_4_0.txt 86"
    "./result_10chains/node404_4_2.txt 86"
    "./result_10chains/node404_5_0.txt 85"
    "./result_10chains/node404_5_2.txt 85"
    "./result_10chains/node404_6_0.txt 84"
    "./result_10chains/node404_6_2.txt 84"
    "./result_10chains/node404_7_0.txt 83"
    "./result_10chains/node404_7_2.txt 83"
    "./result_10chains/node404_8_0.txt 82"
    "./result_10chains/node404_8_2.txt 82"
    "./result_10chains/node404_9_0.txt 81"
    "./result_10chains/node404_9_2.txt 81"
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
