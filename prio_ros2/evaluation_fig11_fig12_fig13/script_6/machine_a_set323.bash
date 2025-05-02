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
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_2 -p 59 -st topic323_0_1 -pt None -u 0.01919122751221025 > ./result_6chains/node323_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_2 -p 229 -st topic323_1_1 -pt None -u 0.01398186897350534 > ./result_6chains/node323_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_2 -p 552 -st topic323_2_1 -pt None -u 0.009560309229876496 > ./result_6chains/node323_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_2 -p 559 -st topic323_3_1 -pt None -u 0.011130454763363495 > ./result_6chains/node323_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_2 -p 631 -st topic323_4_1 -pt None -u 0.0709146731913643 > ./result_6chains/node323_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_2 -p 994 -st topic323_5_1 -pt None -u 0.00862918610284311 > ./result_6chains/node323_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_0 -p 59 -st none -pt topic323_0_0 -u 0.0035802515986600447 > ./result_6chains/node323_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_0 -p 229 -st none -pt topic323_1_0 -u 0.00451951415315216 > ./result_6chains/node323_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_0 -p 552 -st none -pt topic323_2_0 -u 0.005080504796188268 > ./result_6chains/node323_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_0 -p 559 -st none -pt topic323_3_0 -u 0.062214987429156765 > ./result_6chains/node323_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_0 -p 631 -st none -pt topic323_4_0 -u 0.06526824511692708 > ./result_6chains/node323_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_0 -p 994 -st none -pt topic323_5_0 -u 0.08200337047847822 > ./result_6chains/node323_5_0.txt &
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
    "./result_6chains/node323_0_0.txt 90"
    "./result_6chains/node323_0_2.txt 90"
    "./result_6chains/node323_1_0.txt 89"
    "./result_6chains/node323_1_2.txt 89"
    "./result_6chains/node323_2_0.txt 88"
    "./result_6chains/node323_2_2.txt 88"
    "./result_6chains/node323_3_0.txt 87"
    "./result_6chains/node323_3_2.txt 87"
    "./result_6chains/node323_4_0.txt 86"
    "./result_6chains/node323_4_2.txt 86"
    "./result_6chains/node323_5_0.txt 85"
    "./result_6chains/node323_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
