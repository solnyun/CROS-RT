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
ros2 run evaluation_3_randomdag uunifast_node -n node427_0_2 -p 39 -st topic427_0_1 -pt None -u 0.022908326779650157 > ./result_8chains/node427_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_1_2 -p 88 -st topic427_1_1 -pt None -u 0.0035288429414774836 > ./result_8chains/node427_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_2_2 -p 350 -st topic427_2_1 -pt None -u 0.024818627256297132 > ./result_8chains/node427_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_3_2 -p 584 -st topic427_3_1 -pt None -u 0.06850731461790194 > ./result_8chains/node427_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_4_2 -p 621 -st topic427_4_1 -pt None -u 0.012851603801668193 > ./result_8chains/node427_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_5_2 -p 651 -st topic427_5_1 -pt None -u 0.03442983572729222 > ./result_8chains/node427_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_6_2 -p 819 -st topic427_6_1 -pt None -u 0.010763032823126309 > ./result_8chains/node427_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_7_2 -p 947 -st topic427_7_1 -pt None -u 0.0021007438691359355 > ./result_8chains/node427_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_0_0 -p 39 -st none -pt topic427_0_0 -u 0.016185203220239253 > ./result_8chains/node427_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_1_0 -p 88 -st none -pt topic427_1_0 -u 0.007683445220286467 > ./result_8chains/node427_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_2_0 -p 350 -st none -pt topic427_2_0 -u 0.009710655625953246 > ./result_8chains/node427_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_3_0 -p 584 -st none -pt topic427_3_0 -u 0.0222657091298617 > ./result_8chains/node427_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_4_0 -p 621 -st none -pt topic427_4_0 -u 0.035457033638443575 > ./result_8chains/node427_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_5_0 -p 651 -st none -pt topic427_5_0 -u 0.008488832612985137 > ./result_8chains/node427_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_6_0 -p 819 -st none -pt topic427_6_0 -u 0.027681524657785908 > ./result_8chains/node427_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_7_0 -p 947 -st none -pt topic427_7_0 -u 0.004299433748176373 > ./result_8chains/node427_7_0.txt &
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
    "./result_8chains/node427_0_0.txt 90"
    "./result_8chains/node427_0_2.txt 90"
    "./result_8chains/node427_1_0.txt 89"
    "./result_8chains/node427_1_2.txt 89"
    "./result_8chains/node427_2_0.txt 88"
    "./result_8chains/node427_2_2.txt 88"
    "./result_8chains/node427_3_0.txt 87"
    "./result_8chains/node427_3_2.txt 87"
    "./result_8chains/node427_4_0.txt 86"
    "./result_8chains/node427_4_2.txt 86"
    "./result_8chains/node427_5_0.txt 85"
    "./result_8chains/node427_5_2.txt 85"
    "./result_8chains/node427_6_0.txt 84"
    "./result_8chains/node427_6_2.txt 84"
    "./result_8chains/node427_7_0.txt 83"
    "./result_8chains/node427_7_2.txt 83"
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
