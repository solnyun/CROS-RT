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
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_2 -p 84 -st topic454_0_1 -pt None -u 0.01389321456757342 > ./result_8chains/node454_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_2 -p 186 -st topic454_1_1 -pt None -u 0.012490231764656357 > ./result_8chains/node454_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_2 -p 199 -st topic454_2_1 -pt None -u 0.0005098589087229044 > ./result_8chains/node454_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_2 -p 275 -st topic454_3_1 -pt None -u 0.006488359414016098 > ./result_8chains/node454_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_2 -p 368 -st topic454_4_1 -pt None -u 0.026198871129172296 > ./result_8chains/node454_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_2 -p 455 -st topic454_5_1 -pt None -u 0.031683295708931 > ./result_8chains/node454_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_6_2 -p 730 -st topic454_6_1 -pt None -u 0.08164638704850745 > ./result_8chains/node454_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_7_2 -p 772 -st topic454_7_1 -pt None -u 0.0036868631091220108 > ./result_8chains/node454_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_0 -p 84 -st none -pt topic454_0_0 -u 0.03893308585553251 > ./result_8chains/node454_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_0 -p 186 -st none -pt topic454_1_0 -u 0.04310796946713502 > ./result_8chains/node454_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_0 -p 199 -st none -pt topic454_2_0 -u 0.022861258376521087 > ./result_8chains/node454_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_0 -p 275 -st none -pt topic454_3_0 -u 0.013034381909308557 > ./result_8chains/node454_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_0 -p 368 -st none -pt topic454_4_0 -u 0.0007234732703504387 > ./result_8chains/node454_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_0 -p 455 -st none -pt topic454_5_0 -u 0.00847859886269381 > ./result_8chains/node454_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_6_0 -p 730 -st none -pt topic454_6_0 -u 0.0591428383824221 > ./result_8chains/node454_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_7_0 -p 772 -st none -pt topic454_7_0 -u 0.02594510440981141 > ./result_8chains/node454_7_0.txt &
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
    "./result_8chains/node454_0_0.txt 90"
    "./result_8chains/node454_0_2.txt 90"
    "./result_8chains/node454_1_0.txt 89"
    "./result_8chains/node454_1_2.txt 89"
    "./result_8chains/node454_2_0.txt 88"
    "./result_8chains/node454_2_2.txt 88"
    "./result_8chains/node454_3_0.txt 87"
    "./result_8chains/node454_3_2.txt 87"
    "./result_8chains/node454_4_0.txt 86"
    "./result_8chains/node454_4_2.txt 86"
    "./result_8chains/node454_5_0.txt 85"
    "./result_8chains/node454_5_2.txt 85"
    "./result_8chains/node454_6_0.txt 84"
    "./result_8chains/node454_6_2.txt 84"
    "./result_8chains/node454_7_0.txt 83"
    "./result_8chains/node454_7_2.txt 83"
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
