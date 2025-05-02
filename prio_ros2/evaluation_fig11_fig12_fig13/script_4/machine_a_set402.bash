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
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_2 -p 136 -st topic402_0_1 -pt None -u 0.07901181144656799 > ./result_4chains/node402_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_2 -p 137 -st topic402_1_1 -pt None -u 0.003980585793080416 > ./result_4chains/node402_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_2 -p 608 -st topic402_2_1 -pt None -u 0.06498135433959212 > ./result_4chains/node402_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_2 -p 630 -st topic402_3_1 -pt None -u 0.008751603632605132 > ./result_4chains/node402_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_0 -p 136 -st none -pt topic402_0_0 -u 0.014635043689206706 > ./result_4chains/node402_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_0 -p 137 -st none -pt topic402_1_0 -u 0.020229238280360384 > ./result_4chains/node402_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_0 -p 608 -st none -pt topic402_2_0 -u 0.02109418204233854 > ./result_4chains/node402_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_0 -p 630 -st none -pt topic402_3_0 -u 0.07839907146973726 > ./result_4chains/node402_3_0.txt &
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
    "./result_4chains/node402_0_0.txt 90"
    "./result_4chains/node402_0_2.txt 90"
    "./result_4chains/node402_1_0.txt 89"
    "./result_4chains/node402_1_2.txt 89"
    "./result_4chains/node402_2_0.txt 88"
    "./result_4chains/node402_2_2.txt 88"
    "./result_4chains/node402_3_0.txt 87"
    "./result_4chains/node402_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
