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
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_2 -p 38 -st topic185_0_1 -pt None -u 0.0029160676861619272 > ./result_10chains/node185_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_2 -p 80 -st topic185_1_1 -pt None -u 0.000671946952578828 > ./result_10chains/node185_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_2 -p 222 -st topic185_2_1 -pt None -u 0.0010533036158959508 > ./result_10chains/node185_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_2 -p 249 -st topic185_3_1 -pt None -u 0.046320097042920894 > ./result_10chains/node185_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_2 -p 529 -st topic185_4_1 -pt None -u 0.0008896425294735166 > ./result_10chains/node185_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_2 -p 542 -st topic185_5_1 -pt None -u 0.002686478526946423 > ./result_10chains/node185_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_6_2 -p 582 -st topic185_6_1 -pt None -u 0.08210425792683204 > ./result_10chains/node185_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_7_2 -p 625 -st topic185_7_1 -pt None -u 0.018954697876939576 > ./result_10chains/node185_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_8_2 -p 711 -st topic185_8_1 -pt None -u 0.009024982783111264 > ./result_10chains/node185_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_9_2 -p 831 -st topic185_9_1 -pt None -u 0.020351874816865276 > ./result_10chains/node185_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_0 -p 38 -st none -pt topic185_0_0 -u 0.011270973635032489 > ./result_10chains/node185_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_0 -p 80 -st none -pt topic185_1_0 -u 0.025687281353763358 > ./result_10chains/node185_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_0 -p 222 -st none -pt topic185_2_0 -u 0.006683399605219964 > ./result_10chains/node185_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_0 -p 249 -st none -pt topic185_3_0 -u 0.015903669918050145 > ./result_10chains/node185_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_0 -p 529 -st none -pt topic185_4_0 -u 0.041672322451763166 > ./result_10chains/node185_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_0 -p 542 -st none -pt topic185_5_0 -u 0.0224038385722036 > ./result_10chains/node185_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_6_0 -p 582 -st none -pt topic185_6_0 -u 0.00788029428382686 > ./result_10chains/node185_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_7_0 -p 625 -st none -pt topic185_7_0 -u 0.004858933322126974 > ./result_10chains/node185_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_8_0 -p 711 -st none -pt topic185_8_0 -u 0.0005972589872689296 > ./result_10chains/node185_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_9_0 -p 831 -st none -pt topic185_9_0 -u 0.0027800404285186556 > ./result_10chains/node185_9_0.txt &
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
    "./result_10chains/node185_0_0.txt 90"
    "./result_10chains/node185_0_2.txt 90"
    "./result_10chains/node185_1_0.txt 89"
    "./result_10chains/node185_1_2.txt 89"
    "./result_10chains/node185_2_0.txt 88"
    "./result_10chains/node185_2_2.txt 88"
    "./result_10chains/node185_3_0.txt 87"
    "./result_10chains/node185_3_2.txt 87"
    "./result_10chains/node185_4_0.txt 86"
    "./result_10chains/node185_4_2.txt 86"
    "./result_10chains/node185_5_0.txt 85"
    "./result_10chains/node185_5_2.txt 85"
    "./result_10chains/node185_6_0.txt 84"
    "./result_10chains/node185_6_2.txt 84"
    "./result_10chains/node185_7_0.txt 83"
    "./result_10chains/node185_7_2.txt 83"
    "./result_10chains/node185_8_0.txt 82"
    "./result_10chains/node185_8_2.txt 82"
    "./result_10chains/node185_9_0.txt 81"
    "./result_10chains/node185_9_2.txt 81"
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
