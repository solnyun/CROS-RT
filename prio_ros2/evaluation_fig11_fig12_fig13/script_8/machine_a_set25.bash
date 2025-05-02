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
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_2 -p 158 -st topic25_0_1 -pt None -u 0.07686636681456677 > ./result_8chains/node25_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_2 -p 238 -st topic25_1_1 -pt None -u 0.00017276091115570047 > ./result_8chains/node25_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_2 -p 401 -st topic25_2_1 -pt None -u 0.002773410939279297 > ./result_8chains/node25_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_2 -p 424 -st topic25_3_1 -pt None -u 0.01329398197935 > ./result_8chains/node25_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_2 -p 562 -st topic25_4_1 -pt None -u 0.06490467803519828 > ./result_8chains/node25_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_2 -p 697 -st topic25_5_1 -pt None -u 0.010108216733405034 > ./result_8chains/node25_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_6_2 -p 786 -st topic25_6_1 -pt None -u 0.03736586739904106 > ./result_8chains/node25_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_7_2 -p 792 -st topic25_7_1 -pt None -u 0.03423686832460167 > ./result_8chains/node25_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_0 -p 158 -st none -pt topic25_0_0 -u 0.008658896829208174 > ./result_8chains/node25_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_0 -p 238 -st none -pt topic25_1_0 -u 0.02607862345093731 > ./result_8chains/node25_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_0 -p 401 -st none -pt topic25_2_0 -u 0.021090556567373908 > ./result_8chains/node25_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_0 -p 424 -st none -pt topic25_3_0 -u 0.014765497200780076 > ./result_8chains/node25_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_0 -p 562 -st none -pt topic25_4_0 -u 0.01730145241614106 > ./result_8chains/node25_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_0 -p 697 -st none -pt topic25_5_0 -u 0.006929452776226891 > ./result_8chains/node25_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_6_0 -p 786 -st none -pt topic25_6_0 -u 0.013366144353072526 > ./result_8chains/node25_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_7_0 -p 792 -st none -pt topic25_7_0 -u 0.006661794042284133 > ./result_8chains/node25_7_0.txt &
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
    "./result_8chains/node25_0_0.txt 90"
    "./result_8chains/node25_0_2.txt 90"
    "./result_8chains/node25_1_0.txt 89"
    "./result_8chains/node25_1_2.txt 89"
    "./result_8chains/node25_2_0.txt 88"
    "./result_8chains/node25_2_2.txt 88"
    "./result_8chains/node25_3_0.txt 87"
    "./result_8chains/node25_3_2.txt 87"
    "./result_8chains/node25_4_0.txt 86"
    "./result_8chains/node25_4_2.txt 86"
    "./result_8chains/node25_5_0.txt 85"
    "./result_8chains/node25_5_2.txt 85"
    "./result_8chains/node25_6_0.txt 84"
    "./result_8chains/node25_6_2.txt 84"
    "./result_8chains/node25_7_0.txt 83"
    "./result_8chains/node25_7_2.txt 83"
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
