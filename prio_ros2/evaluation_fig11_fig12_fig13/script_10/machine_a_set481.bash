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
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_2 -p 60 -st topic481_0_1 -pt None -u 0.0028552274499155095 > ./result_10chains/node481_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_2 -p 146 -st topic481_1_1 -pt None -u 0.042984224727592 > ./result_10chains/node481_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_2 -p 204 -st topic481_2_1 -pt None -u 0.0007240831274621939 > ./result_10chains/node481_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_2 -p 248 -st topic481_3_1 -pt None -u 0.016370773933415267 > ./result_10chains/node481_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_2 -p 361 -st topic481_4_1 -pt None -u 0.004309748752910264 > ./result_10chains/node481_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_2 -p 396 -st topic481_5_1 -pt None -u 0.0033590878283099868 > ./result_10chains/node481_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_6_2 -p 420 -st topic481_6_1 -pt None -u 0.003508888797341736 > ./result_10chains/node481_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_7_2 -p 619 -st topic481_7_1 -pt None -u 0.013258617705092887 > ./result_10chains/node481_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_8_2 -p 879 -st topic481_8_1 -pt None -u 0.011192628966282314 > ./result_10chains/node481_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_9_2 -p 982 -st topic481_9_1 -pt None -u 0.010148008918953857 > ./result_10chains/node481_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_0_0 -p 60 -st none -pt topic481_0_0 -u 0.027820977925870904 > ./result_10chains/node481_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_1_0 -p 146 -st none -pt topic481_1_0 -u 0.002854946872058395 > ./result_10chains/node481_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_2_0 -p 204 -st none -pt topic481_2_0 -u 0.03634476009645782 > ./result_10chains/node481_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_3_0 -p 248 -st none -pt topic481_3_0 -u 0.027205634124932432 > ./result_10chains/node481_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_4_0 -p 361 -st none -pt topic481_4_0 -u 0.006989061749621328 > ./result_10chains/node481_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_5_0 -p 396 -st none -pt topic481_5_0 -u 0.04458712835986811 > ./result_10chains/node481_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_6_0 -p 420 -st none -pt topic481_6_0 -u 0.01420528021622991 > ./result_10chains/node481_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_7_0 -p 619 -st none -pt topic481_7_0 -u 0.009072169787597964 > ./result_10chains/node481_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node481_8_0 -p 879 -st none -pt topic481_8_0 -u 0.0072107414889964055 > ./result_10chains/node481_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node481_9_0 -p 982 -st none -pt topic481_9_0 -u 0.017601448601802308 > ./result_10chains/node481_9_0.txt &
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
    "./result_10chains/node481_0_0.txt 90"
    "./result_10chains/node481_0_2.txt 90"
    "./result_10chains/node481_1_0.txt 89"
    "./result_10chains/node481_1_2.txt 89"
    "./result_10chains/node481_2_0.txt 88"
    "./result_10chains/node481_2_2.txt 88"
    "./result_10chains/node481_3_0.txt 87"
    "./result_10chains/node481_3_2.txt 87"
    "./result_10chains/node481_4_0.txt 86"
    "./result_10chains/node481_4_2.txt 86"
    "./result_10chains/node481_5_0.txt 85"
    "./result_10chains/node481_5_2.txt 85"
    "./result_10chains/node481_6_0.txt 84"
    "./result_10chains/node481_6_2.txt 84"
    "./result_10chains/node481_7_0.txt 83"
    "./result_10chains/node481_7_2.txt 83"
    "./result_10chains/node481_8_0.txt 82"
    "./result_10chains/node481_8_2.txt 82"
    "./result_10chains/node481_9_0.txt 81"
    "./result_10chains/node481_9_2.txt 81"
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
