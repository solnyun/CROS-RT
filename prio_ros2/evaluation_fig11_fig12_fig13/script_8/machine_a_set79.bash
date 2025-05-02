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
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_2 -p 12 -st topic79_0_1 -pt None -u 0.019522793330507937 > ./result_8chains/node79_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_2 -p 84 -st topic79_1_1 -pt None -u 0.0018313447587113285 > ./result_8chains/node79_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_2 -p 255 -st topic79_2_1 -pt None -u 0.006711883599507418 > ./result_8chains/node79_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_2 -p 297 -st topic79_3_1 -pt None -u 0.03571412129395063 > ./result_8chains/node79_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_2 -p 488 -st topic79_4_1 -pt None -u 0.02220803352447656 > ./result_8chains/node79_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_2 -p 494 -st topic79_5_1 -pt None -u 0.0450766507486737 > ./result_8chains/node79_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_6_2 -p 624 -st topic79_6_1 -pt None -u 0.05428351562171155 > ./result_8chains/node79_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_7_2 -p 968 -st topic79_7_1 -pt None -u 0.0366660497458241 > ./result_8chains/node79_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_0 -p 12 -st none -pt topic79_0_0 -u 0.029138006153544282 > ./result_8chains/node79_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_0 -p 84 -st none -pt topic79_1_0 -u 0.031351042864267264 > ./result_8chains/node79_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_0 -p 255 -st none -pt topic79_2_0 -u 0.003619983244474656 > ./result_8chains/node79_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_0 -p 297 -st none -pt topic79_3_0 -u 0.01801777004313676 > ./result_8chains/node79_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_0 -p 488 -st none -pt topic79_4_0 -u 0.002494340109030546 > ./result_8chains/node79_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_0 -p 494 -st none -pt topic79_5_0 -u 0.000821340035204593 > ./result_8chains/node79_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_6_0 -p 624 -st none -pt topic79_6_0 -u 0.018359541529307216 > ./result_8chains/node79_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node79_7_0 -p 968 -st none -pt topic79_7_0 -u 0.009289829364961054 > ./result_8chains/node79_7_0.txt &
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
    "./result_8chains/node79_0_0.txt 90"
    "./result_8chains/node79_0_2.txt 90"
    "./result_8chains/node79_1_0.txt 89"
    "./result_8chains/node79_1_2.txt 89"
    "./result_8chains/node79_2_0.txt 88"
    "./result_8chains/node79_2_2.txt 88"
    "./result_8chains/node79_3_0.txt 87"
    "./result_8chains/node79_3_2.txt 87"
    "./result_8chains/node79_4_0.txt 86"
    "./result_8chains/node79_4_2.txt 86"
    "./result_8chains/node79_5_0.txt 85"
    "./result_8chains/node79_5_2.txt 85"
    "./result_8chains/node79_6_0.txt 84"
    "./result_8chains/node79_6_2.txt 84"
    "./result_8chains/node79_7_0.txt 83"
    "./result_8chains/node79_7_2.txt 83"
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
