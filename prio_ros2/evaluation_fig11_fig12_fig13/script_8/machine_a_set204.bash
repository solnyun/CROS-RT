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
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_2 -p 55 -st topic204_0_1 -pt None -u 0.03959585326359 > ./result_8chains/node204_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_2 -p 118 -st topic204_1_1 -pt None -u 0.0064637031850438564 > ./result_8chains/node204_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_2 -p 137 -st topic204_2_1 -pt None -u 0.0026309404496475675 > ./result_8chains/node204_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_2 -p 301 -st topic204_3_1 -pt None -u 0.011724755299195422 > ./result_8chains/node204_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_2 -p 410 -st topic204_4_1 -pt None -u 0.032200623115197224 > ./result_8chains/node204_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_2 -p 511 -st topic204_5_1 -pt None -u 0.002762872393715546 > ./result_8chains/node204_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_6_2 -p 951 -st topic204_6_1 -pt None -u 0.0015234053569711456 > ./result_8chains/node204_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_7_2 -p 990 -st topic204_7_1 -pt None -u 0.0008395115225944468 > ./result_8chains/node204_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_0 -p 55 -st none -pt topic204_0_0 -u 0.017116942824031756 > ./result_8chains/node204_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_0 -p 118 -st none -pt topic204_1_0 -u 0.03303114634978194 > ./result_8chains/node204_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_0 -p 137 -st none -pt topic204_2_0 -u 0.002468935946820572 > ./result_8chains/node204_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_0 -p 301 -st none -pt topic204_3_0 -u 0.013212145056691993 > ./result_8chains/node204_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_0 -p 410 -st none -pt topic204_4_0 -u 0.04265790936483485 > ./result_8chains/node204_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_0 -p 511 -st none -pt topic204_5_0 -u 0.0045957839618438745 > ./result_8chains/node204_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_6_0 -p 951 -st none -pt topic204_6_0 -u 0.019231965848950372 > ./result_8chains/node204_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_7_0 -p 990 -st none -pt topic204_7_0 -u 0.025436618181011863 > ./result_8chains/node204_7_0.txt &
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
    "./result_8chains/node204_0_0.txt 90"
    "./result_8chains/node204_0_2.txt 90"
    "./result_8chains/node204_1_0.txt 89"
    "./result_8chains/node204_1_2.txt 89"
    "./result_8chains/node204_2_0.txt 88"
    "./result_8chains/node204_2_2.txt 88"
    "./result_8chains/node204_3_0.txt 87"
    "./result_8chains/node204_3_2.txt 87"
    "./result_8chains/node204_4_0.txt 86"
    "./result_8chains/node204_4_2.txt 86"
    "./result_8chains/node204_5_0.txt 85"
    "./result_8chains/node204_5_2.txt 85"
    "./result_8chains/node204_6_0.txt 84"
    "./result_8chains/node204_6_2.txt 84"
    "./result_8chains/node204_7_0.txt 83"
    "./result_8chains/node204_7_2.txt 83"
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
