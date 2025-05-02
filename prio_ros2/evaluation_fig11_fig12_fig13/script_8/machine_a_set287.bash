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
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_2 -p 87 -st topic287_0_1 -pt None -u 0.0003870539776650306 > ./result_8chains/node287_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_2 -p 194 -st topic287_1_1 -pt None -u 0.016178891017321673 > ./result_8chains/node287_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_2 -p 241 -st topic287_2_1 -pt None -u 0.02514144564866916 > ./result_8chains/node287_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_2 -p 484 -st topic287_3_1 -pt None -u 0.006397463150603022 > ./result_8chains/node287_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_2 -p 596 -st topic287_4_1 -pt None -u 0.00433202024889498 > ./result_8chains/node287_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_2 -p 676 -st topic287_5_1 -pt None -u 0.03649053112805853 > ./result_8chains/node287_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_6_2 -p 724 -st topic287_6_1 -pt None -u 0.04314560687408375 > ./result_8chains/node287_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_7_2 -p 786 -st topic287_7_1 -pt None -u 0.049102668213281395 > ./result_8chains/node287_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_0 -p 87 -st none -pt topic287_0_0 -u 0.020319791832970724 > ./result_8chains/node287_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_0 -p 194 -st none -pt topic287_1_0 -u 0.035406003394943986 > ./result_8chains/node287_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_0 -p 241 -st none -pt topic287_2_0 -u 0.047735749418851725 > ./result_8chains/node287_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_0 -p 484 -st none -pt topic287_3_0 -u 0.01017121238710117 > ./result_8chains/node287_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_0 -p 596 -st none -pt topic287_4_0 -u 0.014752000813007982 > ./result_8chains/node287_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_0 -p 676 -st none -pt topic287_5_0 -u 0.022312110312862038 > ./result_8chains/node287_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_6_0 -p 724 -st none -pt topic287_6_0 -u 0.002683769348389181 > ./result_8chains/node287_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_7_0 -p 786 -st none -pt topic287_7_0 -u 0.005615049771564684 > ./result_8chains/node287_7_0.txt &
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
    "./result_8chains/node287_0_0.txt 90"
    "./result_8chains/node287_0_2.txt 90"
    "./result_8chains/node287_1_0.txt 89"
    "./result_8chains/node287_1_2.txt 89"
    "./result_8chains/node287_2_0.txt 88"
    "./result_8chains/node287_2_2.txt 88"
    "./result_8chains/node287_3_0.txt 87"
    "./result_8chains/node287_3_2.txt 87"
    "./result_8chains/node287_4_0.txt 86"
    "./result_8chains/node287_4_2.txt 86"
    "./result_8chains/node287_5_0.txt 85"
    "./result_8chains/node287_5_2.txt 85"
    "./result_8chains/node287_6_0.txt 84"
    "./result_8chains/node287_6_2.txt 84"
    "./result_8chains/node287_7_0.txt 83"
    "./result_8chains/node287_7_2.txt 83"
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
