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
ros2 run evaluation_3_randomdag uunifast_node -n node440_0_2 -p 22 -st topic440_0_1 -pt None -u 0.019351382345929258 > ./result_10chains/node440_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_1_2 -p 35 -st topic440_1_1 -pt None -u 0.036213188255587 > ./result_10chains/node440_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_2_2 -p 124 -st topic440_2_1 -pt None -u 0.023384110672972858 > ./result_10chains/node440_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_3_2 -p 208 -st topic440_3_1 -pt None -u 0.0012135511526502885 > ./result_10chains/node440_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_4_2 -p 755 -st topic440_4_1 -pt None -u 0.03239541116203287 > ./result_10chains/node440_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_5_2 -p 791 -st topic440_5_1 -pt None -u 0.007983389504012783 > ./result_10chains/node440_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_6_2 -p 845 -st topic440_6_1 -pt None -u 0.027777318005498916 > ./result_10chains/node440_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_7_2 -p 867 -st topic440_7_1 -pt None -u 0.012015107916032303 > ./result_10chains/node440_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_8_2 -p 894 -st topic440_8_1 -pt None -u 0.04058076058213375 > ./result_10chains/node440_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_9_2 -p 960 -st topic440_9_1 -pt None -u 0.006142897728427227 > ./result_10chains/node440_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_0_0 -p 22 -st none -pt topic440_0_0 -u 0.000458315932840736 > ./result_10chains/node440_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_1_0 -p 35 -st none -pt topic440_1_0 -u 0.023459965917959902 > ./result_10chains/node440_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_2_0 -p 124 -st none -pt topic440_2_0 -u 0.02675839020708587 > ./result_10chains/node440_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_3_0 -p 208 -st none -pt topic440_3_0 -u 0.024973280514035745 > ./result_10chains/node440_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_4_0 -p 755 -st none -pt topic440_4_0 -u 0.016843789634517464 > ./result_10chains/node440_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_5_0 -p 791 -st none -pt topic440_5_0 -u 0.016050326632855577 > ./result_10chains/node440_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_6_0 -p 845 -st none -pt topic440_6_0 -u 0.0014785264937063614 > ./result_10chains/node440_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_7_0 -p 867 -st none -pt topic440_7_0 -u 0.01736777412431073 > ./result_10chains/node440_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_8_0 -p 894 -st none -pt topic440_8_0 -u 0.003080562815708024 > ./result_10chains/node440_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_9_0 -p 960 -st none -pt topic440_9_0 -u 0.006806072833761766 > ./result_10chains/node440_9_0.txt &
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
    "./result_10chains/node440_0_0.txt 90"
    "./result_10chains/node440_0_2.txt 90"
    "./result_10chains/node440_1_0.txt 89"
    "./result_10chains/node440_1_2.txt 89"
    "./result_10chains/node440_2_0.txt 88"
    "./result_10chains/node440_2_2.txt 88"
    "./result_10chains/node440_3_0.txt 87"
    "./result_10chains/node440_3_2.txt 87"
    "./result_10chains/node440_4_0.txt 86"
    "./result_10chains/node440_4_2.txt 86"
    "./result_10chains/node440_5_0.txt 85"
    "./result_10chains/node440_5_2.txt 85"
    "./result_10chains/node440_6_0.txt 84"
    "./result_10chains/node440_6_2.txt 84"
    "./result_10chains/node440_7_0.txt 83"
    "./result_10chains/node440_7_2.txt 83"
    "./result_10chains/node440_8_0.txt 82"
    "./result_10chains/node440_8_2.txt 82"
    "./result_10chains/node440_9_0.txt 81"
    "./result_10chains/node440_9_2.txt 81"
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
