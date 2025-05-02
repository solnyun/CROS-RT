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
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_2 -p 129 -st topic425_0_1 -pt None -u 0.00840667087958924 > ./result_8chains/node425_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_2 -p 255 -st topic425_1_1 -pt None -u 0.003177185840828156 > ./result_8chains/node425_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_2 -p 383 -st topic425_2_1 -pt None -u 0.03281200573073351 > ./result_8chains/node425_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_2 -p 580 -st topic425_3_1 -pt None -u 0.014941435375579182 > ./result_8chains/node425_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_2 -p 587 -st topic425_4_1 -pt None -u 0.05211482322094582 > ./result_8chains/node425_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_2 -p 739 -st topic425_5_1 -pt None -u 0.01725667706866063 > ./result_8chains/node425_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_6_2 -p 964 -st topic425_6_1 -pt None -u 0.04673131826699233 > ./result_8chains/node425_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_7_2 -p 986 -st topic425_7_1 -pt None -u 0.035481907624258145 > ./result_8chains/node425_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_0 -p 129 -st none -pt topic425_0_0 -u 0.031333936167399046 > ./result_8chains/node425_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_0 -p 255 -st none -pt topic425_1_0 -u 0.031189346861859313 > ./result_8chains/node425_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_0 -p 383 -st none -pt topic425_2_0 -u 0.013727881949677445 > ./result_8chains/node425_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_0 -p 580 -st none -pt topic425_3_0 -u 0.004715418723546472 > ./result_8chains/node425_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_0 -p 587 -st none -pt topic425_4_0 -u 0.009727072244164081 > ./result_8chains/node425_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_0 -p 739 -st none -pt topic425_5_0 -u 0.019273698549687746 > ./result_8chains/node425_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_6_0 -p 964 -st none -pt topic425_6_0 -u 0.001597782737016079 > ./result_8chains/node425_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node425_7_0 -p 986 -st none -pt topic425_7_0 -u 0.005891706996259342 > ./result_8chains/node425_7_0.txt &
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
    "./result_8chains/node425_0_0.txt 90"
    "./result_8chains/node425_0_2.txt 90"
    "./result_8chains/node425_1_0.txt 89"
    "./result_8chains/node425_1_2.txt 89"
    "./result_8chains/node425_2_0.txt 88"
    "./result_8chains/node425_2_2.txt 88"
    "./result_8chains/node425_3_0.txt 87"
    "./result_8chains/node425_3_2.txt 87"
    "./result_8chains/node425_4_0.txt 86"
    "./result_8chains/node425_4_2.txt 86"
    "./result_8chains/node425_5_0.txt 85"
    "./result_8chains/node425_5_2.txt 85"
    "./result_8chains/node425_6_0.txt 84"
    "./result_8chains/node425_6_2.txt 84"
    "./result_8chains/node425_7_0.txt 83"
    "./result_8chains/node425_7_2.txt 83"
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
