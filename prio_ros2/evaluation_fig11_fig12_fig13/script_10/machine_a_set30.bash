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
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_2 -p 26 -st topic30_0_1 -pt None -u 0.0032889362694128454 > ./result_10chains/node30_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_2 -p 59 -st topic30_1_1 -pt None -u 0.010191234157074902 > ./result_10chains/node30_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_2 -p 349 -st topic30_2_1 -pt None -u 0.00552507823204057 > ./result_10chains/node30_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_2 -p 431 -st topic30_3_1 -pt None -u 0.006127499254618196 > ./result_10chains/node30_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_2 -p 641 -st topic30_4_1 -pt None -u 0.04758035140984379 > ./result_10chains/node30_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_2 -p 702 -st topic30_5_1 -pt None -u 0.025301689399529564 > ./result_10chains/node30_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_6_2 -p 875 -st topic30_6_1 -pt None -u 0.013266480319935353 > ./result_10chains/node30_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_7_2 -p 884 -st topic30_7_1 -pt None -u 0.008108086157113364 > ./result_10chains/node30_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_8_2 -p 928 -st topic30_8_1 -pt None -u 0.04760830549828833 > ./result_10chains/node30_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_9_2 -p 965 -st topic30_9_1 -pt None -u 0.007163439994574164 > ./result_10chains/node30_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_0 -p 26 -st none -pt topic30_0_0 -u 0.000981171398265479 > ./result_10chains/node30_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_0 -p 59 -st none -pt topic30_1_0 -u 0.0413813895463217 > ./result_10chains/node30_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_0 -p 349 -st none -pt topic30_2_0 -u 0.010478602640505208 > ./result_10chains/node30_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_0 -p 431 -st none -pt topic30_3_0 -u 0.014933157049955903 > ./result_10chains/node30_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_0 -p 641 -st none -pt topic30_4_0 -u 0.02253585040259143 > ./result_10chains/node30_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_0 -p 702 -st none -pt topic30_5_0 -u 0.0025124940569101195 > ./result_10chains/node30_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_6_0 -p 875 -st none -pt topic30_6_0 -u 0.0003147360394848697 > ./result_10chains/node30_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_7_0 -p 884 -st none -pt topic30_7_0 -u 0.012902989612804089 > ./result_10chains/node30_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_8_0 -p 928 -st none -pt topic30_8_0 -u 0.00365035567592345 > ./result_10chains/node30_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_9_0 -p 965 -st none -pt topic30_9_0 -u 0.009758951653890246 > ./result_10chains/node30_9_0.txt &
sleep 10
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
    "./result_10chains/node30_0_0.txt 90"
    "./result_10chains/node30_0_2.txt 90"
    "./result_10chains/node30_1_0.txt 89"
    "./result_10chains/node30_1_2.txt 89"
    "./result_10chains/node30_2_0.txt 88"
    "./result_10chains/node30_2_2.txt 88"
    "./result_10chains/node30_3_0.txt 87"
    "./result_10chains/node30_3_2.txt 87"
    "./result_10chains/node30_4_0.txt 86"
    "./result_10chains/node30_4_2.txt 86"
    "./result_10chains/node30_5_0.txt 85"
    "./result_10chains/node30_5_2.txt 85"
    "./result_10chains/node30_6_0.txt 84"
    "./result_10chains/node30_6_2.txt 84"
    "./result_10chains/node30_7_0.txt 83"
    "./result_10chains/node30_7_2.txt 83"
    "./result_10chains/node30_8_0.txt 82"
    "./result_10chains/node30_8_2.txt 82"
    "./result_10chains/node30_9_0.txt 81"
    "./result_10chains/node30_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
