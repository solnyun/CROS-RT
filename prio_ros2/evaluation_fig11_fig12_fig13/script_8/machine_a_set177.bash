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
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_2 -p 105 -st topic177_0_1 -pt None -u 0.010283700005742913 > ./result_8chains/node177_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_2 -p 249 -st topic177_1_1 -pt None -u 0.0424244217238568 > ./result_8chains/node177_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_2 -p 396 -st topic177_2_1 -pt None -u 0.003574616954350074 > ./result_8chains/node177_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_2 -p 428 -st topic177_3_1 -pt None -u 0.007269255400254637 > ./result_8chains/node177_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_2 -p 445 -st topic177_4_1 -pt None -u 0.02503599493053596 > ./result_8chains/node177_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_2 -p 452 -st topic177_5_1 -pt None -u 0.01699331341195015 > ./result_8chains/node177_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_6_2 -p 654 -st topic177_6_1 -pt None -u 0.03507873933264745 > ./result_8chains/node177_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_7_2 -p 683 -st topic177_7_1 -pt None -u 0.0030701443330113367 > ./result_8chains/node177_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_0_0 -p 105 -st none -pt topic177_0_0 -u 0.036422366689034924 > ./result_8chains/node177_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_1_0 -p 249 -st none -pt topic177_1_0 -u 0.008279860205226197 > ./result_8chains/node177_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_2_0 -p 396 -st none -pt topic177_2_0 -u 0.040143306528334866 > ./result_8chains/node177_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_3_0 -p 428 -st none -pt topic177_3_0 -u 0.04025974319179648 > ./result_8chains/node177_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_4_0 -p 445 -st none -pt topic177_4_0 -u 0.002587086629242563 > ./result_8chains/node177_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_5_0 -p 452 -st none -pt topic177_5_0 -u 0.0032104573714710205 > ./result_8chains/node177_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node177_6_0 -p 654 -st none -pt topic177_6_0 -u 0.007859511455578866 > ./result_8chains/node177_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node177_7_0 -p 683 -st none -pt topic177_7_0 -u 0.05813983982549274 > ./result_8chains/node177_7_0.txt &
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
    "./result_8chains/node177_0_0.txt 90"
    "./result_8chains/node177_0_2.txt 90"
    "./result_8chains/node177_1_0.txt 89"
    "./result_8chains/node177_1_2.txt 89"
    "./result_8chains/node177_2_0.txt 88"
    "./result_8chains/node177_2_2.txt 88"
    "./result_8chains/node177_3_0.txt 87"
    "./result_8chains/node177_3_2.txt 87"
    "./result_8chains/node177_4_0.txt 86"
    "./result_8chains/node177_4_2.txt 86"
    "./result_8chains/node177_5_0.txt 85"
    "./result_8chains/node177_5_2.txt 85"
    "./result_8chains/node177_6_0.txt 84"
    "./result_8chains/node177_6_2.txt 84"
    "./result_8chains/node177_7_0.txt 83"
    "./result_8chains/node177_7_2.txt 83"
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
