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
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_2 -p 56 -st topic29_0_1 -pt None -u 0.002705956801764997 > ./result_10chains/node29_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_2 -p 93 -st topic29_1_1 -pt None -u 0.0034958391132615674 > ./result_10chains/node29_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_2 -p 100 -st topic29_2_1 -pt None -u 0.0005589611570626651 > ./result_10chains/node29_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_2 -p 241 -st topic29_3_1 -pt None -u 0.03513349446955488 > ./result_10chains/node29_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_2 -p 447 -st topic29_4_1 -pt None -u 0.0009596652656926885 > ./result_10chains/node29_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_2 -p 702 -st topic29_5_1 -pt None -u 0.005672692512890515 > ./result_10chains/node29_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_6_2 -p 831 -st topic29_6_1 -pt None -u 0.0687809683438535 > ./result_10chains/node29_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_7_2 -p 840 -st topic29_7_1 -pt None -u 0.0011357875408029988 > ./result_10chains/node29_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_8_2 -p 851 -st topic29_8_1 -pt None -u 0.014280382634033733 > ./result_10chains/node29_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_9_2 -p 859 -st topic29_9_1 -pt None -u 0.013391780243574077 > ./result_10chains/node29_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_0 -p 56 -st none -pt topic29_0_0 -u 0.028438169507249866 > ./result_10chains/node29_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_0 -p 93 -st none -pt topic29_1_0 -u 0.0005064681277293093 > ./result_10chains/node29_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_0 -p 100 -st none -pt topic29_2_0 -u 0.020664167711428927 > ./result_10chains/node29_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_0 -p 241 -st none -pt topic29_3_0 -u 0.0037200839211120607 > ./result_10chains/node29_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_0 -p 447 -st none -pt topic29_4_0 -u 0.07363170323614582 > ./result_10chains/node29_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_0 -p 702 -st none -pt topic29_5_0 -u 0.013705637524773717 > ./result_10chains/node29_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_6_0 -p 831 -st none -pt topic29_6_0 -u 0.04717429583677857 > ./result_10chains/node29_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_7_0 -p 840 -st none -pt topic29_7_0 -u 0.025361374446201318 > ./result_10chains/node29_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_8_0 -p 851 -st none -pt topic29_8_0 -u 0.01775235823018044 > ./result_10chains/node29_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_9_0 -p 859 -st none -pt topic29_9_0 -u 0.006722654770737503 > ./result_10chains/node29_9_0.txt &
sleep 10
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
    "./result_10chains/node29_0_0.txt 90"
    "./result_10chains/node29_0_2.txt 90"
    "./result_10chains/node29_1_0.txt 89"
    "./result_10chains/node29_1_2.txt 89"
    "./result_10chains/node29_2_0.txt 88"
    "./result_10chains/node29_2_2.txt 88"
    "./result_10chains/node29_3_0.txt 87"
    "./result_10chains/node29_3_2.txt 87"
    "./result_10chains/node29_4_0.txt 86"
    "./result_10chains/node29_4_2.txt 86"
    "./result_10chains/node29_5_0.txt 85"
    "./result_10chains/node29_5_2.txt 85"
    "./result_10chains/node29_6_0.txt 84"
    "./result_10chains/node29_6_2.txt 84"
    "./result_10chains/node29_7_0.txt 83"
    "./result_10chains/node29_7_2.txt 83"
    "./result_10chains/node29_8_0.txt 82"
    "./result_10chains/node29_8_2.txt 82"
    "./result_10chains/node29_9_0.txt 81"
    "./result_10chains/node29_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
