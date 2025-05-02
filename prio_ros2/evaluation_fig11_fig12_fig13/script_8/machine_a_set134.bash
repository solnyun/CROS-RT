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
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_2 -p 52 -st topic134_0_1 -pt None -u 0.01787724481205427 > ./result_8chains/node134_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_2 -p 55 -st topic134_1_1 -pt None -u 0.01340814245030758 > ./result_8chains/node134_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_2 -p 59 -st topic134_2_1 -pt None -u 0.003307314605200562 > ./result_8chains/node134_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_2 -p 129 -st topic134_3_1 -pt None -u 0.052888994959288727 > ./result_8chains/node134_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_2 -p 200 -st topic134_4_1 -pt None -u 0.018830061235897227 > ./result_8chains/node134_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_2 -p 298 -st topic134_5_1 -pt None -u 0.005119957514858331 > ./result_8chains/node134_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_6_2 -p 485 -st topic134_6_1 -pt None -u 0.07767943243397325 > ./result_8chains/node134_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_7_2 -p 684 -st topic134_7_1 -pt None -u 0.0045592349081616905 > ./result_8chains/node134_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_0 -p 52 -st none -pt topic134_0_0 -u 0.009999368467025427 > ./result_8chains/node134_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_0 -p 55 -st none -pt topic134_1_0 -u 0.0019160351782151475 > ./result_8chains/node134_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_0 -p 59 -st none -pt topic134_2_0 -u 0.014367971731353457 > ./result_8chains/node134_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_0 -p 129 -st none -pt topic134_3_0 -u 0.012364002724144563 > ./result_8chains/node134_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_0 -p 200 -st none -pt topic134_4_0 -u 0.013746734345440381 > ./result_8chains/node134_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_0 -p 298 -st none -pt topic134_5_0 -u 0.00405402878414271 > ./result_8chains/node134_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_6_0 -p 485 -st none -pt topic134_6_0 -u 0.039644867461250205 > ./result_8chains/node134_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node134_7_0 -p 684 -st none -pt topic134_7_0 -u 0.0026965958567372675 > ./result_8chains/node134_7_0.txt &
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
    "./result_8chains/node134_0_0.txt 90"
    "./result_8chains/node134_0_2.txt 90"
    "./result_8chains/node134_1_0.txt 89"
    "./result_8chains/node134_1_2.txt 89"
    "./result_8chains/node134_2_0.txt 88"
    "./result_8chains/node134_2_2.txt 88"
    "./result_8chains/node134_3_0.txt 87"
    "./result_8chains/node134_3_2.txt 87"
    "./result_8chains/node134_4_0.txt 86"
    "./result_8chains/node134_4_2.txt 86"
    "./result_8chains/node134_5_0.txt 85"
    "./result_8chains/node134_5_2.txt 85"
    "./result_8chains/node134_6_0.txt 84"
    "./result_8chains/node134_6_2.txt 84"
    "./result_8chains/node134_7_0.txt 83"
    "./result_8chains/node134_7_2.txt 83"
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
