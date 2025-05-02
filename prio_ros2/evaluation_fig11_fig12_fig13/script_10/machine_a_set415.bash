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
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_2 -p 91 -st topic415_0_1 -pt None -u 0.007637019157629266 > ./result_10chains/node415_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_2 -p 109 -st topic415_1_1 -pt None -u 0.0027211880435013547 > ./result_10chains/node415_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_2 -p 172 -st topic415_2_1 -pt None -u 0.029662444383430686 > ./result_10chains/node415_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_2 -p 400 -st topic415_3_1 -pt None -u 0.033395013131286455 > ./result_10chains/node415_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_2 -p 458 -st topic415_4_1 -pt None -u 0.023502923046114205 > ./result_10chains/node415_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_2 -p 503 -st topic415_5_1 -pt None -u 0.004421486271359271 > ./result_10chains/node415_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_6_2 -p 556 -st topic415_6_1 -pt None -u 0.004022770719595947 > ./result_10chains/node415_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_7_2 -p 606 -st topic415_7_1 -pt None -u 0.02211354987186425 > ./result_10chains/node415_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_8_2 -p 941 -st topic415_8_1 -pt None -u 0.005393393440740236 > ./result_10chains/node415_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_9_2 -p 951 -st topic415_9_1 -pt None -u 0.007633875433345665 > ./result_10chains/node415_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_0 -p 91 -st none -pt topic415_0_0 -u 0.018865269796943807 > ./result_10chains/node415_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_0 -p 109 -st none -pt topic415_1_0 -u 0.00389021569877418 > ./result_10chains/node415_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_0 -p 172 -st none -pt topic415_2_0 -u 0.013740707410544395 > ./result_10chains/node415_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_0 -p 400 -st none -pt topic415_3_0 -u 0.010172715066160798 > ./result_10chains/node415_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_0 -p 458 -st none -pt topic415_4_0 -u 0.006419963575807486 > ./result_10chains/node415_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_0 -p 503 -st none -pt topic415_5_0 -u 0.0570281077786676 > ./result_10chains/node415_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_6_0 -p 556 -st none -pt topic415_6_0 -u 0.01358890248127441 > ./result_10chains/node415_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_7_0 -p 606 -st none -pt topic415_7_0 -u 0.03791684339616412 > ./result_10chains/node415_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_8_0 -p 941 -st none -pt topic415_8_0 -u 0.009581651244671079 > ./result_10chains/node415_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_9_0 -p 951 -st none -pt topic415_9_0 -u 0.003157369687176826 > ./result_10chains/node415_9_0.txt &
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
    "./result_10chains/node415_0_0.txt 90"
    "./result_10chains/node415_0_2.txt 90"
    "./result_10chains/node415_1_0.txt 89"
    "./result_10chains/node415_1_2.txt 89"
    "./result_10chains/node415_2_0.txt 88"
    "./result_10chains/node415_2_2.txt 88"
    "./result_10chains/node415_3_0.txt 87"
    "./result_10chains/node415_3_2.txt 87"
    "./result_10chains/node415_4_0.txt 86"
    "./result_10chains/node415_4_2.txt 86"
    "./result_10chains/node415_5_0.txt 85"
    "./result_10chains/node415_5_2.txt 85"
    "./result_10chains/node415_6_0.txt 84"
    "./result_10chains/node415_6_2.txt 84"
    "./result_10chains/node415_7_0.txt 83"
    "./result_10chains/node415_7_2.txt 83"
    "./result_10chains/node415_8_0.txt 82"
    "./result_10chains/node415_8_2.txt 82"
    "./result_10chains/node415_9_0.txt 81"
    "./result_10chains/node415_9_2.txt 81"
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
