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
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_2 -p 100 -st topic312_0_1 -pt None -u 0.01641298391375351 > ./result_10chains/node312_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_2 -p 111 -st topic312_1_1 -pt None -u 0.01584578298683753 > ./result_10chains/node312_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_2 -p 118 -st topic312_2_1 -pt None -u 0.012710127709653851 > ./result_10chains/node312_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_2 -p 184 -st topic312_3_1 -pt None -u 0.012976626374505362 > ./result_10chains/node312_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_2 -p 283 -st topic312_4_1 -pt None -u 0.010311199169807217 > ./result_10chains/node312_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_2 -p 477 -st topic312_5_1 -pt None -u 0.0025917532439823365 > ./result_10chains/node312_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_6_2 -p 623 -st topic312_6_1 -pt None -u 0.013265919388795983 > ./result_10chains/node312_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_7_2 -p 753 -st topic312_7_1 -pt None -u 0.0032205049497524285 > ./result_10chains/node312_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_8_2 -p 754 -st topic312_8_1 -pt None -u 0.004857251412871862 > ./result_10chains/node312_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_9_2 -p 924 -st topic312_9_1 -pt None -u 0.04889049325487694 > ./result_10chains/node312_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_0 -p 100 -st none -pt topic312_0_0 -u 0.027610181558386127 > ./result_10chains/node312_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_0 -p 111 -st none -pt topic312_1_0 -u 0.0017294936391242799 > ./result_10chains/node312_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_0 -p 118 -st none -pt topic312_2_0 -u 0.002834655441563416 > ./result_10chains/node312_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_0 -p 184 -st none -pt topic312_3_0 -u 0.0012771660776288996 > ./result_10chains/node312_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_0 -p 283 -st none -pt topic312_4_0 -u 0.05050984225597466 > ./result_10chains/node312_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_0 -p 477 -st none -pt topic312_5_0 -u 0.03854013497472797 > ./result_10chains/node312_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_6_0 -p 623 -st none -pt topic312_6_0 -u 0.033577744091004946 > ./result_10chains/node312_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_7_0 -p 753 -st none -pt topic312_7_0 -u 0.009256200638895234 > ./result_10chains/node312_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_8_0 -p 754 -st none -pt topic312_8_0 -u 0.06484783434023329 > ./result_10chains/node312_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_9_0 -p 924 -st none -pt topic312_9_0 -u 0.004459426243922836 > ./result_10chains/node312_9_0.txt &
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
    "./result_10chains/node312_0_0.txt 90"
    "./result_10chains/node312_0_2.txt 90"
    "./result_10chains/node312_1_0.txt 89"
    "./result_10chains/node312_1_2.txt 89"
    "./result_10chains/node312_2_0.txt 88"
    "./result_10chains/node312_2_2.txt 88"
    "./result_10chains/node312_3_0.txt 87"
    "./result_10chains/node312_3_2.txt 87"
    "./result_10chains/node312_4_0.txt 86"
    "./result_10chains/node312_4_2.txt 86"
    "./result_10chains/node312_5_0.txt 85"
    "./result_10chains/node312_5_2.txt 85"
    "./result_10chains/node312_6_0.txt 84"
    "./result_10chains/node312_6_2.txt 84"
    "./result_10chains/node312_7_0.txt 83"
    "./result_10chains/node312_7_2.txt 83"
    "./result_10chains/node312_8_0.txt 82"
    "./result_10chains/node312_8_2.txt 82"
    "./result_10chains/node312_9_0.txt 81"
    "./result_10chains/node312_9_2.txt 81"
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
