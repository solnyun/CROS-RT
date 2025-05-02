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
ros2 run evaluation_3_randomdag uunifast_node -n node209_0_2 -p 251 -st topic209_0_1 -pt None -u 0.07562293223283911 > ./result_10chains/node209_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_1_2 -p 313 -st topic209_1_1 -pt None -u 0.018086429110069024 > ./result_10chains/node209_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_2_2 -p 359 -st topic209_2_1 -pt None -u 0.044053580389869895 > ./result_10chains/node209_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_3_2 -p 370 -st topic209_3_1 -pt None -u 0.013809571611006433 > ./result_10chains/node209_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_4_2 -p 371 -st topic209_4_1 -pt None -u 0.006588799969460629 > ./result_10chains/node209_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_5_2 -p 534 -st topic209_5_1 -pt None -u 0.0037349322658563056 > ./result_10chains/node209_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_6_2 -p 641 -st topic209_6_1 -pt None -u 0.029571401577054124 > ./result_10chains/node209_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_7_2 -p 859 -st topic209_7_1 -pt None -u 0.022080291049660854 > ./result_10chains/node209_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_8_2 -p 905 -st topic209_8_1 -pt None -u 0.000828651991726952 > ./result_10chains/node209_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_9_2 -p 982 -st topic209_9_1 -pt None -u 0.005895222096393372 > ./result_10chains/node209_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_0_0 -p 251 -st none -pt topic209_0_0 -u 0.01435500075755658 > ./result_10chains/node209_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_1_0 -p 313 -st none -pt topic209_1_0 -u 0.002178744565302093 > ./result_10chains/node209_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_2_0 -p 359 -st none -pt topic209_2_0 -u 0.021139426592158006 > ./result_10chains/node209_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_3_0 -p 370 -st none -pt topic209_3_0 -u 0.031122951375485097 > ./result_10chains/node209_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_4_0 -p 371 -st none -pt topic209_4_0 -u 0.0035386857237147684 > ./result_10chains/node209_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_5_0 -p 534 -st none -pt topic209_5_0 -u 0.027528476317246225 > ./result_10chains/node209_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_6_0 -p 641 -st none -pt topic209_6_0 -u 0.006194348680960693 > ./result_10chains/node209_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_7_0 -p 859 -st none -pt topic209_7_0 -u 0.003602335218153549 > ./result_10chains/node209_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node209_8_0 -p 905 -st none -pt topic209_8_0 -u 0.0377125982219261 > ./result_10chains/node209_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node209_9_0 -p 982 -st none -pt topic209_9_0 -u 0.00323225571985368 > ./result_10chains/node209_9_0.txt &
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
    "./result_10chains/node209_0_0.txt 90"
    "./result_10chains/node209_0_2.txt 90"
    "./result_10chains/node209_1_0.txt 89"
    "./result_10chains/node209_1_2.txt 89"
    "./result_10chains/node209_2_0.txt 88"
    "./result_10chains/node209_2_2.txt 88"
    "./result_10chains/node209_3_0.txt 87"
    "./result_10chains/node209_3_2.txt 87"
    "./result_10chains/node209_4_0.txt 86"
    "./result_10chains/node209_4_2.txt 86"
    "./result_10chains/node209_5_0.txt 85"
    "./result_10chains/node209_5_2.txt 85"
    "./result_10chains/node209_6_0.txt 84"
    "./result_10chains/node209_6_2.txt 84"
    "./result_10chains/node209_7_0.txt 83"
    "./result_10chains/node209_7_2.txt 83"
    "./result_10chains/node209_8_0.txt 82"
    "./result_10chains/node209_8_2.txt 82"
    "./result_10chains/node209_9_0.txt 81"
    "./result_10chains/node209_9_2.txt 81"
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
