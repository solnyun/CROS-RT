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
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_2 -p 50 -st topic198_0_1 -pt None -u 0.016181874780901384 > ./result_8chains/node198_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_2 -p 142 -st topic198_1_1 -pt None -u 0.023009482117309854 > ./result_8chains/node198_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_2 -p 170 -st topic198_2_1 -pt None -u 0.02322706716751416 > ./result_8chains/node198_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_2 -p 416 -st topic198_3_1 -pt None -u 0.02086485998824833 > ./result_8chains/node198_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_2 -p 609 -st topic198_4_1 -pt None -u 0.03233681849637393 > ./result_8chains/node198_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_2 -p 696 -st topic198_5_1 -pt None -u 0.010708920492510626 > ./result_8chains/node198_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_6_2 -p 738 -st topic198_6_1 -pt None -u 0.03767262270791246 > ./result_8chains/node198_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_7_2 -p 766 -st topic198_7_1 -pt None -u 0.012082847454930308 > ./result_8chains/node198_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_0 -p 50 -st none -pt topic198_0_0 -u 0.013150115371465265 > ./result_8chains/node198_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_0 -p 142 -st none -pt topic198_1_0 -u 0.057575273315278175 > ./result_8chains/node198_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_0 -p 170 -st none -pt topic198_2_0 -u 0.0009971695043013984 > ./result_8chains/node198_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_0 -p 416 -st none -pt topic198_3_0 -u 0.0412535788809576 > ./result_8chains/node198_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_0 -p 609 -st none -pt topic198_4_0 -u 0.006100175238072297 > ./result_8chains/node198_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_0 -p 696 -st none -pt topic198_5_0 -u 0.037943395529428714 > ./result_8chains/node198_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_6_0 -p 738 -st none -pt topic198_6_0 -u 0.013074265627341 > ./result_8chains/node198_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_7_0 -p 766 -st none -pt topic198_7_0 -u 0.0011002809004546227 > ./result_8chains/node198_7_0.txt &
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
    "./result_8chains/node198_0_0.txt 90"
    "./result_8chains/node198_0_2.txt 90"
    "./result_8chains/node198_1_0.txt 89"
    "./result_8chains/node198_1_2.txt 89"
    "./result_8chains/node198_2_0.txt 88"
    "./result_8chains/node198_2_2.txt 88"
    "./result_8chains/node198_3_0.txt 87"
    "./result_8chains/node198_3_2.txt 87"
    "./result_8chains/node198_4_0.txt 86"
    "./result_8chains/node198_4_2.txt 86"
    "./result_8chains/node198_5_0.txt 85"
    "./result_8chains/node198_5_2.txt 85"
    "./result_8chains/node198_6_0.txt 84"
    "./result_8chains/node198_6_2.txt 84"
    "./result_8chains/node198_7_0.txt 83"
    "./result_8chains/node198_7_2.txt 83"
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
