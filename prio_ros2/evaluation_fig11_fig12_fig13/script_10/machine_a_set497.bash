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
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_2 -p 54 -st topic497_0_1 -pt None -u 0.002004609300928273 > ./result_10chains/node497_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_2 -p 70 -st topic497_1_1 -pt None -u 0.06525195008421997 > ./result_10chains/node497_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_2 -p 173 -st topic497_2_1 -pt None -u 0.006630374343356338 > ./result_10chains/node497_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_2 -p 225 -st topic497_3_1 -pt None -u 0.0015538486040742039 > ./result_10chains/node497_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_2 -p 240 -st topic497_4_1 -pt None -u 0.01550167620727469 > ./result_10chains/node497_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_2 -p 332 -st topic497_5_1 -pt None -u 5.170804847740018e-05 > ./result_10chains/node497_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_6_2 -p 360 -st topic497_6_1 -pt None -u 0.010078876320184782 > ./result_10chains/node497_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_7_2 -p 478 -st topic497_7_1 -pt None -u 0.019216940747022807 > ./result_10chains/node497_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_8_2 -p 699 -st topic497_8_1 -pt None -u 0.01579092245069634 > ./result_10chains/node497_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_9_2 -p 797 -st topic497_9_1 -pt None -u 0.008850107283509162 > ./result_10chains/node497_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_0 -p 54 -st none -pt topic497_0_0 -u 0.011145150642534796 > ./result_10chains/node497_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_0 -p 70 -st none -pt topic497_1_0 -u 0.0031071132646181554 > ./result_10chains/node497_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_0 -p 173 -st none -pt topic497_2_0 -u 0.09696883837677794 > ./result_10chains/node497_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_0 -p 225 -st none -pt topic497_3_0 -u 0.01075208207974443 > ./result_10chains/node497_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_0 -p 240 -st none -pt topic497_4_0 -u 0.004013320291260308 > ./result_10chains/node497_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_0 -p 332 -st none -pt topic497_5_0 -u 0.0004759939984323447 > ./result_10chains/node497_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_6_0 -p 360 -st none -pt topic497_6_0 -u 0.01810296850245885 > ./result_10chains/node497_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_7_0 -p 478 -st none -pt topic497_7_0 -u 0.009859023382828819 > ./result_10chains/node497_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_8_0 -p 699 -st none -pt topic497_8_0 -u 0.059133955979442016 > ./result_10chains/node497_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_9_0 -p 797 -st none -pt topic497_9_0 -u 0.011098768035696188 > ./result_10chains/node497_9_0.txt &
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
    "./result_10chains/node497_0_0.txt 90"
    "./result_10chains/node497_0_2.txt 90"
    "./result_10chains/node497_1_0.txt 89"
    "./result_10chains/node497_1_2.txt 89"
    "./result_10chains/node497_2_0.txt 88"
    "./result_10chains/node497_2_2.txt 88"
    "./result_10chains/node497_3_0.txt 87"
    "./result_10chains/node497_3_2.txt 87"
    "./result_10chains/node497_4_0.txt 86"
    "./result_10chains/node497_4_2.txt 86"
    "./result_10chains/node497_5_0.txt 85"
    "./result_10chains/node497_5_2.txt 85"
    "./result_10chains/node497_6_0.txt 84"
    "./result_10chains/node497_6_2.txt 84"
    "./result_10chains/node497_7_0.txt 83"
    "./result_10chains/node497_7_2.txt 83"
    "./result_10chains/node497_8_0.txt 82"
    "./result_10chains/node497_8_2.txt 82"
    "./result_10chains/node497_9_0.txt 81"
    "./result_10chains/node497_9_2.txt 81"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
