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
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_2 -p 96 -st topic49_0_1 -pt None -u 0.008675115876605577 > ./result_8chains/node49_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_2 -p 201 -st topic49_1_1 -pt None -u 0.04425479579728725 > ./result_8chains/node49_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_2 -p 355 -st topic49_2_1 -pt None -u 0.001418672133165877 > ./result_8chains/node49_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_2 -p 536 -st topic49_3_1 -pt None -u 0.06110446159051658 > ./result_8chains/node49_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_2 -p 625 -st topic49_4_1 -pt None -u 0.0027358908564941165 > ./result_8chains/node49_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_2 -p 810 -st topic49_5_1 -pt None -u 0.0015091012209085403 > ./result_8chains/node49_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_6_2 -p 836 -st topic49_6_1 -pt None -u 0.008120206824517688 > ./result_8chains/node49_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_7_2 -p 990 -st topic49_7_1 -pt None -u 0.026077378221239213 > ./result_8chains/node49_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_0 -p 96 -st none -pt topic49_0_0 -u 0.002802978983747373 > ./result_8chains/node49_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_0 -p 201 -st none -pt topic49_1_0 -u 0.007258326277242544 > ./result_8chains/node49_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_0 -p 355 -st none -pt topic49_2_0 -u 0.00206949996013972 > ./result_8chains/node49_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_0 -p 536 -st none -pt topic49_3_0 -u 0.033605492771477175 > ./result_8chains/node49_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_0 -p 625 -st none -pt topic49_4_0 -u 0.051103186450363186 > ./result_8chains/node49_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_0 -p 810 -st none -pt topic49_5_0 -u 0.060021733538824645 > ./result_8chains/node49_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_6_0 -p 836 -st none -pt topic49_6_0 -u 0.019286755368934233 > ./result_8chains/node49_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_7_0 -p 990 -st none -pt topic49_7_0 -u 0.014144462774253762 > ./result_8chains/node49_7_0.txt &
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
    "./result_8chains/node49_0_0.txt 90"
    "./result_8chains/node49_0_2.txt 90"
    "./result_8chains/node49_1_0.txt 89"
    "./result_8chains/node49_1_2.txt 89"
    "./result_8chains/node49_2_0.txt 88"
    "./result_8chains/node49_2_2.txt 88"
    "./result_8chains/node49_3_0.txt 87"
    "./result_8chains/node49_3_2.txt 87"
    "./result_8chains/node49_4_0.txt 86"
    "./result_8chains/node49_4_2.txt 86"
    "./result_8chains/node49_5_0.txt 85"
    "./result_8chains/node49_5_2.txt 85"
    "./result_8chains/node49_6_0.txt 84"
    "./result_8chains/node49_6_2.txt 84"
    "./result_8chains/node49_7_0.txt 83"
    "./result_8chains/node49_7_2.txt 83"
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
