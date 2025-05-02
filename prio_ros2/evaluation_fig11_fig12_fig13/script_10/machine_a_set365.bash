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
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_2 -p 35 -st topic365_0_1 -pt None -u 0.002712689683408487 > ./result_10chains/node365_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_2 -p 155 -st topic365_1_1 -pt None -u 0.060013474392562216 > ./result_10chains/node365_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_2 -p 156 -st topic365_2_1 -pt None -u 0.020275950176560642 > ./result_10chains/node365_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_2 -p 234 -st topic365_3_1 -pt None -u 0.0009762828387208655 > ./result_10chains/node365_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_2 -p 361 -st topic365_4_1 -pt None -u 0.0036803432243069922 > ./result_10chains/node365_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_2 -p 533 -st topic365_5_1 -pt None -u 0.001306131974238539 > ./result_10chains/node365_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_6_2 -p 567 -st topic365_6_1 -pt None -u 0.00542943039979768 > ./result_10chains/node365_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_7_2 -p 703 -st topic365_7_1 -pt None -u 0.01780901403255898 > ./result_10chains/node365_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_8_2 -p 767 -st topic365_8_1 -pt None -u 0.007464408608536109 > ./result_10chains/node365_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_9_2 -p 909 -st topic365_9_1 -pt None -u 0.03728641559839734 > ./result_10chains/node365_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_0 -p 35 -st none -pt topic365_0_0 -u 0.04342116858672118 > ./result_10chains/node365_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_0 -p 155 -st none -pt topic365_1_0 -u 0.015940400416050715 > ./result_10chains/node365_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_0 -p 156 -st none -pt topic365_2_0 -u 0.002982968635876715 > ./result_10chains/node365_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_0 -p 234 -st none -pt topic365_3_0 -u 0.029668293697730497 > ./result_10chains/node365_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_0 -p 361 -st none -pt topic365_4_0 -u 0.012277356743418066 > ./result_10chains/node365_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_0 -p 533 -st none -pt topic365_5_0 -u 0.023863701658403208 > ./result_10chains/node365_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_6_0 -p 567 -st none -pt topic365_6_0 -u 0.00520557914974254 > ./result_10chains/node365_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_7_0 -p 703 -st none -pt topic365_7_0 -u 0.01387607372164476 > ./result_10chains/node365_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_8_0 -p 767 -st none -pt topic365_8_0 -u 0.024136051177422763 > ./result_10chains/node365_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_9_0 -p 909 -st none -pt topic365_9_0 -u 0.005478790315283477 > ./result_10chains/node365_9_0.txt &
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
    "./result_10chains/node365_0_0.txt 90"
    "./result_10chains/node365_0_2.txt 90"
    "./result_10chains/node365_1_0.txt 89"
    "./result_10chains/node365_1_2.txt 89"
    "./result_10chains/node365_2_0.txt 88"
    "./result_10chains/node365_2_2.txt 88"
    "./result_10chains/node365_3_0.txt 87"
    "./result_10chains/node365_3_2.txt 87"
    "./result_10chains/node365_4_0.txt 86"
    "./result_10chains/node365_4_2.txt 86"
    "./result_10chains/node365_5_0.txt 85"
    "./result_10chains/node365_5_2.txt 85"
    "./result_10chains/node365_6_0.txt 84"
    "./result_10chains/node365_6_2.txt 84"
    "./result_10chains/node365_7_0.txt 83"
    "./result_10chains/node365_7_2.txt 83"
    "./result_10chains/node365_8_0.txt 82"
    "./result_10chains/node365_8_2.txt 82"
    "./result_10chains/node365_9_0.txt 81"
    "./result_10chains/node365_9_2.txt 81"
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
