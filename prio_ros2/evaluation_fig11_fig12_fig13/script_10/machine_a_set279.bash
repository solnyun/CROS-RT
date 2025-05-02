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
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_2 -p 51 -st topic279_0_1 -pt None -u 0.00805153239033346 > ./result_10chains/node279_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_2 -p 158 -st topic279_1_1 -pt None -u 0.0006405586729173463 > ./result_10chains/node279_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_2 -p 483 -st topic279_2_1 -pt None -u 0.02217751583049482 > ./result_10chains/node279_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_2 -p 518 -st topic279_3_1 -pt None -u 0.04104285722503126 > ./result_10chains/node279_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_2 -p 554 -st topic279_4_1 -pt None -u 0.004937018465221432 > ./result_10chains/node279_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_2 -p 764 -st topic279_5_1 -pt None -u 0.008833891489730128 > ./result_10chains/node279_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_6_2 -p 775 -st topic279_6_1 -pt None -u 0.0004539394898000898 > ./result_10chains/node279_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_7_2 -p 863 -st topic279_7_1 -pt None -u 0.017918998688772232 > ./result_10chains/node279_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_8_2 -p 894 -st topic279_8_1 -pt None -u 0.0034572454193605093 > ./result_10chains/node279_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_9_2 -p 931 -st topic279_9_1 -pt None -u 0.020795131147927127 > ./result_10chains/node279_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_0 -p 51 -st none -pt topic279_0_0 -u 0.025199783990323465 > ./result_10chains/node279_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_0 -p 158 -st none -pt topic279_1_0 -u 0.024057973720618964 > ./result_10chains/node279_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_0 -p 483 -st none -pt topic279_2_0 -u 0.01176650760377429 > ./result_10chains/node279_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_0 -p 518 -st none -pt topic279_3_0 -u 0.0019254002213967558 > ./result_10chains/node279_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_0 -p 554 -st none -pt topic279_4_0 -u 0.024279666092501095 > ./result_10chains/node279_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_0 -p 764 -st none -pt topic279_5_0 -u 0.006581099124284312 > ./result_10chains/node279_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_6_0 -p 775 -st none -pt topic279_6_0 -u 0.04099517471020088 > ./result_10chains/node279_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_7_0 -p 863 -st none -pt topic279_7_0 -u 0.00802024260586591 > ./result_10chains/node279_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_8_0 -p 894 -st none -pt topic279_8_0 -u 0.007486016856490828 > ./result_10chains/node279_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_9_0 -p 931 -st none -pt topic279_9_0 -u 0.0006403345104431177 > ./result_10chains/node279_9_0.txt &
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
    "./result_10chains/node279_0_0.txt 90"
    "./result_10chains/node279_0_2.txt 90"
    "./result_10chains/node279_1_0.txt 89"
    "./result_10chains/node279_1_2.txt 89"
    "./result_10chains/node279_2_0.txt 88"
    "./result_10chains/node279_2_2.txt 88"
    "./result_10chains/node279_3_0.txt 87"
    "./result_10chains/node279_3_2.txt 87"
    "./result_10chains/node279_4_0.txt 86"
    "./result_10chains/node279_4_2.txt 86"
    "./result_10chains/node279_5_0.txt 85"
    "./result_10chains/node279_5_2.txt 85"
    "./result_10chains/node279_6_0.txt 84"
    "./result_10chains/node279_6_2.txt 84"
    "./result_10chains/node279_7_0.txt 83"
    "./result_10chains/node279_7_2.txt 83"
    "./result_10chains/node279_8_0.txt 82"
    "./result_10chains/node279_8_2.txt 82"
    "./result_10chains/node279_9_0.txt 81"
    "./result_10chains/node279_9_2.txt 81"
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
