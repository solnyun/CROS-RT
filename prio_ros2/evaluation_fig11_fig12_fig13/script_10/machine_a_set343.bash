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
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_2 -p 148 -st topic343_0_1 -pt None -u 0.018972298341472793 > ./result_10chains/node343_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_2 -p 208 -st topic343_1_1 -pt None -u 0.0019225236773772192 > ./result_10chains/node343_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_2 -p 531 -st topic343_2_1 -pt None -u 0.06593904180690557 > ./result_10chains/node343_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_2 -p 653 -st topic343_3_1 -pt None -u 0.002032863086320058 > ./result_10chains/node343_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_2 -p 724 -st topic343_4_1 -pt None -u 0.015143760674004636 > ./result_10chains/node343_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_2 -p 790 -st topic343_5_1 -pt None -u 0.0007231816830197135 > ./result_10chains/node343_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_6_2 -p 797 -st topic343_6_1 -pt None -u 0.01014180145759544 > ./result_10chains/node343_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_7_2 -p 864 -st topic343_7_1 -pt None -u 0.021121568042282823 > ./result_10chains/node343_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_8_2 -p 985 -st topic343_8_1 -pt None -u 0.05366276354175504 > ./result_10chains/node343_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_9_2 -p 996 -st topic343_9_1 -pt None -u 0.005324869046050012 > ./result_10chains/node343_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_0 -p 148 -st none -pt topic343_0_0 -u 0.008608076815278254 > ./result_10chains/node343_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_0 -p 208 -st none -pt topic343_1_0 -u 0.0035322480590920247 > ./result_10chains/node343_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_0 -p 531 -st none -pt topic343_2_0 -u 0.003450406592525157 > ./result_10chains/node343_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_0 -p 653 -st none -pt topic343_3_0 -u 0.005999386494282666 > ./result_10chains/node343_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_0 -p 724 -st none -pt topic343_4_0 -u 0.0019206810631141047 > ./result_10chains/node343_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_0 -p 790 -st none -pt topic343_5_0 -u 0.014337142463962477 > ./result_10chains/node343_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_6_0 -p 797 -st none -pt topic343_6_0 -u 0.00954835563635728 > ./result_10chains/node343_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_7_0 -p 864 -st none -pt topic343_7_0 -u 0.0104250954036188 > ./result_10chains/node343_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_8_0 -p 985 -st none -pt topic343_8_0 -u 0.0375400854909711 > ./result_10chains/node343_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_9_0 -p 996 -st none -pt topic343_9_0 -u 0.010642678159939377 > ./result_10chains/node343_9_0.txt &
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
    "./result_10chains/node343_0_0.txt 90"
    "./result_10chains/node343_0_2.txt 90"
    "./result_10chains/node343_1_0.txt 89"
    "./result_10chains/node343_1_2.txt 89"
    "./result_10chains/node343_2_0.txt 88"
    "./result_10chains/node343_2_2.txt 88"
    "./result_10chains/node343_3_0.txt 87"
    "./result_10chains/node343_3_2.txt 87"
    "./result_10chains/node343_4_0.txt 86"
    "./result_10chains/node343_4_2.txt 86"
    "./result_10chains/node343_5_0.txt 85"
    "./result_10chains/node343_5_2.txt 85"
    "./result_10chains/node343_6_0.txt 84"
    "./result_10chains/node343_6_2.txt 84"
    "./result_10chains/node343_7_0.txt 83"
    "./result_10chains/node343_7_2.txt 83"
    "./result_10chains/node343_8_0.txt 82"
    "./result_10chains/node343_8_2.txt 82"
    "./result_10chains/node343_9_0.txt 81"
    "./result_10chains/node343_9_2.txt 81"
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
