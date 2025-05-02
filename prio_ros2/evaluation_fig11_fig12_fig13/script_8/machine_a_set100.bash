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
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_2 -p 62 -st topic100_0_1 -pt None -u 0.025813718524848595 > ./result_8chains/node100_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_2 -p 209 -st topic100_1_1 -pt None -u 0.003895534368959619 > ./result_8chains/node100_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_2 -p 210 -st topic100_2_1 -pt None -u 0.04355436985273181 > ./result_8chains/node100_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_2 -p 325 -st topic100_3_1 -pt None -u 0.015712924343111057 > ./result_8chains/node100_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_2 -p 484 -st topic100_4_1 -pt None -u 0.02523851375332775 > ./result_8chains/node100_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_2 -p 555 -st topic100_5_1 -pt None -u 0.008014735237864057 > ./result_8chains/node100_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_6_2 -p 935 -st topic100_6_1 -pt None -u 0.05585674096917628 > ./result_8chains/node100_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_7_2 -p 949 -st topic100_7_1 -pt None -u 0.03202353835393706 > ./result_8chains/node100_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_0 -p 62 -st none -pt topic100_0_0 -u 0.01479860629315477 > ./result_8chains/node100_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_0 -p 209 -st none -pt topic100_1_0 -u 0.00037997637995873523 > ./result_8chains/node100_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_0 -p 210 -st none -pt topic100_2_0 -u 0.013728346310291295 > ./result_8chains/node100_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_0 -p 325 -st none -pt topic100_3_0 -u 0.036293560033404726 > ./result_8chains/node100_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_0 -p 484 -st none -pt topic100_4_0 -u 0.012716541835235462 > ./result_8chains/node100_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_0 -p 555 -st none -pt topic100_5_0 -u 0.03294915339467047 > ./result_8chains/node100_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_6_0 -p 935 -st none -pt topic100_6_0 -u 0.030889304614849622 > ./result_8chains/node100_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_7_0 -p 949 -st none -pt topic100_7_0 -u 0.03104852215565715 > ./result_8chains/node100_7_0.txt &
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
    "./result_8chains/node100_0_0.txt 90"
    "./result_8chains/node100_0_2.txt 90"
    "./result_8chains/node100_1_0.txt 89"
    "./result_8chains/node100_1_2.txt 89"
    "./result_8chains/node100_2_0.txt 88"
    "./result_8chains/node100_2_2.txt 88"
    "./result_8chains/node100_3_0.txt 87"
    "./result_8chains/node100_3_2.txt 87"
    "./result_8chains/node100_4_0.txt 86"
    "./result_8chains/node100_4_2.txt 86"
    "./result_8chains/node100_5_0.txt 85"
    "./result_8chains/node100_5_2.txt 85"
    "./result_8chains/node100_6_0.txt 84"
    "./result_8chains/node100_6_2.txt 84"
    "./result_8chains/node100_7_0.txt 83"
    "./result_8chains/node100_7_2.txt 83"
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
