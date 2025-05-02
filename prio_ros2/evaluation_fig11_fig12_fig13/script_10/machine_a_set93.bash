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
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_2 -p 18 -st topic93_0_1 -pt None -u 0.03348126634983123 > ./result_10chains/node93_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_2 -p 89 -st topic93_1_1 -pt None -u 0.019910670421785515 > ./result_10chains/node93_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_2 -p 105 -st topic93_2_1 -pt None -u 0.01814785184348716 > ./result_10chains/node93_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_2 -p 329 -st topic93_3_1 -pt None -u 0.00920005384114514 > ./result_10chains/node93_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_2 -p 357 -st topic93_4_1 -pt None -u 0.0025245157362682458 > ./result_10chains/node93_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_2 -p 379 -st topic93_5_1 -pt None -u 0.004423836482012972 > ./result_10chains/node93_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_6_2 -p 505 -st topic93_6_1 -pt None -u 0.0034499114789714735 > ./result_10chains/node93_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_7_2 -p 725 -st topic93_7_1 -pt None -u 0.04925325669477605 > ./result_10chains/node93_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_8_2 -p 858 -st topic93_8_1 -pt None -u 0.0017249511547577367 > ./result_10chains/node93_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_9_2 -p 892 -st topic93_9_1 -pt None -u 0.009712265140752255 > ./result_10chains/node93_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_0_0 -p 18 -st none -pt topic93_0_0 -u 0.013095631383675421 > ./result_10chains/node93_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_1_0 -p 89 -st none -pt topic93_1_0 -u 0.012729715093795224 > ./result_10chains/node93_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_2_0 -p 105 -st none -pt topic93_2_0 -u 0.06520565373302373 > ./result_10chains/node93_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_3_0 -p 329 -st none -pt topic93_3_0 -u 0.017844995248236906 > ./result_10chains/node93_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_4_0 -p 357 -st none -pt topic93_4_0 -u 0.004493754728996657 > ./result_10chains/node93_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_5_0 -p 379 -st none -pt topic93_5_0 -u 0.0037840756059651093 > ./result_10chains/node93_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_6_0 -p 505 -st none -pt topic93_6_0 -u 0.020877271544401832 > ./result_10chains/node93_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_7_0 -p 725 -st none -pt topic93_7_0 -u 0.009082715550858989 > ./result_10chains/node93_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node93_8_0 -p 858 -st none -pt topic93_8_0 -u 0.0005584847382592156 > ./result_10chains/node93_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node93_9_0 -p 892 -st none -pt topic93_9_0 -u 0.019769115410607968 > ./result_10chains/node93_9_0.txt &
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
    "./result_10chains/node93_0_0.txt 90"
    "./result_10chains/node93_0_2.txt 90"
    "./result_10chains/node93_1_0.txt 89"
    "./result_10chains/node93_1_2.txt 89"
    "./result_10chains/node93_2_0.txt 88"
    "./result_10chains/node93_2_2.txt 88"
    "./result_10chains/node93_3_0.txt 87"
    "./result_10chains/node93_3_2.txt 87"
    "./result_10chains/node93_4_0.txt 86"
    "./result_10chains/node93_4_2.txt 86"
    "./result_10chains/node93_5_0.txt 85"
    "./result_10chains/node93_5_2.txt 85"
    "./result_10chains/node93_6_0.txt 84"
    "./result_10chains/node93_6_2.txt 84"
    "./result_10chains/node93_7_0.txt 83"
    "./result_10chains/node93_7_2.txt 83"
    "./result_10chains/node93_8_0.txt 82"
    "./result_10chains/node93_8_2.txt 82"
    "./result_10chains/node93_9_0.txt 81"
    "./result_10chains/node93_9_2.txt 81"
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
