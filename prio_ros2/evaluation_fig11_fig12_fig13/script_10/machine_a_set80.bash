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
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_2 -p 77 -st topic80_0_1 -pt None -u 0.03342360025337876 > ./result_10chains/node80_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_2 -p 180 -st topic80_1_1 -pt None -u 0.003763872737180707 > ./result_10chains/node80_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_2 -p 243 -st topic80_2_1 -pt None -u 0.0021170242347124946 > ./result_10chains/node80_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_2 -p 434 -st topic80_3_1 -pt None -u 0.03802330874463966 > ./result_10chains/node80_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_2 -p 521 -st topic80_4_1 -pt None -u 0.0097505769119266 > ./result_10chains/node80_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_2 -p 549 -st topic80_5_1 -pt None -u 0.00411940139171485 > ./result_10chains/node80_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_6_2 -p 586 -st topic80_6_1 -pt None -u 0.009981690437591312 > ./result_10chains/node80_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_7_2 -p 648 -st topic80_7_1 -pt None -u 0.010214724503118291 > ./result_10chains/node80_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_8_2 -p 674 -st topic80_8_1 -pt None -u 0.020822967569744527 > ./result_10chains/node80_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_9_2 -p 748 -st topic80_9_1 -pt None -u 0.020735580769883192 > ./result_10chains/node80_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_0 -p 77 -st none -pt topic80_0_0 -u 0.004686250482471899 > ./result_10chains/node80_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_0 -p 180 -st none -pt topic80_1_0 -u 0.04255976088871427 > ./result_10chains/node80_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_0 -p 243 -st none -pt topic80_2_0 -u 0.006660317801474469 > ./result_10chains/node80_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_0 -p 434 -st none -pt topic80_3_0 -u 0.0011179313970369198 > ./result_10chains/node80_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_0 -p 521 -st none -pt topic80_4_0 -u 0.041842307482395036 > ./result_10chains/node80_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_0 -p 549 -st none -pt topic80_5_0 -u 0.058364631827963837 > ./result_10chains/node80_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_6_0 -p 586 -st none -pt topic80_6_0 -u 0.021420734643393446 > ./result_10chains/node80_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_7_0 -p 648 -st none -pt topic80_7_0 -u 0.00011094603164099603 > ./result_10chains/node80_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_8_0 -p 674 -st none -pt topic80_8_0 -u 0.017731188008526716 > ./result_10chains/node80_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node80_9_0 -p 748 -st none -pt topic80_9_0 -u 0.004828860484691992 > ./result_10chains/node80_9_0.txt &
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
    "./result_10chains/node80_0_0.txt 90"
    "./result_10chains/node80_0_2.txt 90"
    "./result_10chains/node80_1_0.txt 89"
    "./result_10chains/node80_1_2.txt 89"
    "./result_10chains/node80_2_0.txt 88"
    "./result_10chains/node80_2_2.txt 88"
    "./result_10chains/node80_3_0.txt 87"
    "./result_10chains/node80_3_2.txt 87"
    "./result_10chains/node80_4_0.txt 86"
    "./result_10chains/node80_4_2.txt 86"
    "./result_10chains/node80_5_0.txt 85"
    "./result_10chains/node80_5_2.txt 85"
    "./result_10chains/node80_6_0.txt 84"
    "./result_10chains/node80_6_2.txt 84"
    "./result_10chains/node80_7_0.txt 83"
    "./result_10chains/node80_7_2.txt 83"
    "./result_10chains/node80_8_0.txt 82"
    "./result_10chains/node80_8_2.txt 82"
    "./result_10chains/node80_9_0.txt 81"
    "./result_10chains/node80_9_2.txt 81"
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
