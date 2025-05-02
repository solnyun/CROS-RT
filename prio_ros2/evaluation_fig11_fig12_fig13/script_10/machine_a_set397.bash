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
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_2 -p 201 -st topic397_0_1 -pt None -u 0.00734992918177968 > ./result_10chains/node397_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_2 -p 231 -st topic397_1_1 -pt None -u 0.0007287288006613823 > ./result_10chains/node397_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_2 -p 316 -st topic397_2_1 -pt None -u 0.018917048759646005 > ./result_10chains/node397_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_2 -p 428 -st topic397_3_1 -pt None -u 0.006903141678778479 > ./result_10chains/node397_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_2 -p 596 -st topic397_4_1 -pt None -u 0.008520272351008717 > ./result_10chains/node397_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_2 -p 627 -st topic397_5_1 -pt None -u 0.0014228405518965648 > ./result_10chains/node397_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_6_2 -p 689 -st topic397_6_1 -pt None -u 0.021756370445276257 > ./result_10chains/node397_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_7_2 -p 690 -st topic397_7_1 -pt None -u 0.033427091282694346 > ./result_10chains/node397_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_8_2 -p 784 -st topic397_8_1 -pt None -u 0.037699741797577194 > ./result_10chains/node397_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_9_2 -p 872 -st topic397_9_1 -pt None -u 0.015728212077337867 > ./result_10chains/node397_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_0 -p 201 -st none -pt topic397_0_0 -u 0.018773157343970392 > ./result_10chains/node397_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_0 -p 231 -st none -pt topic397_1_0 -u 0.017368624556124312 > ./result_10chains/node397_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_0 -p 316 -st none -pt topic397_2_0 -u 0.021583527395300117 > ./result_10chains/node397_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_0 -p 428 -st none -pt topic397_3_0 -u 0.002522221004932046 > ./result_10chains/node397_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_0 -p 596 -st none -pt topic397_4_0 -u 0.009330964693635424 > ./result_10chains/node397_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_0 -p 627 -st none -pt topic397_5_0 -u 0.005200609513849763 > ./result_10chains/node397_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_6_0 -p 689 -st none -pt topic397_6_0 -u 0.03338610619686244 > ./result_10chains/node397_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_7_0 -p 690 -st none -pt topic397_7_0 -u 0.013726796252119505 > ./result_10chains/node397_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_8_0 -p 784 -st none -pt topic397_8_0 -u 0.014189341458646018 > ./result_10chains/node397_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node397_9_0 -p 872 -st none -pt topic397_9_0 -u 0.02374472139736273 > ./result_10chains/node397_9_0.txt &
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
    "./result_10chains/node397_0_0.txt 90"
    "./result_10chains/node397_0_2.txt 90"
    "./result_10chains/node397_1_0.txt 89"
    "./result_10chains/node397_1_2.txt 89"
    "./result_10chains/node397_2_0.txt 88"
    "./result_10chains/node397_2_2.txt 88"
    "./result_10chains/node397_3_0.txt 87"
    "./result_10chains/node397_3_2.txt 87"
    "./result_10chains/node397_4_0.txt 86"
    "./result_10chains/node397_4_2.txt 86"
    "./result_10chains/node397_5_0.txt 85"
    "./result_10chains/node397_5_2.txt 85"
    "./result_10chains/node397_6_0.txt 84"
    "./result_10chains/node397_6_2.txt 84"
    "./result_10chains/node397_7_0.txt 83"
    "./result_10chains/node397_7_2.txt 83"
    "./result_10chains/node397_8_0.txt 82"
    "./result_10chains/node397_8_2.txt 82"
    "./result_10chains/node397_9_0.txt 81"
    "./result_10chains/node397_9_2.txt 81"
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
