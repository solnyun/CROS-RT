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
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_2 -p 81 -st topic97_0_1 -pt None -u 0.03425872149635445 > ./result_8chains/node97_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_2 -p 189 -st topic97_1_1 -pt None -u 0.00029858390209275276 > ./result_8chains/node97_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_2 -p 322 -st topic97_2_1 -pt None -u 0.006553866543689946 > ./result_8chains/node97_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_2 -p 489 -st topic97_3_1 -pt None -u 0.023674893728187152 > ./result_8chains/node97_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_2 -p 495 -st topic97_4_1 -pt None -u 0.038243954554577714 > ./result_8chains/node97_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_2 -p 698 -st topic97_5_1 -pt None -u 0.0004277631290067474 > ./result_8chains/node97_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_6_2 -p 847 -st topic97_6_1 -pt None -u 0.006162173135736568 > ./result_8chains/node97_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_7_2 -p 931 -st topic97_7_1 -pt None -u 0.0013102931102839412 > ./result_8chains/node97_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_0_0 -p 81 -st none -pt topic97_0_0 -u 0.009042628152618137 > ./result_8chains/node97_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_1_0 -p 189 -st none -pt topic97_1_0 -u 0.005941791107837324 > ./result_8chains/node97_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_2_0 -p 322 -st none -pt topic97_2_0 -u 0.09165888817931844 > ./result_8chains/node97_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_3_0 -p 489 -st none -pt topic97_3_0 -u 0.03619144527489959 > ./result_8chains/node97_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_4_0 -p 495 -st none -pt topic97_4_0 -u 0.05669835190213221 > ./result_8chains/node97_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_5_0 -p 698 -st none -pt topic97_5_0 -u 0.0005819621699555411 > ./result_8chains/node97_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node97_6_0 -p 847 -st none -pt topic97_6_0 -u 0.003416361117088318 > ./result_8chains/node97_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node97_7_0 -p 931 -st none -pt topic97_7_0 -u 0.08723574508430013 > ./result_8chains/node97_7_0.txt &
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
    "./result_8chains/node97_0_0.txt 90"
    "./result_8chains/node97_0_2.txt 90"
    "./result_8chains/node97_1_0.txt 89"
    "./result_8chains/node97_1_2.txt 89"
    "./result_8chains/node97_2_0.txt 88"
    "./result_8chains/node97_2_2.txt 88"
    "./result_8chains/node97_3_0.txt 87"
    "./result_8chains/node97_3_2.txt 87"
    "./result_8chains/node97_4_0.txt 86"
    "./result_8chains/node97_4_2.txt 86"
    "./result_8chains/node97_5_0.txt 85"
    "./result_8chains/node97_5_2.txt 85"
    "./result_8chains/node97_6_0.txt 84"
    "./result_8chains/node97_6_2.txt 84"
    "./result_8chains/node97_7_0.txt 83"
    "./result_8chains/node97_7_2.txt 83"
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
