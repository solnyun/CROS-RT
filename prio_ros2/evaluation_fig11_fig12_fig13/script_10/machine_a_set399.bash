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
ros2 run evaluation_3_randomdag uunifast_node -n node399_0_2 -p 12 -st topic399_0_1 -pt None -u 0.001969017014798069 > ./result_10chains/node399_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_1_2 -p 101 -st topic399_1_1 -pt None -u 0.0046867141967129045 > ./result_10chains/node399_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_2_2 -p 129 -st topic399_2_1 -pt None -u 0.00522058956674637 > ./result_10chains/node399_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_3_2 -p 155 -st topic399_3_1 -pt None -u 0.021130639864728296 > ./result_10chains/node399_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_4_2 -p 164 -st topic399_4_1 -pt None -u 0.0034568941496080363 > ./result_10chains/node399_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_5_2 -p 332 -st topic399_5_1 -pt None -u 0.0019591223777019884 > ./result_10chains/node399_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_6_2 -p 359 -st topic399_6_1 -pt None -u 0.020009161821948285 > ./result_10chains/node399_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_7_2 -p 405 -st topic399_7_1 -pt None -u 0.029716429152205376 > ./result_10chains/node399_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_8_2 -p 424 -st topic399_8_1 -pt None -u 0.036390131073442564 > ./result_10chains/node399_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_9_2 -p 824 -st topic399_9_1 -pt None -u 0.01928370648835876 > ./result_10chains/node399_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_0_0 -p 12 -st none -pt topic399_0_0 -u 0.02296462880760164 > ./result_10chains/node399_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_1_0 -p 101 -st none -pt topic399_1_0 -u 0.007662262582469881 > ./result_10chains/node399_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_2_0 -p 129 -st none -pt topic399_2_0 -u 0.03485469088092186 > ./result_10chains/node399_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_3_0 -p 155 -st none -pt topic399_3_0 -u 0.007782161495109963 > ./result_10chains/node399_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_4_0 -p 164 -st none -pt topic399_4_0 -u 0.017353443063041374 > ./result_10chains/node399_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_5_0 -p 332 -st none -pt topic399_5_0 -u 0.01113865022812735 > ./result_10chains/node399_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_6_0 -p 359 -st none -pt topic399_6_0 -u 0.01308149625327773 > ./result_10chains/node399_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_7_0 -p 405 -st none -pt topic399_7_0 -u 0.015991153619974857 > ./result_10chains/node399_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node399_8_0 -p 424 -st none -pt topic399_8_0 -u 0.0024887791792057856 > ./result_10chains/node399_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node399_9_0 -p 824 -st none -pt topic399_9_0 -u 0.055511120949870804 > ./result_10chains/node399_9_0.txt &
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
    "./result_10chains/node399_0_0.txt 90"
    "./result_10chains/node399_0_2.txt 90"
    "./result_10chains/node399_1_0.txt 89"
    "./result_10chains/node399_1_2.txt 89"
    "./result_10chains/node399_2_0.txt 88"
    "./result_10chains/node399_2_2.txt 88"
    "./result_10chains/node399_3_0.txt 87"
    "./result_10chains/node399_3_2.txt 87"
    "./result_10chains/node399_4_0.txt 86"
    "./result_10chains/node399_4_2.txt 86"
    "./result_10chains/node399_5_0.txt 85"
    "./result_10chains/node399_5_2.txt 85"
    "./result_10chains/node399_6_0.txt 84"
    "./result_10chains/node399_6_2.txt 84"
    "./result_10chains/node399_7_0.txt 83"
    "./result_10chains/node399_7_2.txt 83"
    "./result_10chains/node399_8_0.txt 82"
    "./result_10chains/node399_8_2.txt 82"
    "./result_10chains/node399_9_0.txt 81"
    "./result_10chains/node399_9_2.txt 81"
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
