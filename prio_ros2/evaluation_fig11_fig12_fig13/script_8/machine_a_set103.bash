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
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_2 -p 98 -st topic103_0_1 -pt None -u 0.032816070622036675 > ./result_8chains/node103_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_2 -p 176 -st topic103_1_1 -pt None -u 0.020373057532803773 > ./result_8chains/node103_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_2 -p 246 -st topic103_2_1 -pt None -u 0.004925543718180214 > ./result_8chains/node103_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_2 -p 259 -st topic103_3_1 -pt None -u 0.01054928958810658 > ./result_8chains/node103_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_2 -p 430 -st topic103_4_1 -pt None -u 0.0013438082998255274 > ./result_8chains/node103_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_2 -p 598 -st topic103_5_1 -pt None -u 0.009590381295229072 > ./result_8chains/node103_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_6_2 -p 763 -st topic103_6_1 -pt None -u 0.03207355978511997 > ./result_8chains/node103_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_7_2 -p 848 -st topic103_7_1 -pt None -u 0.034896471817155 > ./result_8chains/node103_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_0 -p 98 -st none -pt topic103_0_0 -u 0.021703812644789877 > ./result_8chains/node103_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_0 -p 176 -st none -pt topic103_1_0 -u 0.02242151889456523 > ./result_8chains/node103_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_0 -p 246 -st none -pt topic103_2_0 -u 0.029405888278861314 > ./result_8chains/node103_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_0 -p 259 -st none -pt topic103_3_0 -u 0.001218893138445809 > ./result_8chains/node103_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_0 -p 430 -st none -pt topic103_4_0 -u 0.0008219630079535079 > ./result_8chains/node103_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_0 -p 598 -st none -pt topic103_5_0 -u 0.004458015656199132 > ./result_8chains/node103_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_6_0 -p 763 -st none -pt topic103_6_0 -u 0.04057598747889185 > ./result_8chains/node103_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node103_7_0 -p 848 -st none -pt topic103_7_0 -u 0.027266358461675556 > ./result_8chains/node103_7_0.txt &
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
    "./result_8chains/node103_0_0.txt 90"
    "./result_8chains/node103_0_2.txt 90"
    "./result_8chains/node103_1_0.txt 89"
    "./result_8chains/node103_1_2.txt 89"
    "./result_8chains/node103_2_0.txt 88"
    "./result_8chains/node103_2_2.txt 88"
    "./result_8chains/node103_3_0.txt 87"
    "./result_8chains/node103_3_2.txt 87"
    "./result_8chains/node103_4_0.txt 86"
    "./result_8chains/node103_4_2.txt 86"
    "./result_8chains/node103_5_0.txt 85"
    "./result_8chains/node103_5_2.txt 85"
    "./result_8chains/node103_6_0.txt 84"
    "./result_8chains/node103_6_2.txt 84"
    "./result_8chains/node103_7_0.txt 83"
    "./result_8chains/node103_7_2.txt 83"
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
