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
ros2 run evaluation_3_randomdag uunifast_node -n node113_0_2 -p 97 -st topic113_0_1 -pt None -u 0.0014561732160052188 > ./result_10chains/node113_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_1_2 -p 119 -st topic113_1_1 -pt None -u 0.005999854289786166 > ./result_10chains/node113_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_2_2 -p 121 -st topic113_2_1 -pt None -u 0.005764568935545944 > ./result_10chains/node113_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_3_2 -p 269 -st topic113_3_1 -pt None -u 0.007065202762364831 > ./result_10chains/node113_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_4_2 -p 352 -st topic113_4_1 -pt None -u 0.005328005960674453 > ./result_10chains/node113_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_5_2 -p 460 -st topic113_5_1 -pt None -u 0.024008103386733204 > ./result_10chains/node113_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_6_2 -p 526 -st topic113_6_1 -pt None -u 0.05609835808551594 > ./result_10chains/node113_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_7_2 -p 548 -st topic113_7_1 -pt None -u 0.016434396133401696 > ./result_10chains/node113_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_8_2 -p 731 -st topic113_8_1 -pt None -u 0.0028954922577596395 > ./result_10chains/node113_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_9_2 -p 876 -st topic113_9_1 -pt None -u 0.009540770422115298 > ./result_10chains/node113_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_0_0 -p 97 -st none -pt topic113_0_0 -u 0.04790297751043032 > ./result_10chains/node113_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_1_0 -p 119 -st none -pt topic113_1_0 -u 0.018835221619386666 > ./result_10chains/node113_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_2_0 -p 121 -st none -pt topic113_2_0 -u 0.00016895684080275863 > ./result_10chains/node113_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_3_0 -p 269 -st none -pt topic113_3_0 -u 0.02687691678810067 > ./result_10chains/node113_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_4_0 -p 352 -st none -pt topic113_4_0 -u 0.019255905020655106 > ./result_10chains/node113_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_5_0 -p 460 -st none -pt topic113_5_0 -u 0.03673090575150939 > ./result_10chains/node113_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_6_0 -p 526 -st none -pt topic113_6_0 -u 0.025146972194209055 > ./result_10chains/node113_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_7_0 -p 548 -st none -pt topic113_7_0 -u 0.010001022798269255 > ./result_10chains/node113_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_8_0 -p 731 -st none -pt topic113_8_0 -u 0.03049680943923079 > ./result_10chains/node113_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_9_0 -p 876 -st none -pt topic113_9_0 -u 0.014885928184410528 > ./result_10chains/node113_9_0.txt &
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
    "./result_10chains/node113_0_0.txt 90"
    "./result_10chains/node113_0_2.txt 90"
    "./result_10chains/node113_1_0.txt 89"
    "./result_10chains/node113_1_2.txt 89"
    "./result_10chains/node113_2_0.txt 88"
    "./result_10chains/node113_2_2.txt 88"
    "./result_10chains/node113_3_0.txt 87"
    "./result_10chains/node113_3_2.txt 87"
    "./result_10chains/node113_4_0.txt 86"
    "./result_10chains/node113_4_2.txt 86"
    "./result_10chains/node113_5_0.txt 85"
    "./result_10chains/node113_5_2.txt 85"
    "./result_10chains/node113_6_0.txt 84"
    "./result_10chains/node113_6_2.txt 84"
    "./result_10chains/node113_7_0.txt 83"
    "./result_10chains/node113_7_2.txt 83"
    "./result_10chains/node113_8_0.txt 82"
    "./result_10chains/node113_8_2.txt 82"
    "./result_10chains/node113_9_0.txt 81"
    "./result_10chains/node113_9_2.txt 81"
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
