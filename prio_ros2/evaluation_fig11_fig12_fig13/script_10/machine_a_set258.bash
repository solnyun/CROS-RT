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
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_2 -p 190 -st topic258_0_1 -pt None -u 0.03758861389231427 > ./result_10chains/node258_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_2 -p 266 -st topic258_1_1 -pt None -u 0.024835060160918743 > ./result_10chains/node258_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_2 -p 353 -st topic258_2_1 -pt None -u 0.017243881266094663 > ./result_10chains/node258_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_2 -p 444 -st topic258_3_1 -pt None -u 0.00986659040527299 > ./result_10chains/node258_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_2 -p 560 -st topic258_4_1 -pt None -u 0.002634942370314697 > ./result_10chains/node258_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_2 -p 763 -st topic258_5_1 -pt None -u 0.0005778511053645685 > ./result_10chains/node258_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_6_2 -p 811 -st topic258_6_1 -pt None -u 0.06112551544012729 > ./result_10chains/node258_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_7_2 -p 848 -st topic258_7_1 -pt None -u 0.009214160663637186 > ./result_10chains/node258_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_8_2 -p 892 -st topic258_8_1 -pt None -u 0.012723663134148272 > ./result_10chains/node258_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_9_2 -p 901 -st topic258_9_1 -pt None -u 0.02377150044200712 > ./result_10chains/node258_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_0 -p 190 -st none -pt topic258_0_0 -u 0.003950258709656651 > ./result_10chains/node258_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_0 -p 266 -st none -pt topic258_1_0 -u 0.038920535245474064 > ./result_10chains/node258_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_0 -p 353 -st none -pt topic258_2_0 -u 0.018708213851558853 > ./result_10chains/node258_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_0 -p 444 -st none -pt topic258_3_0 -u 0.007038618719592826 > ./result_10chains/node258_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_0 -p 560 -st none -pt topic258_4_0 -u 0.013847590519064479 > ./result_10chains/node258_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_0 -p 763 -st none -pt topic258_5_0 -u 0.005478802809674499 > ./result_10chains/node258_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_6_0 -p 811 -st none -pt topic258_6_0 -u 0.006955676582300507 > ./result_10chains/node258_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_7_0 -p 848 -st none -pt topic258_7_0 -u 0.0009335841765663044 > ./result_10chains/node258_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_8_0 -p 892 -st none -pt topic258_8_0 -u 0.011453956765958256 > ./result_10chains/node258_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_9_0 -p 901 -st none -pt topic258_9_0 -u 0.018775912110548625 > ./result_10chains/node258_9_0.txt &
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
    "./result_10chains/node258_0_0.txt 90"
    "./result_10chains/node258_0_2.txt 90"
    "./result_10chains/node258_1_0.txt 89"
    "./result_10chains/node258_1_2.txt 89"
    "./result_10chains/node258_2_0.txt 88"
    "./result_10chains/node258_2_2.txt 88"
    "./result_10chains/node258_3_0.txt 87"
    "./result_10chains/node258_3_2.txt 87"
    "./result_10chains/node258_4_0.txt 86"
    "./result_10chains/node258_4_2.txt 86"
    "./result_10chains/node258_5_0.txt 85"
    "./result_10chains/node258_5_2.txt 85"
    "./result_10chains/node258_6_0.txt 84"
    "./result_10chains/node258_6_2.txt 84"
    "./result_10chains/node258_7_0.txt 83"
    "./result_10chains/node258_7_2.txt 83"
    "./result_10chains/node258_8_0.txt 82"
    "./result_10chains/node258_8_2.txt 82"
    "./result_10chains/node258_9_0.txt 81"
    "./result_10chains/node258_9_2.txt 81"
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
