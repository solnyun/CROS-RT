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
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_2 -p 39 -st topic74_0_1 -pt None -u 0.033743268182580444 > ./result_10chains/node74_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_2 -p 72 -st topic74_1_1 -pt None -u 0.01229903658035969 > ./result_10chains/node74_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_2 -p 157 -st topic74_2_1 -pt None -u 0.001497014844872746 > ./result_10chains/node74_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_2 -p 324 -st topic74_3_1 -pt None -u 0.015513330181734952 > ./result_10chains/node74_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_2 -p 533 -st topic74_4_1 -pt None -u 0.003024138891566941 > ./result_10chains/node74_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_2 -p 651 -st topic74_5_1 -pt None -u 0.021725771121122173 > ./result_10chains/node74_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_6_2 -p 695 -st topic74_6_1 -pt None -u 0.002857137127302567 > ./result_10chains/node74_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_7_2 -p 859 -st topic74_7_1 -pt None -u 0.006960201322939855 > ./result_10chains/node74_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_8_2 -p 867 -st topic74_8_1 -pt None -u 0.00012442147703557727 > ./result_10chains/node74_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_9_2 -p 908 -st topic74_9_1 -pt None -u 0.012513128470340872 > ./result_10chains/node74_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_0 -p 39 -st none -pt topic74_0_0 -u 0.02210574595824577 > ./result_10chains/node74_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_0 -p 72 -st none -pt topic74_1_0 -u 0.0085149681588233 > ./result_10chains/node74_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_0 -p 157 -st none -pt topic74_2_0 -u 0.00283849569069089 > ./result_10chains/node74_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_0 -p 324 -st none -pt topic74_3_0 -u 0.04386416344098376 > ./result_10chains/node74_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_0 -p 533 -st none -pt topic74_4_0 -u 0.011384119080267041 > ./result_10chains/node74_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_0 -p 651 -st none -pt topic74_5_0 -u 0.058884508879276876 > ./result_10chains/node74_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_6_0 -p 695 -st none -pt topic74_6_0 -u 0.0035235581022791673 > ./result_10chains/node74_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_7_0 -p 859 -st none -pt topic74_7_0 -u 0.006496436266465844 > ./result_10chains/node74_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_8_0 -p 867 -st none -pt topic74_8_0 -u 0.017784324241979274 > ./result_10chains/node74_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_9_0 -p 908 -st none -pt topic74_9_0 -u 0.028160933848452696 > ./result_10chains/node74_9_0.txt &
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
    "./result_10chains/node74_0_0.txt 90"
    "./result_10chains/node74_0_2.txt 90"
    "./result_10chains/node74_1_0.txt 89"
    "./result_10chains/node74_1_2.txt 89"
    "./result_10chains/node74_2_0.txt 88"
    "./result_10chains/node74_2_2.txt 88"
    "./result_10chains/node74_3_0.txt 87"
    "./result_10chains/node74_3_2.txt 87"
    "./result_10chains/node74_4_0.txt 86"
    "./result_10chains/node74_4_2.txt 86"
    "./result_10chains/node74_5_0.txt 85"
    "./result_10chains/node74_5_2.txt 85"
    "./result_10chains/node74_6_0.txt 84"
    "./result_10chains/node74_6_2.txt 84"
    "./result_10chains/node74_7_0.txt 83"
    "./result_10chains/node74_7_2.txt 83"
    "./result_10chains/node74_8_0.txt 82"
    "./result_10chains/node74_8_2.txt 82"
    "./result_10chains/node74_9_0.txt 81"
    "./result_10chains/node74_9_2.txt 81"
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
