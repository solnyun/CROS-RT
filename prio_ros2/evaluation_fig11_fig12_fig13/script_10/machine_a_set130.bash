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
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_2 -p 143 -st topic130_0_1 -pt None -u 0.0246378193132904 > ./result_10chains/node130_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_2 -p 225 -st topic130_1_1 -pt None -u 0.0044744584738959925 > ./result_10chains/node130_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_2 -p 242 -st topic130_2_1 -pt None -u 0.012157678754886214 > ./result_10chains/node130_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_2 -p 317 -st topic130_3_1 -pt None -u 0.0036809948986171737 > ./result_10chains/node130_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_2 -p 347 -st topic130_4_1 -pt None -u 0.017571956879381234 > ./result_10chains/node130_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_2 -p 414 -st topic130_5_1 -pt None -u 0.023038625434858545 > ./result_10chains/node130_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_6_2 -p 541 -st topic130_6_1 -pt None -u 0.03021001713469537 > ./result_10chains/node130_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_7_2 -p 645 -st topic130_7_1 -pt None -u 0.007876375848057476 > ./result_10chains/node130_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_8_2 -p 647 -st topic130_8_1 -pt None -u 0.02604036296205537 > ./result_10chains/node130_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_9_2 -p 663 -st topic130_9_1 -pt None -u 0.02552086833228414 > ./result_10chains/node130_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_0_0 -p 143 -st none -pt topic130_0_0 -u 0.050812453568086446 > ./result_10chains/node130_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_1_0 -p 225 -st none -pt topic130_1_0 -u 0.007434823945761837 > ./result_10chains/node130_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_2_0 -p 242 -st none -pt topic130_2_0 -u 0.020892625090789763 > ./result_10chains/node130_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_3_0 -p 317 -st none -pt topic130_3_0 -u 0.011422605859438828 > ./result_10chains/node130_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_4_0 -p 347 -st none -pt topic130_4_0 -u 0.024008552300191333 > ./result_10chains/node130_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_5_0 -p 414 -st none -pt topic130_5_0 -u 0.011130079550820071 > ./result_10chains/node130_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_6_0 -p 541 -st none -pt topic130_6_0 -u 0.0011362746910909272 > ./result_10chains/node130_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_7_0 -p 645 -st none -pt topic130_7_0 -u 0.017241826467221194 > ./result_10chains/node130_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node130_8_0 -p 647 -st none -pt topic130_8_0 -u 0.01203993067115619 > ./result_10chains/node130_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node130_9_0 -p 663 -st none -pt topic130_9_0 -u 0.005980001317014844 > ./result_10chains/node130_9_0.txt &
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
    "./result_10chains/node130_0_0.txt 90"
    "./result_10chains/node130_0_2.txt 90"
    "./result_10chains/node130_1_0.txt 89"
    "./result_10chains/node130_1_2.txt 89"
    "./result_10chains/node130_2_0.txt 88"
    "./result_10chains/node130_2_2.txt 88"
    "./result_10chains/node130_3_0.txt 87"
    "./result_10chains/node130_3_2.txt 87"
    "./result_10chains/node130_4_0.txt 86"
    "./result_10chains/node130_4_2.txt 86"
    "./result_10chains/node130_5_0.txt 85"
    "./result_10chains/node130_5_2.txt 85"
    "./result_10chains/node130_6_0.txt 84"
    "./result_10chains/node130_6_2.txt 84"
    "./result_10chains/node130_7_0.txt 83"
    "./result_10chains/node130_7_2.txt 83"
    "./result_10chains/node130_8_0.txt 82"
    "./result_10chains/node130_8_2.txt 82"
    "./result_10chains/node130_9_0.txt 81"
    "./result_10chains/node130_9_2.txt 81"
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
