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
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_2 -p 174 -st topic59_0_1 -pt None -u 0.004918615327689002 > ./result_10chains/node59_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_2 -p 486 -st topic59_1_1 -pt None -u 0.06679332234641466 > ./result_10chains/node59_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_2 -p 528 -st topic59_2_1 -pt None -u 0.0042846094714997784 > ./result_10chains/node59_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_2 -p 656 -st topic59_3_1 -pt None -u 0.016934440676737272 > ./result_10chains/node59_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_2 -p 675 -st topic59_4_1 -pt None -u 0.0004296700615142035 > ./result_10chains/node59_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_2 -p 808 -st topic59_5_1 -pt None -u 0.0047858610515521816 > ./result_10chains/node59_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_6_2 -p 835 -st topic59_6_1 -pt None -u 0.030372377833960573 > ./result_10chains/node59_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_7_2 -p 953 -st topic59_7_1 -pt None -u 0.00848159468735818 > ./result_10chains/node59_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_8_2 -p 966 -st topic59_8_1 -pt None -u 0.012144610621895618 > ./result_10chains/node59_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_9_2 -p 996 -st topic59_9_1 -pt None -u 0.0014539048616947494 > ./result_10chains/node59_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_0 -p 174 -st none -pt topic59_0_0 -u 0.00257535392799213 > ./result_10chains/node59_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_0 -p 486 -st none -pt topic59_1_0 -u 0.0135208708763207 > ./result_10chains/node59_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_0 -p 528 -st none -pt topic59_2_0 -u 0.06545058482797056 > ./result_10chains/node59_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_0 -p 656 -st none -pt topic59_3_0 -u 0.00641268409330864 > ./result_10chains/node59_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_0 -p 675 -st none -pt topic59_4_0 -u 0.004511820430622204 > ./result_10chains/node59_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_0 -p 808 -st none -pt topic59_5_0 -u 0.0038821222416291212 > ./result_10chains/node59_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_6_0 -p 835 -st none -pt topic59_6_0 -u 0.007764848340602731 > ./result_10chains/node59_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_7_0 -p 953 -st none -pt topic59_7_0 -u 0.0010405032378561774 > ./result_10chains/node59_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_8_0 -p 966 -st none -pt topic59_8_0 -u 0.10720380371718033 > ./result_10chains/node59_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node59_9_0 -p 996 -st none -pt topic59_9_0 -u 0.012537970495479545 > ./result_10chains/node59_9_0.txt &
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
    "./result_10chains/node59_0_0.txt 90"
    "./result_10chains/node59_0_2.txt 90"
    "./result_10chains/node59_1_0.txt 89"
    "./result_10chains/node59_1_2.txt 89"
    "./result_10chains/node59_2_0.txt 88"
    "./result_10chains/node59_2_2.txt 88"
    "./result_10chains/node59_3_0.txt 87"
    "./result_10chains/node59_3_2.txt 87"
    "./result_10chains/node59_4_0.txt 86"
    "./result_10chains/node59_4_2.txt 86"
    "./result_10chains/node59_5_0.txt 85"
    "./result_10chains/node59_5_2.txt 85"
    "./result_10chains/node59_6_0.txt 84"
    "./result_10chains/node59_6_2.txt 84"
    "./result_10chains/node59_7_0.txt 83"
    "./result_10chains/node59_7_2.txt 83"
    "./result_10chains/node59_8_0.txt 82"
    "./result_10chains/node59_8_2.txt 82"
    "./result_10chains/node59_9_0.txt 81"
    "./result_10chains/node59_9_2.txt 81"
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
