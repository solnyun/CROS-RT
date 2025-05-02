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
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_2 -p 25 -st topic11_0_1 -pt None -u 0.031500771103438685 > ./result_8chains/node11_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_2 -p 272 -st topic11_1_1 -pt None -u 0.006508025066986112 > ./result_8chains/node11_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_2 -p 309 -st topic11_2_1 -pt None -u 0.012372651285039393 > ./result_8chains/node11_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_2 -p 395 -st topic11_3_1 -pt None -u 0.004676034318048861 > ./result_8chains/node11_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_2 -p 682 -st topic11_4_1 -pt None -u 0.017714913708416075 > ./result_8chains/node11_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_2 -p 727 -st topic11_5_1 -pt None -u 0.01880173903639623 > ./result_8chains/node11_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_6_2 -p 834 -st topic11_6_1 -pt None -u 0.06895574228186843 > ./result_8chains/node11_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_7_2 -p 944 -st topic11_7_1 -pt None -u 0.005278247219537931 > ./result_8chains/node11_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_0 -p 25 -st none -pt topic11_0_0 -u 0.009770764789061637 > ./result_8chains/node11_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_0 -p 272 -st none -pt topic11_1_0 -u 0.014149587787362916 > ./result_8chains/node11_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_0 -p 309 -st none -pt topic11_2_0 -u 0.005094401934307602 > ./result_8chains/node11_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_0 -p 395 -st none -pt topic11_3_0 -u 0.02774506489923867 > ./result_8chains/node11_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_0 -p 682 -st none -pt topic11_4_0 -u 0.016362405043438 > ./result_8chains/node11_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_0 -p 727 -st none -pt topic11_5_0 -u 0.06483035209741658 > ./result_8chains/node11_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_6_0 -p 834 -st none -pt topic11_6_0 -u 0.01930172246113268 > ./result_8chains/node11_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_7_0 -p 944 -st none -pt topic11_7_0 -u 0.011449855589254244 > ./result_8chains/node11_7_0.txt &
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
    "./result_8chains/node11_0_0.txt 90"
    "./result_8chains/node11_0_2.txt 90"
    "./result_8chains/node11_1_0.txt 89"
    "./result_8chains/node11_1_2.txt 89"
    "./result_8chains/node11_2_0.txt 88"
    "./result_8chains/node11_2_2.txt 88"
    "./result_8chains/node11_3_0.txt 87"
    "./result_8chains/node11_3_2.txt 87"
    "./result_8chains/node11_4_0.txt 86"
    "./result_8chains/node11_4_2.txt 86"
    "./result_8chains/node11_5_0.txt 85"
    "./result_8chains/node11_5_2.txt 85"
    "./result_8chains/node11_6_0.txt 84"
    "./result_8chains/node11_6_2.txt 84"
    "./result_8chains/node11_7_0.txt 83"
    "./result_8chains/node11_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
