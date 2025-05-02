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
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_2 -p 168 -st topic41_0_1 -pt None -u 0.006787844170342006 > ./result_8chains/node41_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_2 -p 214 -st topic41_1_1 -pt None -u 0.040496059883684044 > ./result_8chains/node41_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_2 -p 272 -st topic41_2_1 -pt None -u 0.03459454722137256 > ./result_8chains/node41_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_2 -p 326 -st topic41_3_1 -pt None -u 0.08230364652085831 > ./result_8chains/node41_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_2 -p 365 -st topic41_4_1 -pt None -u 0.0008918061559237134 > ./result_8chains/node41_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_2 -p 533 -st topic41_5_1 -pt None -u 0.0035780745009856008 > ./result_8chains/node41_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_6_2 -p 554 -st topic41_6_1 -pt None -u 0.025928875850519256 > ./result_8chains/node41_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_7_2 -p 832 -st topic41_7_1 -pt None -u 0.02343722675914081 > ./result_8chains/node41_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_0_0 -p 168 -st none -pt topic41_0_0 -u 0.013404571293200274 > ./result_8chains/node41_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_1_0 -p 214 -st none -pt topic41_1_0 -u 0.02060983491951346 > ./result_8chains/node41_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_2_0 -p 272 -st none -pt topic41_2_0 -u 0.03501481621791125 > ./result_8chains/node41_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_3_0 -p 326 -st none -pt topic41_3_0 -u 0.01454326564684949 > ./result_8chains/node41_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_4_0 -p 365 -st none -pt topic41_4_0 -u 0.017234085797403986 > ./result_8chains/node41_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_5_0 -p 533 -st none -pt topic41_5_0 -u 0.014610310887549813 > ./result_8chains/node41_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node41_6_0 -p 554 -st none -pt topic41_6_0 -u 0.0023556651093500636 > ./result_8chains/node41_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node41_7_0 -p 832 -st none -pt topic41_7_0 -u 0.007534665664585494 > ./result_8chains/node41_7_0.txt &
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
    "./result_8chains/node41_0_0.txt 90"
    "./result_8chains/node41_0_2.txt 90"
    "./result_8chains/node41_1_0.txt 89"
    "./result_8chains/node41_1_2.txt 89"
    "./result_8chains/node41_2_0.txt 88"
    "./result_8chains/node41_2_2.txt 88"
    "./result_8chains/node41_3_0.txt 87"
    "./result_8chains/node41_3_2.txt 87"
    "./result_8chains/node41_4_0.txt 86"
    "./result_8chains/node41_4_2.txt 86"
    "./result_8chains/node41_5_0.txt 85"
    "./result_8chains/node41_5_2.txt 85"
    "./result_8chains/node41_6_0.txt 84"
    "./result_8chains/node41_6_2.txt 84"
    "./result_8chains/node41_7_0.txt 83"
    "./result_8chains/node41_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
