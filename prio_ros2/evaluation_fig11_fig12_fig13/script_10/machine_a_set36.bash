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
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_2 -p 218 -st topic36_0_1 -pt None -u 0.019400380364521297 > ./result_10chains/node36_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_2 -p 278 -st topic36_1_1 -pt None -u 0.03598920805304179 > ./result_10chains/node36_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_2 -p 314 -st topic36_2_1 -pt None -u 0.01085422515215062 > ./result_10chains/node36_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_2 -p 373 -st topic36_3_1 -pt None -u 0.00015241093969470265 > ./result_10chains/node36_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_2 -p 485 -st topic36_4_1 -pt None -u 0.010759188787775875 > ./result_10chains/node36_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_2 -p 775 -st topic36_5_1 -pt None -u 0.027274640130821676 > ./result_10chains/node36_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_6_2 -p 803 -st topic36_6_1 -pt None -u 0.009201223696763905 > ./result_10chains/node36_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_7_2 -p 848 -st topic36_7_1 -pt None -u 0.010618286146646838 > ./result_10chains/node36_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_8_2 -p 915 -st topic36_8_1 -pt None -u 0.02369970730598253 > ./result_10chains/node36_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_9_2 -p 977 -st topic36_9_1 -pt None -u 0.0274379512138408 > ./result_10chains/node36_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_0_0 -p 218 -st none -pt topic36_0_0 -u 0.02545743046842086 > ./result_10chains/node36_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_1_0 -p 278 -st none -pt topic36_1_0 -u 0.004433443722612507 > ./result_10chains/node36_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_2_0 -p 314 -st none -pt topic36_2_0 -u 0.008226860900771904 > ./result_10chains/node36_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_3_0 -p 373 -st none -pt topic36_3_0 -u 0.02748516282308927 > ./result_10chains/node36_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_4_0 -p 485 -st none -pt topic36_4_0 -u 0.009603899271767191 > ./result_10chains/node36_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_5_0 -p 775 -st none -pt topic36_5_0 -u 0.004960060294272206 > ./result_10chains/node36_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_6_0 -p 803 -st none -pt topic36_6_0 -u 0.0016976669285430068 > ./result_10chains/node36_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_7_0 -p 848 -st none -pt topic36_7_0 -u 0.01672830105096451 > ./result_10chains/node36_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node36_8_0 -p 915 -st none -pt topic36_8_0 -u 0.03445852513878425 > ./result_10chains/node36_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node36_9_0 -p 977 -st none -pt topic36_9_0 -u 0.011049141325913225 > ./result_10chains/node36_9_0.txt &
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
    "./result_10chains/node36_0_0.txt 90"
    "./result_10chains/node36_0_2.txt 90"
    "./result_10chains/node36_1_0.txt 89"
    "./result_10chains/node36_1_2.txt 89"
    "./result_10chains/node36_2_0.txt 88"
    "./result_10chains/node36_2_2.txt 88"
    "./result_10chains/node36_3_0.txt 87"
    "./result_10chains/node36_3_2.txt 87"
    "./result_10chains/node36_4_0.txt 86"
    "./result_10chains/node36_4_2.txt 86"
    "./result_10chains/node36_5_0.txt 85"
    "./result_10chains/node36_5_2.txt 85"
    "./result_10chains/node36_6_0.txt 84"
    "./result_10chains/node36_6_2.txt 84"
    "./result_10chains/node36_7_0.txt 83"
    "./result_10chains/node36_7_2.txt 83"
    "./result_10chains/node36_8_0.txt 82"
    "./result_10chains/node36_8_2.txt 82"
    "./result_10chains/node36_9_0.txt 81"
    "./result_10chains/node36_9_2.txt 81"
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
