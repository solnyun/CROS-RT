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
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_2 -p 71 -st topic71_0_1 -pt None -u 0.018736273784849322 > ./result_8chains/node71_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_2 -p 178 -st topic71_1_1 -pt None -u 0.05254571539582198 > ./result_8chains/node71_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_2 -p 451 -st topic71_2_1 -pt None -u 0.05603642193402117 > ./result_8chains/node71_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_2 -p 494 -st topic71_3_1 -pt None -u 0.0661051993824858 > ./result_8chains/node71_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_2 -p 587 -st topic71_4_1 -pt None -u 0.0033343667834496715 > ./result_8chains/node71_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_2 -p 625 -st topic71_5_1 -pt None -u 0.012393499195967564 > ./result_8chains/node71_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_6_2 -p 676 -st topic71_6_1 -pt None -u 0.042522865027529944 > ./result_8chains/node71_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_7_2 -p 987 -st topic71_7_1 -pt None -u 0.003672630394114324 > ./result_8chains/node71_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_0 -p 71 -st none -pt topic71_0_0 -u 0.04018687925655817 > ./result_8chains/node71_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_0 -p 178 -st none -pt topic71_1_0 -u 0.010303807919063823 > ./result_8chains/node71_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_0 -p 451 -st none -pt topic71_2_0 -u 0.05353953739277739 > ./result_8chains/node71_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_0 -p 494 -st none -pt topic71_3_0 -u 0.0033841936014753493 > ./result_8chains/node71_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_0 -p 587 -st none -pt topic71_4_0 -u 0.018404947221139167 > ./result_8chains/node71_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_0 -p 625 -st none -pt topic71_5_0 -u 0.018562259937251288 > ./result_8chains/node71_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_6_0 -p 676 -st none -pt topic71_6_0 -u 0.015152722831779208 > ./result_8chains/node71_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_7_0 -p 987 -st none -pt topic71_7_0 -u 0.0054083361721822334 > ./result_8chains/node71_7_0.txt &
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
    "./result_8chains/node71_0_0.txt 90"
    "./result_8chains/node71_0_2.txt 90"
    "./result_8chains/node71_1_0.txt 89"
    "./result_8chains/node71_1_2.txt 89"
    "./result_8chains/node71_2_0.txt 88"
    "./result_8chains/node71_2_2.txt 88"
    "./result_8chains/node71_3_0.txt 87"
    "./result_8chains/node71_3_2.txt 87"
    "./result_8chains/node71_4_0.txt 86"
    "./result_8chains/node71_4_2.txt 86"
    "./result_8chains/node71_5_0.txt 85"
    "./result_8chains/node71_5_2.txt 85"
    "./result_8chains/node71_6_0.txt 84"
    "./result_8chains/node71_6_2.txt 84"
    "./result_8chains/node71_7_0.txt 83"
    "./result_8chains/node71_7_2.txt 83"
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
