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
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_2 -p 94 -st topic271_0_1 -pt None -u 0.024768603083915708 > ./result_8chains/node271_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_2 -p 137 -st topic271_1_1 -pt None -u 0.007551969754621135 > ./result_8chains/node271_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_2 -p 363 -st topic271_2_1 -pt None -u 0.031947984412577124 > ./result_8chains/node271_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_2 -p 477 -st topic271_3_1 -pt None -u 0.03327165227185902 > ./result_8chains/node271_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_2 -p 506 -st topic271_4_1 -pt None -u 0.07905247432636303 > ./result_8chains/node271_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_2 -p 545 -st topic271_5_1 -pt None -u 0.004151147657486254 > ./result_8chains/node271_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_6_2 -p 606 -st topic271_6_1 -pt None -u 0.015966191424405363 > ./result_8chains/node271_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_7_2 -p 934 -st topic271_7_1 -pt None -u 0.0067824920590563356 > ./result_8chains/node271_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_0 -p 94 -st none -pt topic271_0_0 -u 0.019461609939059543 > ./result_8chains/node271_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_0 -p 137 -st none -pt topic271_1_0 -u 0.0018674473465908337 > ./result_8chains/node271_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_0 -p 363 -st none -pt topic271_2_0 -u 0.0008522529832298842 > ./result_8chains/node271_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_0 -p 477 -st none -pt topic271_3_0 -u 0.0004975721521811582 > ./result_8chains/node271_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_0 -p 506 -st none -pt topic271_4_0 -u 0.0029355902241100518 > ./result_8chains/node271_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_0 -p 545 -st none -pt topic271_5_0 -u 0.0066377668375424415 > ./result_8chains/node271_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_6_0 -p 606 -st none -pt topic271_6_0 -u 0.031255759027780106 > ./result_8chains/node271_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_7_0 -p 934 -st none -pt topic271_7_0 -u 0.06755226546137674 > ./result_8chains/node271_7_0.txt &
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
    "./result_8chains/node271_0_0.txt 90"
    "./result_8chains/node271_0_2.txt 90"
    "./result_8chains/node271_1_0.txt 89"
    "./result_8chains/node271_1_2.txt 89"
    "./result_8chains/node271_2_0.txt 88"
    "./result_8chains/node271_2_2.txt 88"
    "./result_8chains/node271_3_0.txt 87"
    "./result_8chains/node271_3_2.txt 87"
    "./result_8chains/node271_4_0.txt 86"
    "./result_8chains/node271_4_2.txt 86"
    "./result_8chains/node271_5_0.txt 85"
    "./result_8chains/node271_5_2.txt 85"
    "./result_8chains/node271_6_0.txt 84"
    "./result_8chains/node271_6_2.txt 84"
    "./result_8chains/node271_7_0.txt 83"
    "./result_8chains/node271_7_2.txt 83"
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
