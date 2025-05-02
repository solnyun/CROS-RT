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
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_2 -p 23 -st topic101_0_1 -pt None -u 0.014374166515423892 > ./result_10chains/node101_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_2 -p 130 -st topic101_1_1 -pt None -u 0.00014032668597063758 > ./result_10chains/node101_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_2 -p 298 -st topic101_2_1 -pt None -u 0.015891835927087983 > ./result_10chains/node101_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_2 -p 323 -st topic101_3_1 -pt None -u 0.025723566215044846 > ./result_10chains/node101_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_2 -p 350 -st topic101_4_1 -pt None -u 0.02005325350140791 > ./result_10chains/node101_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_2 -p 591 -st topic101_5_1 -pt None -u 0.049410443309129776 > ./result_10chains/node101_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_6_2 -p 743 -st topic101_6_1 -pt None -u 0.002485314710598485 > ./result_10chains/node101_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_7_2 -p 751 -st topic101_7_1 -pt None -u 0.025490241739109396 > ./result_10chains/node101_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_8_2 -p 820 -st topic101_8_1 -pt None -u 0.0024910984476236506 > ./result_10chains/node101_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_9_2 -p 940 -st topic101_9_1 -pt None -u 0.01641484410626501 > ./result_10chains/node101_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_0 -p 23 -st none -pt topic101_0_0 -u 0.035255630863996135 > ./result_10chains/node101_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_0 -p 130 -st none -pt topic101_1_0 -u 0.0003384724937683381 > ./result_10chains/node101_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_0 -p 298 -st none -pt topic101_2_0 -u 0.01716734533458314 > ./result_10chains/node101_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_0 -p 323 -st none -pt topic101_3_0 -u 0.006668760420558306 > ./result_10chains/node101_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_0 -p 350 -st none -pt topic101_4_0 -u 0.0038440900986349558 > ./result_10chains/node101_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_0 -p 591 -st none -pt topic101_5_0 -u 0.003995114132617883 > ./result_10chains/node101_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_6_0 -p 743 -st none -pt topic101_6_0 -u 0.027682754328038323 > ./result_10chains/node101_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_7_0 -p 751 -st none -pt topic101_7_0 -u 0.05871909966266445 > ./result_10chains/node101_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_8_0 -p 820 -st none -pt topic101_8_0 -u 0.00420720517194885 > ./result_10chains/node101_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node101_9_0 -p 940 -st none -pt topic101_9_0 -u 0.015997074739810043 > ./result_10chains/node101_9_0.txt &
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
    "./result_10chains/node101_0_0.txt 90"
    "./result_10chains/node101_0_2.txt 90"
    "./result_10chains/node101_1_0.txt 89"
    "./result_10chains/node101_1_2.txt 89"
    "./result_10chains/node101_2_0.txt 88"
    "./result_10chains/node101_2_2.txt 88"
    "./result_10chains/node101_3_0.txt 87"
    "./result_10chains/node101_3_2.txt 87"
    "./result_10chains/node101_4_0.txt 86"
    "./result_10chains/node101_4_2.txt 86"
    "./result_10chains/node101_5_0.txt 85"
    "./result_10chains/node101_5_2.txt 85"
    "./result_10chains/node101_6_0.txt 84"
    "./result_10chains/node101_6_2.txt 84"
    "./result_10chains/node101_7_0.txt 83"
    "./result_10chains/node101_7_2.txt 83"
    "./result_10chains/node101_8_0.txt 82"
    "./result_10chains/node101_8_2.txt 82"
    "./result_10chains/node101_9_0.txt 81"
    "./result_10chains/node101_9_2.txt 81"
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
