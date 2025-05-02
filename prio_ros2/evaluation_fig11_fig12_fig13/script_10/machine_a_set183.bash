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
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_2 -p 59 -st topic183_0_1 -pt None -u 0.039226326076364004 > ./result_10chains/node183_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_2 -p 77 -st topic183_1_1 -pt None -u 0.010340220876808581 > ./result_10chains/node183_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_2 -p 155 -st topic183_2_1 -pt None -u 0.0200020178607771 > ./result_10chains/node183_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_2 -p 198 -st topic183_3_1 -pt None -u 0.001812159739771002 > ./result_10chains/node183_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_2 -p 293 -st topic183_4_1 -pt None -u 0.026212655014819147 > ./result_10chains/node183_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_2 -p 438 -st topic183_5_1 -pt None -u 0.012898634489345945 > ./result_10chains/node183_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_6_2 -p 475 -st topic183_6_1 -pt None -u 0.0016899837530192363 > ./result_10chains/node183_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_7_2 -p 581 -st topic183_7_1 -pt None -u 0.006238654672317462 > ./result_10chains/node183_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_8_2 -p 631 -st topic183_8_1 -pt None -u 0.018691211536941504 > ./result_10chains/node183_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_9_2 -p 775 -st topic183_9_1 -pt None -u 0.053158242872825195 > ./result_10chains/node183_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_0 -p 59 -st none -pt topic183_0_0 -u 0.002885567254735877 > ./result_10chains/node183_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_0 -p 77 -st none -pt topic183_1_0 -u 0.005744018627624747 > ./result_10chains/node183_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_0 -p 155 -st none -pt topic183_2_0 -u 0.014539759195418611 > ./result_10chains/node183_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_0 -p 198 -st none -pt topic183_3_0 -u 0.02684233769617017 > ./result_10chains/node183_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_0 -p 293 -st none -pt topic183_4_0 -u 0.023438240852717063 > ./result_10chains/node183_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_0 -p 438 -st none -pt topic183_5_0 -u 0.038838686910327935 > ./result_10chains/node183_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_6_0 -p 475 -st none -pt topic183_6_0 -u 0.0025844566456382223 > ./result_10chains/node183_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_7_0 -p 581 -st none -pt topic183_7_0 -u 0.01411912621047906 > ./result_10chains/node183_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_8_0 -p 631 -st none -pt topic183_8_0 -u 0.003619502933954799 > ./result_10chains/node183_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_9_0 -p 775 -st none -pt topic183_9_0 -u 0.018681248655788296 > ./result_10chains/node183_9_0.txt &
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
    "./result_10chains/node183_0_0.txt 90"
    "./result_10chains/node183_0_2.txt 90"
    "./result_10chains/node183_1_0.txt 89"
    "./result_10chains/node183_1_2.txt 89"
    "./result_10chains/node183_2_0.txt 88"
    "./result_10chains/node183_2_2.txt 88"
    "./result_10chains/node183_3_0.txt 87"
    "./result_10chains/node183_3_2.txt 87"
    "./result_10chains/node183_4_0.txt 86"
    "./result_10chains/node183_4_2.txt 86"
    "./result_10chains/node183_5_0.txt 85"
    "./result_10chains/node183_5_2.txt 85"
    "./result_10chains/node183_6_0.txt 84"
    "./result_10chains/node183_6_2.txt 84"
    "./result_10chains/node183_7_0.txt 83"
    "./result_10chains/node183_7_2.txt 83"
    "./result_10chains/node183_8_0.txt 82"
    "./result_10chains/node183_8_2.txt 82"
    "./result_10chains/node183_9_0.txt 81"
    "./result_10chains/node183_9_2.txt 81"
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
