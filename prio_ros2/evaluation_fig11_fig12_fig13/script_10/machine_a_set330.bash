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
ros2 run evaluation_3_randomdag uunifast_node -n node330_0_2 -p 146 -st topic330_0_1 -pt None -u 0.021613821672072597 > ./result_10chains/node330_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_1_2 -p 245 -st topic330_1_1 -pt None -u 0.01435977206456912 > ./result_10chains/node330_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_2_2 -p 272 -st topic330_2_1 -pt None -u 0.02507164790835059 > ./result_10chains/node330_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_3_2 -p 285 -st topic330_3_1 -pt None -u 0.04165181392227202 > ./result_10chains/node330_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_4_2 -p 361 -st topic330_4_1 -pt None -u 0.010000854601607545 > ./result_10chains/node330_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_5_2 -p 367 -st topic330_5_1 -pt None -u 0.016042296333760142 > ./result_10chains/node330_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_6_2 -p 660 -st topic330_6_1 -pt None -u 0.02298863970095419 > ./result_10chains/node330_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_7_2 -p 760 -st topic330_7_1 -pt None -u 0.03239325032133124 > ./result_10chains/node330_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_8_2 -p 830 -st topic330_8_1 -pt None -u 0.003283763539531054 > ./result_10chains/node330_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_9_2 -p 842 -st topic330_9_1 -pt None -u 0.0058410418686864205 > ./result_10chains/node330_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_0_0 -p 146 -st none -pt topic330_0_0 -u 0.0014352409387198284 > ./result_10chains/node330_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_1_0 -p 245 -st none -pt topic330_1_0 -u 0.006415229706762449 > ./result_10chains/node330_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_2_0 -p 272 -st none -pt topic330_2_0 -u 0.014122026493772755 > ./result_10chains/node330_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_3_0 -p 285 -st none -pt topic330_3_0 -u 0.0133072337785069 > ./result_10chains/node330_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_4_0 -p 361 -st none -pt topic330_4_0 -u 0.002861679031399944 > ./result_10chains/node330_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_5_0 -p 367 -st none -pt topic330_5_0 -u 0.012704744789390154 > ./result_10chains/node330_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_6_0 -p 660 -st none -pt topic330_6_0 -u 0.029700173473927144 > ./result_10chains/node330_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_7_0 -p 760 -st none -pt topic330_7_0 -u 0.011028626479762965 > ./result_10chains/node330_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_8_0 -p 830 -st none -pt topic330_8_0 -u 0.0033942523965442423 > ./result_10chains/node330_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_9_0 -p 842 -st none -pt topic330_9_0 -u 0.02923604215503927 > ./result_10chains/node330_9_0.txt &
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
    "./result_10chains/node330_0_0.txt 90"
    "./result_10chains/node330_0_2.txt 90"
    "./result_10chains/node330_1_0.txt 89"
    "./result_10chains/node330_1_2.txt 89"
    "./result_10chains/node330_2_0.txt 88"
    "./result_10chains/node330_2_2.txt 88"
    "./result_10chains/node330_3_0.txt 87"
    "./result_10chains/node330_3_2.txt 87"
    "./result_10chains/node330_4_0.txt 86"
    "./result_10chains/node330_4_2.txt 86"
    "./result_10chains/node330_5_0.txt 85"
    "./result_10chains/node330_5_2.txt 85"
    "./result_10chains/node330_6_0.txt 84"
    "./result_10chains/node330_6_2.txt 84"
    "./result_10chains/node330_7_0.txt 83"
    "./result_10chains/node330_7_2.txt 83"
    "./result_10chains/node330_8_0.txt 82"
    "./result_10chains/node330_8_2.txt 82"
    "./result_10chains/node330_9_0.txt 81"
    "./result_10chains/node330_9_2.txt 81"
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
