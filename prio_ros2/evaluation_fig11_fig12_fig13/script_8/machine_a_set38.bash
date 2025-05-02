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
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_2 -p 182 -st topic38_0_1 -pt None -u 0.03959484898858728 > ./result_8chains/node38_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_2 -p 238 -st topic38_1_1 -pt None -u 0.033474689267877944 > ./result_8chains/node38_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_2 -p 547 -st topic38_2_1 -pt None -u 0.0003423304728261689 > ./result_8chains/node38_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_2 -p 623 -st topic38_3_1 -pt None -u 0.08308611291034296 > ./result_8chains/node38_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_2 -p 673 -st topic38_4_1 -pt None -u 0.035171997851295767 > ./result_8chains/node38_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_2 -p 688 -st topic38_5_1 -pt None -u 0.003221684124496832 > ./result_8chains/node38_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_6_2 -p 886 -st topic38_6_1 -pt None -u 0.03913166370145676 > ./result_8chains/node38_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_7_2 -p 962 -st topic38_7_1 -pt None -u 0.03156004919160778 > ./result_8chains/node38_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_0 -p 182 -st none -pt topic38_0_0 -u 0.012548529310114631 > ./result_8chains/node38_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_0 -p 238 -st none -pt topic38_1_0 -u 0.0038263367547223814 > ./result_8chains/node38_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_0 -p 547 -st none -pt topic38_2_0 -u 0.00058652590125291 > ./result_8chains/node38_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_0 -p 623 -st none -pt topic38_3_0 -u 0.000412542086616452 > ./result_8chains/node38_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_0 -p 673 -st none -pt topic38_4_0 -u 0.03663717265929933 > ./result_8chains/node38_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_0 -p 688 -st none -pt topic38_5_0 -u 0.016804570998299156 > ./result_8chains/node38_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_6_0 -p 886 -st none -pt topic38_6_0 -u 0.02712751547893376 > ./result_8chains/node38_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_7_0 -p 962 -st none -pt topic38_7_0 -u 0.00014646376146302403 > ./result_8chains/node38_7_0.txt &
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
    "./result_8chains/node38_0_0.txt 90"
    "./result_8chains/node38_0_2.txt 90"
    "./result_8chains/node38_1_0.txt 89"
    "./result_8chains/node38_1_2.txt 89"
    "./result_8chains/node38_2_0.txt 88"
    "./result_8chains/node38_2_2.txt 88"
    "./result_8chains/node38_3_0.txt 87"
    "./result_8chains/node38_3_2.txt 87"
    "./result_8chains/node38_4_0.txt 86"
    "./result_8chains/node38_4_2.txt 86"
    "./result_8chains/node38_5_0.txt 85"
    "./result_8chains/node38_5_2.txt 85"
    "./result_8chains/node38_6_0.txt 84"
    "./result_8chains/node38_6_2.txt 84"
    "./result_8chains/node38_7_0.txt 83"
    "./result_8chains/node38_7_2.txt 83"
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
