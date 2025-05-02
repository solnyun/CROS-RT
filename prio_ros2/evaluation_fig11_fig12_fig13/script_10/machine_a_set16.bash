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
ros2 run evaluation_3_randomdag uunifast_node -n node16_0_2 -p 49 -st topic16_0_1 -pt None -u 0.002833609265012471 > ./result_10chains/node16_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_1_2 -p 210 -st topic16_1_1 -pt None -u 0.000617914992110058 > ./result_10chains/node16_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_2_2 -p 268 -st topic16_2_1 -pt None -u 0.012241102552929983 > ./result_10chains/node16_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_3_2 -p 305 -st topic16_3_1 -pt None -u 0.016097864616786473 > ./result_10chains/node16_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_4_2 -p 629 -st topic16_4_1 -pt None -u 0.006402151626790198 > ./result_10chains/node16_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_5_2 -p 692 -st topic16_5_1 -pt None -u 0.008848542608376253 > ./result_10chains/node16_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_6_2 -p 700 -st topic16_6_1 -pt None -u 0.00995072302625924 > ./result_10chains/node16_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_7_2 -p 732 -st topic16_7_1 -pt None -u 0.0017371860494064806 > ./result_10chains/node16_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_8_2 -p 751 -st topic16_8_1 -pt None -u 0.023157967242640146 > ./result_10chains/node16_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_9_2 -p 963 -st topic16_9_1 -pt None -u 0.0023978899339729787 > ./result_10chains/node16_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_0_0 -p 49 -st none -pt topic16_0_0 -u 0.02533675346916925 > ./result_10chains/node16_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_1_0 -p 210 -st none -pt topic16_1_0 -u 0.015677988656367214 > ./result_10chains/node16_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_2_0 -p 268 -st none -pt topic16_2_0 -u 0.015128991487298238 > ./result_10chains/node16_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_3_0 -p 305 -st none -pt topic16_3_0 -u 0.026910725931788504 > ./result_10chains/node16_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_4_0 -p 629 -st none -pt topic16_4_0 -u 0.0007598247938239155 > ./result_10chains/node16_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_5_0 -p 692 -st none -pt topic16_5_0 -u 0.038276436728149676 > ./result_10chains/node16_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_6_0 -p 700 -st none -pt topic16_6_0 -u 0.055374484417789804 > ./result_10chains/node16_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_7_0 -p 732 -st none -pt topic16_7_0 -u 0.05339220456271347 > ./result_10chains/node16_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_8_0 -p 751 -st none -pt topic16_8_0 -u 0.018566682483550256 > ./result_10chains/node16_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_9_0 -p 963 -st none -pt topic16_9_0 -u 0.014409151314707925 > ./result_10chains/node16_9_0.txt &
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
    "./result_10chains/node16_0_0.txt 90"
    "./result_10chains/node16_0_2.txt 90"
    "./result_10chains/node16_1_0.txt 89"
    "./result_10chains/node16_1_2.txt 89"
    "./result_10chains/node16_2_0.txt 88"
    "./result_10chains/node16_2_2.txt 88"
    "./result_10chains/node16_3_0.txt 87"
    "./result_10chains/node16_3_2.txt 87"
    "./result_10chains/node16_4_0.txt 86"
    "./result_10chains/node16_4_2.txt 86"
    "./result_10chains/node16_5_0.txt 85"
    "./result_10chains/node16_5_2.txt 85"
    "./result_10chains/node16_6_0.txt 84"
    "./result_10chains/node16_6_2.txt 84"
    "./result_10chains/node16_7_0.txt 83"
    "./result_10chains/node16_7_2.txt 83"
    "./result_10chains/node16_8_0.txt 82"
    "./result_10chains/node16_8_2.txt 82"
    "./result_10chains/node16_9_0.txt 81"
    "./result_10chains/node16_9_2.txt 81"
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
