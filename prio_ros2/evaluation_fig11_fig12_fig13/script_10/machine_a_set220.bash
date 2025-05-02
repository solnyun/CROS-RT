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
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_2 -p 31 -st topic220_0_1 -pt None -u 0.04968921972326312 > ./result_10chains/node220_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_2 -p 36 -st topic220_1_1 -pt None -u 0.006494435054114622 > ./result_10chains/node220_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_2 -p 99 -st topic220_2_1 -pt None -u 0.03734360495866956 > ./result_10chains/node220_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_2 -p 251 -st topic220_3_1 -pt None -u 7.961209139201175e-05 > ./result_10chains/node220_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_2 -p 413 -st topic220_4_1 -pt None -u 0.006377542042110829 > ./result_10chains/node220_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_2 -p 555 -st topic220_5_1 -pt None -u 0.03832665962070003 > ./result_10chains/node220_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_6_2 -p 568 -st topic220_6_1 -pt None -u 0.030579114173699656 > ./result_10chains/node220_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_7_2 -p 727 -st topic220_7_1 -pt None -u 0.006048771013616144 > ./result_10chains/node220_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_8_2 -p 948 -st topic220_8_1 -pt None -u 0.004325301740045615 > ./result_10chains/node220_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_9_2 -p 981 -st topic220_9_1 -pt None -u 0.0023023891291846657 > ./result_10chains/node220_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_0 -p 31 -st none -pt topic220_0_0 -u 0.013401981316625289 > ./result_10chains/node220_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_0 -p 36 -st none -pt topic220_1_0 -u 0.027685656627893962 > ./result_10chains/node220_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_0 -p 99 -st none -pt topic220_2_0 -u 0.0057500467816047895 > ./result_10chains/node220_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_0 -p 251 -st none -pt topic220_3_0 -u 0.010888160177435935 > ./result_10chains/node220_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_0 -p 413 -st none -pt topic220_4_0 -u 0.00871756795652573 > ./result_10chains/node220_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_0 -p 555 -st none -pt topic220_5_0 -u 0.018628572273656885 > ./result_10chains/node220_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_6_0 -p 568 -st none -pt topic220_6_0 -u 0.002892648145381843 > ./result_10chains/node220_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_7_0 -p 727 -st none -pt topic220_7_0 -u 0.006786555583365425 > ./result_10chains/node220_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_8_0 -p 948 -st none -pt topic220_8_0 -u 0.05491471341112619 > ./result_10chains/node220_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_9_0 -p 981 -st none -pt topic220_9_0 -u 0.0008759764896984976 > ./result_10chains/node220_9_0.txt &
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
    "./result_10chains/node220_0_0.txt 90"
    "./result_10chains/node220_0_2.txt 90"
    "./result_10chains/node220_1_0.txt 89"
    "./result_10chains/node220_1_2.txt 89"
    "./result_10chains/node220_2_0.txt 88"
    "./result_10chains/node220_2_2.txt 88"
    "./result_10chains/node220_3_0.txt 87"
    "./result_10chains/node220_3_2.txt 87"
    "./result_10chains/node220_4_0.txt 86"
    "./result_10chains/node220_4_2.txt 86"
    "./result_10chains/node220_5_0.txt 85"
    "./result_10chains/node220_5_2.txt 85"
    "./result_10chains/node220_6_0.txt 84"
    "./result_10chains/node220_6_2.txt 84"
    "./result_10chains/node220_7_0.txt 83"
    "./result_10chains/node220_7_2.txt 83"
    "./result_10chains/node220_8_0.txt 82"
    "./result_10chains/node220_8_2.txt 82"
    "./result_10chains/node220_9_0.txt 81"
    "./result_10chains/node220_9_2.txt 81"
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
