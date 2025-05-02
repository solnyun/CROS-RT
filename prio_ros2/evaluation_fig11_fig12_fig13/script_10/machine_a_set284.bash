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
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_2 -p 132 -st topic284_0_1 -pt None -u 0.002017695561567334 > ./result_10chains/node284_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_2 -p 226 -st topic284_1_1 -pt None -u 0.010804363840049347 > ./result_10chains/node284_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_2 -p 267 -st topic284_2_1 -pt None -u 0.0073926602260854235 > ./result_10chains/node284_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_2 -p 294 -st topic284_3_1 -pt None -u 0.027976222317118826 > ./result_10chains/node284_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_2 -p 334 -st topic284_4_1 -pt None -u 0.007548615099011613 > ./result_10chains/node284_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_2 -p 534 -st topic284_5_1 -pt None -u 0.022877579601960907 > ./result_10chains/node284_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_6_2 -p 624 -st topic284_6_1 -pt None -u 0.00022740653207117822 > ./result_10chains/node284_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_7_2 -p 695 -st topic284_7_1 -pt None -u 0.00314095307178755 > ./result_10chains/node284_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_8_2 -p 734 -st topic284_8_1 -pt None -u 0.02017122620056616 > ./result_10chains/node284_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_9_2 -p 749 -st topic284_9_1 -pt None -u 0.023536199113500304 > ./result_10chains/node284_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_0 -p 132 -st none -pt topic284_0_0 -u 0.026286641180707115 > ./result_10chains/node284_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_0 -p 226 -st none -pt topic284_1_0 -u 0.002938768738807551 > ./result_10chains/node284_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_0 -p 267 -st none -pt topic284_2_0 -u 0.010377462686929129 > ./result_10chains/node284_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_0 -p 294 -st none -pt topic284_3_0 -u 0.006289841903165283 > ./result_10chains/node284_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_0 -p 334 -st none -pt topic284_4_0 -u 0.0010397563911815344 > ./result_10chains/node284_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_0 -p 534 -st none -pt topic284_5_0 -u 0.027920550384101517 > ./result_10chains/node284_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_6_0 -p 624 -st none -pt topic284_6_0 -u 0.0025307991390254303 > ./result_10chains/node284_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_7_0 -p 695 -st none -pt topic284_7_0 -u 0.011502117003327955 > ./result_10chains/node284_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_8_0 -p 734 -st none -pt topic284_8_0 -u 0.04386969877561525 > ./result_10chains/node284_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_9_0 -p 749 -st none -pt topic284_9_0 -u 0.03413884031225892 > ./result_10chains/node284_9_0.txt &
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
    "./result_10chains/node284_0_0.txt 90"
    "./result_10chains/node284_0_2.txt 90"
    "./result_10chains/node284_1_0.txt 89"
    "./result_10chains/node284_1_2.txt 89"
    "./result_10chains/node284_2_0.txt 88"
    "./result_10chains/node284_2_2.txt 88"
    "./result_10chains/node284_3_0.txt 87"
    "./result_10chains/node284_3_2.txt 87"
    "./result_10chains/node284_4_0.txt 86"
    "./result_10chains/node284_4_2.txt 86"
    "./result_10chains/node284_5_0.txt 85"
    "./result_10chains/node284_5_2.txt 85"
    "./result_10chains/node284_6_0.txt 84"
    "./result_10chains/node284_6_2.txt 84"
    "./result_10chains/node284_7_0.txt 83"
    "./result_10chains/node284_7_2.txt 83"
    "./result_10chains/node284_8_0.txt 82"
    "./result_10chains/node284_8_2.txt 82"
    "./result_10chains/node284_9_0.txt 81"
    "./result_10chains/node284_9_2.txt 81"
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
