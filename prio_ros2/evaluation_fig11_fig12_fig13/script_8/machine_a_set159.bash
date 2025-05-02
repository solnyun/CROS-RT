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
ros2 run evaluation_3_randomdag uunifast_node -n node159_0_2 -p 27 -st topic159_0_1 -pt None -u 0.046988526628965466 > ./result_8chains/node159_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_1_2 -p 182 -st topic159_1_1 -pt None -u 0.0013252264265406488 > ./result_8chains/node159_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_2_2 -p 236 -st topic159_2_1 -pt None -u 0.011758035979628934 > ./result_8chains/node159_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_3_2 -p 461 -st topic159_3_1 -pt None -u 0.015166905932565644 > ./result_8chains/node159_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_4_2 -p 613 -st topic159_4_1 -pt None -u 0.019333329199900412 > ./result_8chains/node159_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_5_2 -p 624 -st topic159_5_1 -pt None -u 0.08607933872376497 > ./result_8chains/node159_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_6_2 -p 793 -st topic159_6_1 -pt None -u 0.04213988430118117 > ./result_8chains/node159_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_7_2 -p 904 -st topic159_7_1 -pt None -u 0.016519254514029205 > ./result_8chains/node159_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_0_0 -p 27 -st none -pt topic159_0_0 -u 0.045841795223357906 > ./result_8chains/node159_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_1_0 -p 182 -st none -pt topic159_1_0 -u 0.002431953270100373 > ./result_8chains/node159_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_2_0 -p 236 -st none -pt topic159_2_0 -u 0.003735484355293306 > ./result_8chains/node159_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_3_0 -p 461 -st none -pt topic159_3_0 -u 0.019468503628375933 > ./result_8chains/node159_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_4_0 -p 613 -st none -pt topic159_4_0 -u 0.013272276108730996 > ./result_8chains/node159_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_5_0 -p 624 -st none -pt topic159_5_0 -u 0.0017926896321651675 > ./result_8chains/node159_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_6_0 -p 793 -st none -pt topic159_6_0 -u 0.03516954635337109 > ./result_8chains/node159_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_7_0 -p 904 -st none -pt topic159_7_0 -u 0.011318576036062546 > ./result_8chains/node159_7_0.txt &
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
    "./result_8chains/node159_0_0.txt 90"
    "./result_8chains/node159_0_2.txt 90"
    "./result_8chains/node159_1_0.txt 89"
    "./result_8chains/node159_1_2.txt 89"
    "./result_8chains/node159_2_0.txt 88"
    "./result_8chains/node159_2_2.txt 88"
    "./result_8chains/node159_3_0.txt 87"
    "./result_8chains/node159_3_2.txt 87"
    "./result_8chains/node159_4_0.txt 86"
    "./result_8chains/node159_4_2.txt 86"
    "./result_8chains/node159_5_0.txt 85"
    "./result_8chains/node159_5_2.txt 85"
    "./result_8chains/node159_6_0.txt 84"
    "./result_8chains/node159_6_2.txt 84"
    "./result_8chains/node159_7_0.txt 83"
    "./result_8chains/node159_7_2.txt 83"
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
