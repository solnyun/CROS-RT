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
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_2 -p 68 -st topic240_0_1 -pt None -u 0.054874434216545365 > ./result_8chains/node240_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_2 -p 244 -st topic240_1_1 -pt None -u 0.0011872058677602215 > ./result_8chains/node240_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_2 -p 279 -st topic240_2_1 -pt None -u 0.013114794832829957 > ./result_8chains/node240_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_2 -p 298 -st topic240_3_1 -pt None -u 0.004587472123502356 > ./result_8chains/node240_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_2 -p 785 -st topic240_4_1 -pt None -u 0.012430249914791663 > ./result_8chains/node240_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_2 -p 804 -st topic240_5_1 -pt None -u 0.0340860718233435 > ./result_8chains/node240_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_6_2 -p 868 -st topic240_6_1 -pt None -u 0.024579736814824685 > ./result_8chains/node240_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_7_2 -p 920 -st topic240_7_1 -pt None -u 0.029520453966563154 > ./result_8chains/node240_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_0 -p 68 -st none -pt topic240_0_0 -u 0.00525451849177655 > ./result_8chains/node240_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_0 -p 244 -st none -pt topic240_1_0 -u 0.0512643923445375 > ./result_8chains/node240_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_0 -p 279 -st none -pt topic240_2_0 -u 0.0005823850852109125 > ./result_8chains/node240_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_0 -p 298 -st none -pt topic240_3_0 -u 0.0057117769270120244 > ./result_8chains/node240_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_0 -p 785 -st none -pt topic240_4_0 -u 0.01600291375744911 > ./result_8chains/node240_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_0 -p 804 -st none -pt topic240_5_0 -u 0.037878627255786806 > ./result_8chains/node240_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_6_0 -p 868 -st none -pt topic240_6_0 -u 0.012958232243221207 > ./result_8chains/node240_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_7_0 -p 920 -st none -pt topic240_7_0 -u 0.03860765633009186 > ./result_8chains/node240_7_0.txt &
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
    "./result_8chains/node240_0_0.txt 90"
    "./result_8chains/node240_0_2.txt 90"
    "./result_8chains/node240_1_0.txt 89"
    "./result_8chains/node240_1_2.txt 89"
    "./result_8chains/node240_2_0.txt 88"
    "./result_8chains/node240_2_2.txt 88"
    "./result_8chains/node240_3_0.txt 87"
    "./result_8chains/node240_3_2.txt 87"
    "./result_8chains/node240_4_0.txt 86"
    "./result_8chains/node240_4_2.txt 86"
    "./result_8chains/node240_5_0.txt 85"
    "./result_8chains/node240_5_2.txt 85"
    "./result_8chains/node240_6_0.txt 84"
    "./result_8chains/node240_6_2.txt 84"
    "./result_8chains/node240_7_0.txt 83"
    "./result_8chains/node240_7_2.txt 83"
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
